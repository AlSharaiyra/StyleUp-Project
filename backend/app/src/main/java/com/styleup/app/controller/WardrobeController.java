package com.styleup.app.controller;

import com.styleup.app.model.ItemModel;
import com.styleup.app.model.response.ItemResponse;
import com.styleup.app.service.HelperService;
import com.styleup.app.service.WardrobeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
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
            @RequestParam(value = "withModel", defaultValue = "true", required = false) final boolean withModel,
            @RequestParam(value = "description", required = false) final String description,
            final HttpServletRequest request) {

        final String userId = helperService.extractUserIdFromJwt(request);

        return ResponseEntity.ok().body(wardrobeService.uploadImage(file, description, userId, withModel));
    }

    @Operation(description = """
            An API to get all items in user`s wardrobe.
            """)
    @GetMapping("/items")
    public ResponseEntity<List<ItemResponse>> getAllItems(final HttpServletRequest request) {

        String userId = helperService.extractUserIdFromJwt(request);

        return ResponseEntity.ok().body(wardrobeService.getAllItems(userId));
    }

    @Operation(description = """
            An API to delete an item in user`s wardrobe.
            """)
    @DeleteMapping("/items/{itemId}")
    public ResponseEntity<String> getAllItems(final HttpServletRequest request, @PathVariable("itemId") final String itemId) {

        String userId = helperService.extractUserIdFromJwt(request);

        return ResponseEntity.status(HttpStatus.NO_CONTENT).body(wardrobeService.deleteItem(userId, itemId));
    }
}
