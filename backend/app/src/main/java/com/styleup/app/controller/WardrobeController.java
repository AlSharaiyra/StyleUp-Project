package com.styleup.app.controller;

import com.styleup.app.model.ItemModel;
import com.styleup.app.model.response.ItemResponse;
import com.styleup.app.service.HelperService;
import com.styleup.app.service.WardrobeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.services.s3.endpoints.internal.Value;

import java.util.List;

/**
 * A wardrobe rest controller that handles user`s wardrobe related operations.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 05/2025
 */
@Tag(name = "Wardrobes",
        description = "A set of APIs to perform CRUD operations on users` wardrobes and clothing items.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/wardrobe")
public class WardrobeController {

    private final WardrobeService wardrobeService;
    private final HelperService helperService;

    @Operation(description = """
            An API to upload a new clothing image.
            """)
    @PostMapping("/items")
    public ResponseEntity<ItemModel> uploadImage(
            @RequestParam("file") final MultipartFile file,
            @RequestParam(value = "description", required = false) final String description,
            final HttpServletRequest request) {

        final String userId = helperService.extractUserIdFromJwt(request);

        return ResponseEntity.ok().body(wardrobeService.uploadImage(file, description, userId));
    }

    @Operation(description = """
            An API to get all items in user`s wardrobe.
            """)
    @GetMapping("/items")
    public ResponseEntity<List<ItemResponse>> getAllItems(final HttpServletRequest request) {

        String userId = helperService.extractUserIdFromJwt(request);

        return ResponseEntity.ok().body(wardrobeService.getAllItems(userId));
    }
}
