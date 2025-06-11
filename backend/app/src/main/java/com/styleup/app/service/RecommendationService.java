package com.styleup.app.service;

import com.styleup.app.infra.PresignedUrlCache;
import com.styleup.app.infra.exception.ResourceNotFoundException;
import com.styleup.app.model.enums.EventType;
import com.styleup.app.model.enums.Formality;
import com.styleup.app.model.mapper.ModelMapper;
import com.styleup.app.model.response.EventTypeResponse;
import com.styleup.app.model.response.ItemResponse;
import com.styleup.app.repository.entity.Item;
import com.styleup.app.repository.entity.User;
import com.styleup.app.repository.repo.ItemRepository;
import com.styleup.app.repository.repo.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.net.URL;
import java.time.Duration;
import java.util.*;

import static com.styleup.app.infra.constants.Constants.NO_OF_SUGGESTED_OPTIONS;
import static com.styleup.app.infra.constants.Constants.PRESIGNED_URL_EXPIRY;
import static com.styleup.app.infra.constants.ErrorCodes.EMPTY_CLOSET;
import static com.styleup.app.infra.constants.ErrorCodes.USER_NOT_FOUND;

@Log4j2
@Service
@RequiredArgsConstructor
public class RecommendationService {

    private final UserRepository userRepository;
    private final ItemRepository itemRepository;
    private final ClosetService closetService;
    private final HelperService helperService;

    public List<EventTypeResponse> getAllEvents() {

        return Arrays.stream(EventType.values())
                .map(event -> new EventTypeResponse(event.name(), event.getDisplayName()))
                .toList();
    }

    public List<ItemResponse> generateTopwearOptions(final String userId, final EventType eventType, final String season) {

        User user = userRepository.findById(UUID.fromString(userId))
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + userId, USER_NOT_FOUND));

        UUID closetId = user.getCloset().getId();

        List<Formality> formalities = eventType.getFormalities();
        List<Item> items = new ArrayList<>();

        for (Formality formality : formalities) {
            items.addAll(itemRepository.findByClosetIdAndSubCategoryAndUsageAndSeason(
                    closetId, "topwear", formality.name().toLowerCase(), season.toLowerCase()));
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
