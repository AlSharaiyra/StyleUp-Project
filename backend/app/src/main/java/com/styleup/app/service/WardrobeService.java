package com.styleup.app.service;

import com.styleup.app.infra.clients.FastApiClient;
import com.styleup.app.infra.constants.ErrorCodes;
import com.styleup.app.infra.exception.GenericException;
import com.styleup.app.infra.exception.ResourceNotFoundException;
import com.styleup.app.model.FeaturesModel;
import com.styleup.app.model.ItemModel;
import com.styleup.app.model.mapper.ModelMapper;
import com.styleup.app.model.response.ItemResponse;
import com.styleup.app.repository.entity.Item;
import com.styleup.app.repository.entity.User;
import com.styleup.app.repository.entity.Wardrobe;
import com.styleup.app.repository.repo.ItemRepository;
import com.styleup.app.repository.repo.UserRepository;
import com.styleup.app.repository.repo.WardrobeRepository;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import static com.styleup.app.infra.constants.ErrorCodes.*;

/**
 * A Wardrobe service that handles user`s wardrobe operations.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 05/2025
 */
@Log4j2
@Service
@RequiredArgsConstructor
public class WardrobeService {

    private final WardrobeRepository wardrobeRepository;
    private final UserRepository userRepository;
    private final ModelMapper modelMapper;
    private final S3Client s3Client;
    private final FastApiClient fastApiClient;

    @Value("${app.s3.bucket-name}")
    private String bucketName;

    @Value("${cloud.aws.s3.endpoint}")
    private String regionEndpoint;

    public List<ItemResponse> getAllItems(final String userId) {

        User user = userRepository.findById(UUID.fromString(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + userId, USER_NOT_FOUND));

        List<Item> items = user.getWardrobe().getItems();

        if (items.isEmpty()) {
            throw new ResourceNotFoundException("User`s wardrobe is empty", EMPTY_WARDROBE);
        }

        return items.stream().map(modelMapper::toItemResponse).toList();
    }


    public ItemModel uploadImage(final MultipartFile file, final String description, final String userId) {

        User user = userRepository.findById(UUID.fromString(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + userId, USER_NOT_FOUND));

        String imageUrl = upload(file, String.valueOf(user.getId()));

        final FeaturesModel features;
        try {
            features = fastApiClient.sendFileToFastApi(file.getBytes());
        } catch (IOException e) {
            throw new GenericException("Failed to extract features from image", FEATURE_EXTRACTION_FAILED);
        }

        Wardrobe wardrobe = user.getWardrobe();
        Item item = modelMapper.populateItemFromFeaturesModel(features);

        if (!description.isEmpty()) {
            item.setDescription(description);
        }
        item.setUrl(imageUrl);
        item.setWardrobe(wardrobe);

        wardrobe.getItems().add(item);
        wardrobe.setNoOfItems(wardrobe.getNoOfItems() + 1);

        wardrobeRepository.save(wardrobe);

        return modelMapper.toItemModel(item);
    }

    public String upload(final MultipartFile file, final String userId){
        try {
            PutObjectRequest request = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(userId + "/" + file.getOriginalFilename())
                    .build();

            s3Client.putObject(request, RequestBody.fromInputStream(file.getInputStream(), file.getSize()));

        } catch (Exception ex) {
            throw new GenericException("An error happended while uploading image", IMG_UPLOAD_ERROR);
        }

        // As Image URL
        return regionEndpoint + "/" + bucketName + "/" + userId + "/" + file.getOriginalFilename();
    }

}
