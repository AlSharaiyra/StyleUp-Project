package com.styleup.app.repository.repo;

import com.styleup.app.model.enums.OtpStatus;
import com.styleup.app.repository.entity.OtpVerification;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

/**
 * User repository.
 *
 * @author Walid Sharaiyra
 * @since 04/2025
 * @version 1.0
 */
public interface OtpRepository extends JpaRepository<OtpVerification, UUID> {

    Optional<OtpVerification> findByEmailAndOtpStatus(final String email, final OtpStatus otpStatus);

    Optional<OtpVerification> findByVerificationToken(final String verificationToken);
}
