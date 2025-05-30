package com.styleup.app.controller;

import com.styleup.app.model.request.RequestOtpRequest;
import com.styleup.app.model.request.VerifyOtpRequest;
import com.styleup.app.model.response.OtpResponse;
import com.styleup.app.service.OtpService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * An OTP rest controller that handles otp sending and verification APIs.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 05/2025
 */
@Tag(name = "Otp",
        description = "A set of APIs to send and verify OTPs.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/otp")
public class OtpRestController {

    private final OtpService otpService;

    @Operation(description = """
            An API to verify OTP.
            """)
    @PostMapping("/verify-otp")
    public ResponseEntity<OtpResponse> verifyOtp(@Valid @RequestBody final VerifyOtpRequest verifyOtpRequest) {

        return ResponseEntity.status(HttpStatus.OK)
                .body(otpService.verifyOtp(verifyOtpRequest));
    }

    @Operation(description = """
            An API to request OTP.
            """)
    @PostMapping("/resend-otp")
    public ResponseEntity<OtpResponse> resendOtp(@Valid @RequestBody final RequestOtpRequest requestOtpRequest) {

        return ResponseEntity.status(HttpStatus.OK)
                .body(otpService.sendOtp(requestOtpRequest));
    }
}
