package com.styleup.app.controller;


import com.styleup.app.model.enums.EventType;
import com.styleup.app.model.request.GenerateOptionsRequest;
import com.styleup.app.model.response.EventTypeResponse;
import com.styleup.app.model.response.ItemResponse;
import com.styleup.app.service.HelperService;
import com.styleup.app.service.RecommendationService;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "Recommendation System",
        description = "A set of APIs to handle recommendation system operations and interactions.")
@RequiredArgsConstructor
@RestController
@RequestMapping("/recommend")
public class RecommendationController {

    private final RecommendationService recommendationService;
    private final HelperService helperService;

    @GetMapping("/events")
    public ResponseEntity<List<EventTypeResponse>> getAllEvents() {
        return ResponseEntity.ok().body(recommendationService.getAllEvents());
    }

    @PostMapping("/step-one")
    public ResponseEntity<List<ItemResponse>> generateTopwearOptions(
            final HttpServletRequest request,
            @RequestBody final GenerateOptionsRequest generateOptionsRequest
            ) {
        final String userId = helperService.extractUserIdFromJwt(request);

        return ResponseEntity.ok().body(recommendationService.generateTopwearOptions(
                userId, generateOptionsRequest));
    }

    @PostMapping("/step-two")
    public ResponseEntity<List<ItemResponse>> generateBottomwearOptions(
            final HttpServletRequest request,
            @RequestBody final GenerateOptionsRequest generateOptionsRequest
    ) {
        final String userId = helperService.extractUserIdFromJwt(request);
        final String otherType = "bottomwear";

        return ResponseEntity.ok().body(recommendationService.generateOtherOptions(
                userId, generateOptionsRequest, otherType));
    }

    @PostMapping("/step-three")
    public ResponseEntity<List<ItemResponse>> generateFootwearOptions(
            final HttpServletRequest request,
            @RequestBody final GenerateOptionsRequest generateOptionsRequest
    ) {
        final String userId = helperService.extractUserIdFromJwt(request);
        final String otherType = "shoes";

        return ResponseEntity.ok().body(recommendationService.generateOtherOptions(
                userId, generateOptionsRequest, otherType));
    }
}
