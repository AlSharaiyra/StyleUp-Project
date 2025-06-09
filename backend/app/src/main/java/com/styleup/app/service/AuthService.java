package com.styleup.app.service;

import com.styleup.app.infra.constants.ErrorCodes;
import com.styleup.app.infra.exception.*;
import com.styleup.app.model.enums.OtpPurpose;
import com.styleup.app.model.enums.UserStatus;
import com.styleup.app.model.request.RefreshTokenRequest;
import com.styleup.app.model.request.RequestOtpRequest;
import com.styleup.app.model.request.ResetPasswordRequest;
import com.styleup.app.model.request.UserLoginRequest;
import com.styleup.app.model.response.AuthResponse;
import com.styleup.app.repository.entity.OtpVerification;
import com.styleup.app.repository.entity.User;
import com.styleup.app.repository.entity.UserPrincipal;
import com.styleup.app.repository.repo.OtpRepository;
import com.styleup.app.repository.repo.UserRepository;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.UUID;

import static com.styleup.app.infra.constants.ErrorCodes.*;

/**
 * An auth service that handles user authentication logic.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 05/2025
 */
@Log4j2
@RequiredArgsConstructor
@Service
public class AuthService {

    private final UserRepository userRepository;
    private final OtpService otpService;
    private final JwtService jwtService;

    private final AuthenticationManager authenticationManager;
    private final CustomUserDetailsService userDetailsService;
    private final PasswordEncoder passwordEncoder;

    /**
     * A method that logins a user.
     *
     * @param request a user login request
     * @return UserLoginResponse a user login response
     */
    public AuthResponse loginUser(final UserLoginRequest request) {

        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new InvalidCredentialsException("Invalid email or password.", INVALID_CREDENTIALS));

        if (user.getStatus().equals(UserStatus.UNVERIFIED)) {
            RequestOtpRequest otpRequest = new RequestOtpRequest(
                    request.getEmail(),
                    OtpPurpose.CREATE_USER
            );
            try {
                otpService.sendOtp(otpRequest);
            } catch (ErrorSendingOtpException ex) {
                log.warn(ex.getErrorCode());
            }
            throw new UnverifiedUserException("User not verified", ErrorCodes.UNVERIFIED_USER);
        }

        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword())
            );
        } catch (AuthenticationException ex) {
            throw new InvalidCredentialsException("Invalid credentials", INVALID_CREDENTIALS);
        }

        String accessToken = jwtService.generateAccessToken(user.getEmail(), String.valueOf(user.getId()));
        String refreshToken = jwtService.generateRefreshToken(user.getEmail(), String.valueOf(user.getId()));

        final boolean isFirstLogin = user.getLastLogin() == null;

        user.setLastLogin(LocalDateTime.now());
        userRepository.save(user);

        return new AuthResponse(accessToken, refreshToken, isFirstLogin);
    }

    /**
     * A method that refreshes an access token.
     *
     * @param request a refresh token
     * @return AuthResponse a new access token and the given refresh token
     */
    public AuthResponse refreshToken(final RefreshTokenRequest request) {

        try {
            String username = jwtService.extractUsername(request.getRefreshToken());
            UserPrincipal user = (UserPrincipal) userDetailsService.loadUserByUsername(username);

            if (jwtService.isTokenValid(request.getRefreshToken(), username, user.getRevokedTokensBefore())
                    && jwtService.isRefreshToken(request.getRefreshToken())) {

                String accessToken = jwtService.generateAccessToken(
                        username,
                        jwtService.extractUserId(request.getRefreshToken())
                );
                return new AuthResponse(accessToken, request.getRefreshToken(), false);
            } else {
                throw new InvalidCredentialsException("Invalid or expired refresh token", INVALID_CREDENTIALS);
            }
        } catch (ExpiredJwtException e) {
            throw new InvalidCredentialsException("Refresh token has expired", EXPIRED_CREDENTIALS);
        } catch (JwtException e) {
            throw new InvalidCredentialsException("Invalid refresh token", INVALID_CREDENTIALS);
        }
    }

    /**
     * A method that logs out the user,
     * and revokes/invalidates their access and refresh tokens.
     *
     * @param userId userId
     * @return String logout message
     */
    public String logout(final String userId) {

        User user = userRepository.findById(UUID.fromString(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + userId, USER_NOT_FOUND));

        user.setRevokedTokensBefore(Date.from(Instant.now()));
        userRepository.save(user);

        return "Logout successful";
    }

    public String resetPassword(final ResetPasswordRequest request) {

        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + request.getEmail(), USER_NOT_FOUND));

        OtpVerification otpVerification = otpService.getByVerificationToken(request.getVerificationToken())
                .orElseThrow(() -> new ResourceNotFoundException("Verification token is invalid", V_TOKEN_NOT_FOUND));

        if (!request.getNewPassword().equals(request.getConfirmNewPassword())) {
            throw new GenericException("Password and confirmation password does not match", PASSWORD_MISMATCH);
        }

        if (!otpVerification.getEmail().equals(request.getEmail())
                || !otpVerification.getOtpPurpose().equals(OtpPurpose.RESET_PASSWORD)) {
            throw new GenericException("Error proceeding with password reset", INTERNAL_SERVER_ERROR);
        }

        if (otpVerification.getVerificationTokenExpiresAt().isBefore(LocalDateTime.now())) {
            throw new GenericException("Request timeout", REQUEST_TIMEOUT);
        }

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));

        userRepository.save(user);
        return "Password reset successfully";
    }


}
