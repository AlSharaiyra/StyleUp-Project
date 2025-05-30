package com.styleup.app.service;

import com.styleup.app.model.enums.UserStatus;
import com.styleup.app.repository.entity.User;
import com.styleup.app.repository.repo.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

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
}
