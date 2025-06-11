package com.styleup.app.service;

import com.styleup.app.infra.PresignedUrlCache;
import com.styleup.app.infra.exception.ResourceNotFoundException;
import com.styleup.app.model.enums.EventType;
import com.styleup.app.model.enums.Formality;
import com.styleup.app.model.mapper.ModelMapper;
import com.styleup.app.model.request.GenerateOptionsRequest;
import com.styleup.app.model.response.EventTypeResponse;
import com.styleup.app.model.response.ItemResponse;
import com.styleup.app.repository.entity.Item;
import com.styleup.app.repository.entity.User;
import com.styleup.app.repository.repo.ItemRepository;
import com.styleup.app.repository.repo.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.*;

import static com.styleup.app.infra.constants.Constants.NO_OF_SUGGESTED_OPTIONS;
import static com.styleup.app.infra.constants.ErrorCodes.*;

@Log4j2
@Service
@RequiredArgsConstructor
public class RecommendationService {

    private final UserRepository userRepository;
    private final ItemRepository itemRepository;
    private final HelperService helperService;
    private final ColorCompatibilityService colorCompatibilityService;

    public List<EventTypeResponse> getAllEvents() {

        return Arrays.stream(EventType.values())
                .map(event -> new EventTypeResponse(event.name(), event.getDisplayName()))
                .toList();
    }

    public List<ItemResponse> generateTopwearOptions(final String userId, final GenerateOptionsRequest request) {

        User user = userRepository.findById(UUID.fromString(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + userId, USER_NOT_FOUND));

        UUID closetId = user.getCloset().getId();

        List<Formality> formalities = request.getEventType().getFormalities();
        List<Item> items = new ArrayList<>();

        for (Formality formality : formalities) {
            items.addAll(itemRepository.findByClosetIdAndSubCategoryAndUsageAndSeason(
                    closetId, "topwear", formality.name().toLowerCase(), request.getSeason().toLowerCase()));
            items.addAll(itemRepository.findByClosetIdAndSubCategoryAndUsageAndSeason(
                    closetId, "topwear", formality.name().toLowerCase(), "all"));
        }

        if (items.isEmpty()) {
            throw new ResourceNotFoundException("User`s closet is empty", EMPTY_CLOSET);
        }

        Collections.shuffle(items);

        // Pick up to 3 items
        List<Item> selected = items.stream()
                .limit(NO_OF_SUGGESTED_OPTIONS)
                .toList();

        return helperService.getItemsResponsesWithPresignedUrls(selected);
    }

    public List<ItemResponse> generateOtherOptions(final String userId, final GenerateOptionsRequest request, final String otherType) {

        User user = userRepository.findById(UUID.fromString(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + userId, USER_NOT_FOUND));

        UUID closetId = user.getCloset().getId();
        final Item topwear = itemRepository.findById(UUID.fromString(request.getPreviousItemId()))
                .orElseThrow(() -> new ResourceNotFoundException("Item not found with ID: " + request.getPreviousItemId(), ITEM_NOT_FOUND));

        final String topwearColor = topwear.getBaseColour();

        // TODO: might need to use the previous item`s formality type and season
        List<Formality> formalities = request.getEventType().getFormalities();
        List<String> compatibleColors = colorCompatibilityService.getCompatibleColors(topwearColor);

        List<Item> items = new ArrayList<>();

        for (Formality formality : formalities) {
            for (String color : compatibleColors) {
                items.addAll(itemRepository.findByClosetIdAndSubCategoryAndUsageAndSeasonAndBaseColour(
                        closetId, otherType, formality.name().toLowerCase(), request.getSeason().toLowerCase(), color.toLowerCase()));
                log.info("formality: {}, color: {}, Items after first add: {}", formality, color, items);
                items.addAll(itemRepository.findByClosetIdAndSubCategoryAndUsageAndSeasonAndBaseColour(
                        closetId, otherType, formality.name().toLowerCase(), "all", color.toLowerCase()));
                log.info("formality: {}, color: {}, Items after second add: {}", formality, color, items);
            }
        }

        if (items.isEmpty()) {
            throw new ResourceNotFoundException("User`s closet is empty", EMPTY_CLOSET);
        }

        Collections.shuffle(items);

        // Pick up to 3 items
        List<Item> selected = items.stream()
                .limit(NO_OF_SUGGESTED_OPTIONS)
                .toList();

        return helperService.getItemsResponsesWithPresignedUrls(selected);
    }


}
