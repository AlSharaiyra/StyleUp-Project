package com.styleup.app.service;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

import static com.styleup.app.infra.constants.Constants.*;

@Service
public class JwtService {

//    @Value("${jwt.secret}")
//    public String JWT_SECRET;

    private final String JWT_SECRET;

    public JwtService(@Value("${jwt.secret}") String jwtSecret) {
        this.JWT_SECRET = jwtSecret;
    }

    private SecretKey getSigningKey() {
        return Keys.hmacShaKeyFor(JWT_SECRET.getBytes(StandardCharsets.UTF_8));
    }

    public String generateAccessToken(String username, String userId) {
        return Jwts.builder()
                .subject(username)
                .claim("userId", userId)
                .claim("type", "access")
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + JWT_ACCESS_EXPIRATION))
                .signWith(getSigningKey())
                .compact();
    }

    public String extractUsername(String token) {
        return extractAllClaims(token).getSubject();
    }

    public boolean isTokenValid(String token, String username, Date revokedTokensBefore) {
        return extractUsername(token).equals(username) &&
                !isTokenExpired(token) &&
                extractAllClaims(token).getIssuedAt().after(revokedTokensBefore);
    }

    private boolean isTokenExpired(String token) {
        return extractAllClaims(token).getExpiration().before(new Date());
    }

    // REFRESH_TOKEN
    public String generateRefreshToken(String username, String userId) {
        return Jwts.builder()
                .subject(username)
                .claim("userId", userId)
                .claim("type", "refresh")
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + JWT_REFRESH_EXPIRATION))
                .signWith(getSigningKey())
                .compact();
    }

    public boolean isAccessToken(String token) {
        String type = extractAllClaims(token).get("type", String.class);

        return "access".equals(type);
    }

    public boolean isRefreshToken(String token) {
        String type = extractAllClaims(token).get("type", String.class);

        return "refresh".equals(type);
    }

    public String extractUserId(String token) {
        return extractAllClaims(token).get("userId", String.class);
    }

    private Claims extractAllClaims(String token) {
        return Jwts.parser()
                .verifyWith(getSigningKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }
}
