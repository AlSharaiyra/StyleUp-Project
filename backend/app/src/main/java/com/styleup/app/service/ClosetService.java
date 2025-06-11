package com.styleup.app.service;

import com.styleup.app.infra.PresignedUrlCache;
import com.styleup.app.infra.clients.FastApiClient;
import com.styleup.app.infra.exception.GenericException;
import com.styleup.app.infra.exception.ResourceNotFoundException;
import com.styleup.app.infra.exception.WasabiErrorException;
import com.styleup.app.model.FeaturesModel;
import com.styleup.app.model.ItemModel;
import com.styleup.app.model.ItemSpecification;
import com.styleup.app.model.mapper.ModelMapper;
import com.styleup.app.model.response.ItemResponse;
import com.styleup.app.repository.entity.Item;
import com.styleup.app.repository.entity.User;
import com.styleup.app.repository.entity.Closet;
import com.styleup.app.repository.repo.ItemRepository;
import com.styleup.app.repository.repo.UserRepository;
import com.styleup.app.repository.repo.ClosetRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;
import software.amazon.awssdk.services.s3.presigner.model.GetObjectPresignRequest;

import java.io.IOException;
import java.net.URL;
import java.time.Duration;
import java.util.List;
import java.util.UUID;

import static com.styleup.app.infra.constants.Constants.PRESIGNED_URL_EXPIRY;
import static com.styleup.app.infra.constants.ErrorCodes.*;

/**
 * A service that handles user`s closet operations.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 05/2025
 */
@Log4j2
@Service
@RequiredArgsConstructor
public class ClosetService {

    private final ItemRepository itemRepository;
    private final ClosetRepository closetRepository;
    private final UserRepository userRepository;
    private final ModelMapper modelMapper;
    private final S3Client s3Client;
    private final FastApiClient fastApiClient;
    private final PresignedUrlCache urlCache;
    private final HelperService helperService;

    @Value("${app.s3.bucket-name}")
    private String bucketName;

    @Value("${cloud.aws.s3.endpoint}")
    private String regionEndpoint;

    public List<ItemResponse> getAllItems(
            final String userId, final int page, final int size, final String sortDirection,
            final String season, final String subCategory) {

        User user = userRepository.findById(UUID.fromString(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + userId, USER_NOT_FOUND));

        Sort.Direction direction = Sort.Direction.fromOptionalString(sortDirection.toUpperCase()).orElse(Sort.Direction.ASC);
        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, "uploadedAt"));

        UUID closetId = user.getCloset().getId();

        Specification<Item> spec = ItemSpecification.hasClosetId(closetId);

        if (subCategory != null && !subCategory.isBlank()) {
            spec = spec.and(ItemSpecification.hasSubCategory(subCategory));
        }

        if (season != null && !season.isBlank()) {
            spec = spec.and(ItemSpecification.hasSeason(season));
        }

        Page<Item> itemPage = itemRepository.findAll(spec, pageable);

        if (itemPage.isEmpty()) {
            throw new ResourceNotFoundException("User`s closet is empty", EMPTY_CLOSET);
        }

        return helperService.getItemsResponsesWithPresignedUrls(itemPage.getContent());
    }


    public ItemModel uploadImage(final MultipartFile file, final String description, final String userId, final boolean withModel) {

        User user = userRepository.findById(UUID.fromString(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + userId, USER_NOT_FOUND));

        final String objectKey = user.getId() + "/" + file.getOriginalFilename();

        URL imageUrl = performUpload(file, objectKey);
        log.warn("Image URL: {}", imageUrl);

        final FeaturesModel features;
        Closet closet = user.getCloset();
        Item item = new Item();

        if (withModel) {
            try {
                features = fastApiClient.sendFileToFastApi(file.getBytes());
                item = modelMapper.populateItemFromFeaturesModel(features);
            } catch (IOException e) {
                throw new GenericException("Failed to extract features from image", FEATURE_EXTRACTION_FAILED);
            }
        }

        if (description != null && !description.isBlank()) {
            item.setDescription(description);
        }

        item.setObjectKey(objectKey);
        item.setCloset(closet);

        closet.getItems().add(item);
        closet.setNoOfItems(closet.getNoOfItems() + 1);

        closetRepository.save(closet);

        return modelMapper.toItemModel(item);
    }

    private URL performUpload(final MultipartFile file, final String objectKey) {

        try {
            PutObjectRequest request = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(objectKey)
                    .build();

            s3Client.putObject(request, RequestBody.fromInputStream(file.getInputStream(), file.getSize()));

        } catch (Exception ex) {
            throw new WasabiErrorException("An error happened while uploading image", IMG_UPLOAD_ERROR);
        }

        // As Image URL
        return helperService.generatePresignedUrl(objectKey, PRESIGNED_URL_EXPIRY);
    }


    public String deleteItem(final String userId, final String itemId) {

        Item item = itemRepository.findById(UUID.fromString(itemId))
                .orElseThrow(() -> new ResourceNotFoundException("Item not found with ID: " + itemId, ITEM_NOT_FOUND));

        if (!item.getCloset().getUser().getId().equals(UUID.fromString(userId))) {
            throw new GenericException("Not allowed to delete this item", ACTION_NOT_ALLOWED);
        }

        String imageUrl = regionEndpoint + "/" + bucketName + "/" + item.getObjectKey();

        try {
            performDelete(imageUrl);

            Closet closet = item.getCloset();
            closet.getItems().remove(item);
            closet.setNoOfItems(closet.getNoOfItems() - 1);

            itemRepository.delete(item);
            closetRepository.save(closet);

        } catch (Exception ex) {
            throw new WasabiErrorException("Failed to delete image from Wasabi", IMG_DELETE_ERROR);
        }

        return "Image deleted successfully";
    }


    private void performDelete(final String imageUrl) {

        String basePrefix = regionEndpoint + "/" + bucketName + "/";
        if (!imageUrl.startsWith(basePrefix)) {
            throw new IllegalArgumentException("Invalid image URL");
        }
        String key = imageUrl.substring(basePrefix.length());

        DeleteObjectRequest deleteRequest = DeleteObjectRequest.builder()
                .bucket(bucketName)
                .key(key)
                .build();

        s3Client.deleteObject(deleteRequest);
    }
}
