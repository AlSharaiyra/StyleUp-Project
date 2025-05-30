package com.styleup.app.repository.entity;

import com.styleup.app.model.enums.OtpPurpose;
import com.styleup.app.model.enums.OtpStatus;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * An OTP verification entity.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "otp_verification")
public class OtpVerification {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false)
    private String otp;

    @Column(nullable = false)
    @Email
    @Size(max = 50)
    private String email;

    @Column(name = "CREATED_AT")
    @CreationTimestamp
    private LocalDateTime createdAt;

    @Column(name = "EXPIRES_AT")
    private LocalDateTime expiresAt;

    @Column(nullable = false, name = "OTP_STATUS")
    @Enumerated(EnumType.STRING)
    private OtpStatus otpStatus;

    @Column(nullable = false, name = "OTP_PURPOSE")
    @Enumerated(EnumType.STRING)
    private OtpPurpose otpPurpose;

    private String verificationToken;

    @Column(name = "VERIFICATION_TOKEN_EXPIRES_AT")
    private LocalDateTime verificationTokenExpiresAt;
}
