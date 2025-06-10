package com.styleup.app.repository.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.net.URL;
import java.time.Instant;

@AllArgsConstructor
public class CachedUrl {

    @Getter
    private final URL url;
    private final Instant expiryTime;


    public boolean isExpired() {
        return Instant.now().isAfter(expiryTime);
    }
}
