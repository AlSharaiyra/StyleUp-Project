package com.styleup.app.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.styleup.app.model.enums.Gender;
import com.styleup.app.model.enums.UserStatus;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * A user representation.
 *
 * @author Walid Sharaiyra
 * @since 04/2025
 * @version 1.0
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class UserModel {

    private UUID userId;

    private String fullName;

    private String email;

    private Integer age;

    private Gender gender;

    private LocalDateTime createdAt;

    private LocalDateTime lastUpdated;

    private LocalDateTime lastLogin;

    private UserStatus status;

}
