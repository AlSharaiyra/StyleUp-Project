package com.styleup.app.service;

import com.styleup.app.infra.constants.ErrorCodes;
import com.styleup.app.infra.exception.ErrorSendingOtpException;
import com.styleup.app.infra.exception.ResourceNotFoundException;
import com.styleup.app.model.enums.OtpPurpose;
import com.styleup.app.model.enums.OtpStatus;
import com.styleup.app.model.enums.UserStatus;
import com.styleup.app.model.request.RequestOtpRequest;
import com.styleup.app.model.request.VerifyOtpRequest;
import com.styleup.app.model.response.OtpResponse;
import com.styleup.app.repository.entity.OtpVerification;
import com.styleup.app.repository.entity.User;
import com.styleup.app.repository.repo.OtpRepository;
import com.styleup.app.repository.repo.UserRepository;
import jakarta.validation.ValidationException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import static com.styleup.app.infra.constants.Constants.OTP_LIFETIME;
import static com.styleup.app.infra.constants.Constants.VERIFICATION_TOKEN_LIFETIME;

/**
 * An OTP service that handles sending and verifying OTPs.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 05/2025
 */
@Log4j2
@RequiredArgsConstructor
@Service
public class OtpService {

    private final OtpRepository otpRepository;
    private final HelperService helperService;

    /**
     * A method that generates a 4-digit OTP.
     *
     * @return String generated OTP
     */
    public String generateOtp() {
        return "1234";
    }

    /**
     * A method that sends OTP to given email address.
     *
     * @param request requestOtpRequest
     */
    public OtpResponse sendOtp(final RequestOtpRequest request) {

        Optional<OtpVerification> optional = otpRepository.findByEmailAndOtpStatus(
                request.getEmail(),
                OtpStatus.PENDING
        );

        if (optional.isPresent()) {
            if (optional.get().getExpiresAt().isBefore(LocalDateTime.now())) {
                OtpVerification otpVerification = optional.get();
                otpVerification.setOtpStatus(OtpStatus.EXPIRED);
                otpRepository.save(otpVerification);
            } else {
                throw new ErrorSendingOtpException("Ask for a new OTP", ErrorCodes.INTERNAL_SERVER_ERROR);
            }
        }

        OtpVerification otpVerification = new OtpVerification();
        LocalDateTime currentTime = LocalDateTime.now();

        otpVerification.setOtp(this.generateOtp());
        otpVerification.setEmail(request.getEmail());
        otpVerification.setOtpStatus(OtpStatus.PENDING);
        otpVerification.setCreatedAt(currentTime);
        otpVerification.setExpiresAt(currentTime.plusMinutes(OTP_LIFETIME));
        otpVerification.setOtpPurpose(request.getOtpPurpose());

        // TODO: Logic to send OTP via email.
        otpRepository.save(otpVerification);
        log.info("OTP sent to email address: {}", request.getEmail());

        return OtpResponse.builder()
                .message("Email verified successfully")
                .recipientEmail(request.getEmail())
                .otpPurpose(request.getOtpPurpose())
                .build();
    }

    /**
     * A method that verifies OTP.
     *
     * @param request a verify otp request
     * @return OtpVerificationResponse the verification response
     */
    @Transactional
    public OtpResponse verifyOtp(final VerifyOtpRequest request) {

        User user = helperService.findByEmail(request.getEmail())
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: " + request.getEmail(), ErrorCodes.USER_NOT_FOUND));

        OtpVerification otpVerification = otpRepository.findByEmailAndOtpStatus(
                request.getEmail(),
                OtpStatus.PENDING
        ).orElseThrow(() -> new ResourceNotFoundException(
                "OTP might be expired, try asking for new OTP.",
                ErrorCodes.OTP_NOT_FOUND
        ));

        if (otpVerification.getExpiresAt().isBefore(LocalDateTime.now())) {
            otpVerification.setOtpStatus(OtpStatus.EXPIRED);
            otpRepository.save(otpVerification);
            throw new ResourceNotFoundException("OTP is expired, consider asking for a new otp.", ErrorCodes.OTP_IS_EXPIRED);
        }

        if (!otpVerification.getOtp().equals(request.getOtp())
                || !otpVerification.getOtpPurpose().equals(request.getOtpPurpose())) {
            throw new ValidationException("Wrong OTP entered, try again.");
        }

        final String verificationToken = UUID.randomUUID().toString();

        otpVerification.setOtpStatus(OtpStatus.VERIFIED);
        otpVerification.setVerificationToken(verificationToken);
        otpVerification.setVerificationTokenExpiresAt(LocalDateTime.now().plusMinutes(VERIFICATION_TOKEN_LIFETIME));

        if (request.getOtpPurpose().equals(OtpPurpose.CREATE_USER)) {

            otpVerification.setOtpStatus(OtpStatus.COMPLETED);
            helperService.updateUserStatus(user, UserStatus.ACTIVE);
        }

        otpRepository.save(otpVerification);

        return OtpResponse.builder()
                .message("Email verified successfully")
                .recipientEmail(request.getEmail())
                .otpPurpose(request.getOtpPurpose())
                .verificationToken(verificationToken)
                .build();
    }

    public Optional<OtpVerification> getByVerificationToken(final String verificationToken) {

        return otpRepository.findByVerificationToken(verificationToken);
    }
}
