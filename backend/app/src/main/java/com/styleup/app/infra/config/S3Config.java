package com.styleup.app.infra.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;

import java.net.URI;

@Configuration
public class S3Config {

    @Value("${cloud.aws.s3.endpoint}")
    private String regionEndpoint;

    @Value("${cloud.aws.region.static}")
    private String region;

    @Value("${cloud.aws.credentials.access-key}")
    private String key;

    @Value("${cloud.aws.credentials.secret-key}")
    private String secret;

    @Bean
    public S3Client s3Client() {
        return S3Client.builder()
                .endpointOverride(URI.create(regionEndpoint)) // e.g., eu-central-1
                .region(Region.of(region)) // Use any AWS-compatible region, Wasabi will still work
                .credentialsProvider(
                        StaticCredentialsProvider.create(AwsBasicCredentials.create(key, secret))
                )
                .build();
    }
}
