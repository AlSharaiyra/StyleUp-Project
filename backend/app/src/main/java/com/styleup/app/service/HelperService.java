package com.styleup.app.service;

import com.styleup.app.infra.PresignedUrlCache;
import com.styleup.app.infra.exception.WasabiErrorException;
import com.styleup.app.model.enums.UserStatus;
import com.styleup.app.model.mapper.ModelMapper;
import com.styleup.app.model.response.ItemResponse;
import com.styleup.app.repository.entity.Item;
import com.styleup.app.repository.entity.User;
import com.styleup.app.repository.repo.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;
import software.amazon.awssdk.services.s3.presigner.model.GetObjectPresignRequest;

import java.net.URL;
import java.time.Duration;
import java.util.List;
import java.util.Optional;

import static com.styleup.app.infra.constants.Constants.PRESIGNED_URL_EXPIRY;
import static com.styleup.app.infra.constants.ErrorCodes.ERROR_CREATING_PRESIGNED_URL;

/**
 * A user helper service that handles user related operations.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@Log4j2
@RequiredArgsConstructor
@Service
public class HelperService {

    private final JwtService jwtService;
    private final UserRepository userRepository;
    private final PresignedUrlCache urlCache;
    private final ModelMapper modelMapper;
    private final S3Presigner s3Presigner;

    @Value("${app.s3.bucket-name}")
    private String bucketName;

    public String extractUserIdFromJwt(final HttpServletRequest request) {

        String token = request.getHeader("Authorization").substring(7);
        return jwtService.extractUserId(token);
    }

    public void updateUserStatus(final User user, final UserStatus userStatus) {

        user.setStatus(userStatus);

        userRepository.save(user);
    }

    public Optional<User> findByEmail(final String email) {

        return userRepository.findByEmail(email);
    }

    public List<ItemResponse> getItemsResponsesWithPresignedUrls(final List<Item> items) {
        return items.stream()
                .map(item -> {
                    URL url = urlCache.getOrGenerate(
                            item.getObjectKey(),
                            Duration.ofMinutes(PRESIGNED_URL_EXPIRY),
                            key -> generatePresignedUrl(key, PRESIGNED_URL_EXPIRY)
                    );

                    return modelMapper.toItemResponse(item, String.valueOf(url));
                })
                .toList();
    }

    public URL generatePresignedUrl(final String objectKey, final long expiryInMinutes) {

        try {
            GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                    .bucket(bucketName)
                    .key(objectKey)
                    .build();

            GetObjectPresignRequest presignRequest = GetObjectPresignRequest.builder()
                    .signatureDuration(Duration.ofMinutes(expiryInMinutes))
                    .getObjectRequest(getObjectRequest)
                    .build();

            log.info("Generating new pre-signed URL.");
            return s3Presigner.presignGetObject(presignRequest).url();
        } catch (Exception ex) {
            throw new WasabiErrorException("An error occurred while generating presigned url", ERROR_CREATING_PRESIGNED_URL);
        }
    }
}
