package com.styleup.app.service;

import com.styleup.app.infra.constants.ErrorCodes;
import com.styleup.app.infra.exception.ResourceAlreadyExistsException;
import com.styleup.app.infra.exception.ResourceNotFoundException;
import com.styleup.app.model.UserModel;
import com.styleup.app.model.enums.OtpPurpose;
import com.styleup.app.model.enums.UserStatus;
import com.styleup.app.model.mapper.ModelMapper;
import com.styleup.app.model.request.CreateUserRequest;
import com.styleup.app.model.request.RequestOtpRequest;
import com.styleup.app.model.request.SetGenderAndAgeRequest;
import com.styleup.app.repository.entity.User;
import com.styleup.app.repository.entity.Closet;
import com.styleup.app.repository.repo.UserRepository;
import jakarta.validation.ValidationException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Date;
import java.util.UUID;

/**
 * A user service that handles user management and operations,
 * like create, read, update and delete. and other related services.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 05/2025
 */
@Log4j2
@RequiredArgsConstructor
@Service
public class UserService {

    private final UserRepository userRepository;
    private final ModelMapper modelMapper;
    private final OtpService otpService;
    private final PasswordEncoder passwordEncoder;

    /**
     * A method that creates a new user.
     *
     * @param request a create user request
     * @return UserModel a user representation
     */
    public UserModel createUser(final CreateUserRequest request) {

        log.debug("User to be create with name: {} and email: {} "
                , request.getFullName()
                , request.getEmail()
        );

        boolean emailExists = userRepository.existsByEmail(request.getEmail());

        if (emailExists) {
            throw new ResourceAlreadyExistsException("Email address is already taken.", ErrorCodes.EMAIL_ALREADY_EXISTS);
        }

        if (!request.getPassword().equals(request.getConfirmPassword())) {
            throw new ValidationException("Password and confirmation password does no match.");
        }

        RequestOtpRequest otpRequest = new RequestOtpRequest(
                request.getEmail(),
                OtpPurpose.CREATE_USER
        );

        otpService.sendOtp(otpRequest);

        User user = new User();
        Closet closet = new Closet();

        user.setFullName(request.getFullName());
        user.setEmail(request.getEmail());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setStatus(UserStatus.UNVERIFIED);
        user.setRevokedTokensBefore(Date.from(Instant.now()));
        user.setCloset(closet);
        closet.setUser(user);

        userRepository.save(user);
        log.info("User with email: {} created successfully, userId: {}", user.getEmail(), user.getId());

        return modelMapper.toUserModel(user);
    }

    /**
     * A method that retrieves user profile.
     *
     * @param userId userId
     * @return UserModel a user representation
     */
    public UserModel getUserInfo(final String userId) {

        return modelMapper.toUserModel(userRepository.findById(UUID.fromString(userId))
                .orElseThrow(() -> new ResourceNotFoundException("No user found with ID: " + userId, ErrorCodes.USER_NOT_FOUND)));
    }

    public UserModel setGenderAndAge(final String userId, final SetGenderAndAgeRequest request) {

        User user = userRepository.findById(UUID.fromString(userId))
                .orElseThrow(() -> new ResourceNotFoundException("No user found with ID: " + userId, ErrorCodes.USER_NOT_FOUND));

        if (request.getAge() != null) {
            user.setAge(request.getAge());
        }

        if (request.getGender() != null) {
            user.setGender(request.getGender());
        }

        userRepository.save(user);

        return modelMapper.toUserModel(user);
    }

}
