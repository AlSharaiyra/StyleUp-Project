package com.styleup.app.infra;

import com.styleup.app.repository.entity.CachedUrl;
import lombok.extern.log4j.Log4j2;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import software.amazon.awssdk.services.s3.endpoints.internal.Value;

import java.net.URL;
import java.time.Duration;
import java.time.Instant;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;

import static com.styleup.app.infra.constants.Constants.PRESIGNED_URL_EXPIRY;

@Log4j2
@Component
public class PresignedUrlCache {

    private final Map<String, CachedUrl> cache = new ConcurrentHashMap<>();

    public URL getOrGenerate(String objectKey, Duration ttl, Function<String, URL> generator) {
        CachedUrl cached = cache.get(objectKey);

        if (cached != null && !cached.isExpired()) {
            log.info("Cached URL found: {}", cached.getUrl());
            return cached.getUrl();
        }

        URL newUrl = generator.apply(objectKey);
        cache.put(objectKey, new CachedUrl(newUrl, Instant.now().plus(ttl)));

        return newUrl;
    }

    // Cleanup every 15 minutes
    @Scheduled(fixedRate = PRESIGNED_URL_EXPIRY * 60 * 1000)
    public void cleanUpExpiredPresignedUrls() {
        int before = cache.size();
        cache.entrySet().removeIf(entry -> entry.getValue().isExpired());
        int after = cache.size();

        if (before != after) {
            log.info("Cleaned up expired presigned URLs: {} removed", (before - after));
        }
    }
}
