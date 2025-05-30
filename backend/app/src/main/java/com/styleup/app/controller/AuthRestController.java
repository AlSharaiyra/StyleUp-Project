package com.styleup.app.controller;

import com.styleup.app.model.request.RefreshTokenRequest;
import com.styleup.app.model.request.ResetPasswordRequest;
import com.styleup.app.model.request.UserLoginRequest;
import com.styleup.app.model.response.AuthResponse;
import com.styleup.app.service.AuthService;
import com.styleup.app.service.HelperService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


/**
 * An auth rest controller that handles user authentication APIs.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@Tag(name = "Auth",
        description = "A set of APIs to handle users authentication.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/auth")
public class AuthRestController {

    private final AuthService authService;
    private final HelperService helperService;

    @Operation(description = """
            An API to login user.
            """)
    @PostMapping("/login")
    public ResponseEntity<AuthResponse> loginUser(@Valid @RequestBody final UserLoginRequest userLoginRequest) {

        return ResponseEntity.ok().body(authService.loginUser(userLoginRequest));
    }

    @Operation(description = """
            An API to refresh token.
            """)
    @PostMapping("/refresh-token")
    public ResponseEntity<AuthResponse> refreshToken(@Valid @RequestBody final RefreshTokenRequest refreshTokenRequest) {
        return ResponseEntity.ok().body(authService.refreshToken(refreshTokenRequest));
    }

    @Operation(description = """
            An API to logout user.
            """)
    @PostMapping("/logout")
    public ResponseEntity<String> logout(final HttpServletRequest request) {

        String userId = helperService.extractUserIdFromJwt(request);

        return ResponseEntity.ok().body(authService.logout(userId));
    }

    @Operation(description = """
            An API to reset user`s password.
            """)
    @PostMapping("/reset-password")
    public ResponseEntity<String> resetPassword(@Valid @RequestBody final ResetPasswordRequest request) {

        return ResponseEntity.ok().body(authService.resetPassword(request));
    }
}
