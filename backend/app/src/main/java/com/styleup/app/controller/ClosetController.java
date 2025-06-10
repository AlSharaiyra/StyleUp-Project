package com.styleup.app.controller;

import com.styleup.app.model.ItemModel;
import com.styleup.app.model.response.ItemResponse;
import com.styleup.app.service.HelperService;
import com.styleup.app.service.ClosetService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * A closet rest controller that handles user`s closet related operations.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 05/2025
 */
@Tag(name = "Closets",
        description = "A set of APIs to perform CRUD operations on users` closet and clothing items.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/closet")
public class ClosetController {

    private final ClosetService closetService;
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

        return ResponseEntity.ok().body(closetService.uploadImage(file, description, userId, withModel));
    }

    @Operation(description = """
            An API to get all items in user`s closet.
            """)
    @GetMapping("/items")
    public ResponseEntity<List<ItemResponse>> getAllItems(
            final HttpServletRequest request,
            @RequestParam(defaultValue = "0", required = false) final int page,
            @RequestParam(defaultValue = "6", required = false) final int size,
            @RequestParam(defaultValue = "asc", required = false) final String sortDirection,
            @RequestParam(required = false) final String season,
            @RequestParam(required = false) final String subCategory
    ) {

        String userId = helperService.extractUserIdFromJwt(request);

        return ResponseEntity.ok().body(closetService.getAllItems(userId, page, size, sortDirection, season, subCategory));
    }

    @Operation(description = """
            An API to delete an item in user`s closet.
            """)
    @DeleteMapping("/items/{itemId}")
    public ResponseEntity<String> getAllItems(final HttpServletRequest request, @PathVariable("itemId") final String itemId) {

        String userId = helperService.extractUserIdFromJwt(request);

        return ResponseEntity.status(HttpStatus.NO_CONTENT).body(closetService.deleteItem(userId, itemId));
    }
}
