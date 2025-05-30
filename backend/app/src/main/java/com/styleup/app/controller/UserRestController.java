package com.styleup.app.controller;

import com.styleup.app.model.UserModel;
import com.styleup.app.model.request.CreateUserRequest;
import com.styleup.app.model.request.SetGenderAndAgeRequest;
import com.styleup.app.service.HelperService;
import com.styleup.app.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * A user rest controller that handles user related APIs.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 05/2025
 */
@Tag(name = "Users",
        description = "A set of APIs to perform CRUD operations on users and their related data.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/users")
public class UserRestController {

    private final UserService userService;
    private final HelperService helperService;

    @Operation(description = """
            An API to register a new user.
            """)
    @PostMapping
    public ResponseEntity<UserModel> register(@Valid @RequestBody final CreateUserRequest createUserRequest) {

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(userService.createUser(createUserRequest));
    }


    @Operation(description = """
            An API to get user info by userId.
            """)
    @GetMapping("/my-profile")
    public ResponseEntity<UserModel> getUserInfo(final HttpServletRequest request) {

        String userId = helperService.extractUserIdFromJwt(request);

        return ResponseEntity.ok().body(userService.getUserInfo(userId));
    }

    @Operation(description = """
            An API to set user`s age and gender.
            """)
    @PutMapping("/complete")
    public ResponseEntity<UserModel> setGenderAndAge(final HttpServletRequest request, @Valid @RequestBody SetGenderAndAgeRequest userRequest) {

        String userId = helperService.extractUserIdFromJwt(request);

        return ResponseEntity.ok().body(userService.setGenderAndAge(userId, userRequest));
    }

}
