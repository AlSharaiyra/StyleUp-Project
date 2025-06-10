package com.styleup.app.repository.entity;

import com.styleup.app.model.enums.UserStatus;
import com.styleup.app.model.enums.Gender;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.UUID;

/**
 * A user entity.
 *
 * @author Walid Sharaiyra
 * @since 2025
 * @version 1.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "USERS")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false)
    private String fullName;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    private Integer age;

    @Enumerated(EnumType.STRING)
    private Gender gender;

    @Column(name = "REVOKED_TOKENS_BEFORE")
    private Date revokedTokensBefore;

    @Column(nullable = false, updatable = false, name = "CREATED_AT")
    @CreationTimestamp
    private LocalDateTime createdAt;

    @Column(nullable = false, name = "LAST_UPDATED")
    @UpdateTimestamp
    private LocalDateTime lastUpdated;

    @Column(name = "LAST_LOGIN")
    private LocalDateTime lastLogin;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Closet closet;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private UserStatus status;
}
