package com.styleup.app.repository.repo;

import com.styleup.app.repository.entity.Item;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.UUID;

/**
 * Item repository.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 2025
 */
public interface ItemRepository extends JpaRepository<Item, UUID>, JpaSpecificationExecutor<Item> {

    List<Item> findByClosetIdAndSubCategoryAndUsageAndSeason(
            final UUID closetId, final String subCategory, final String usage, final String season);

    List<Item> findByClosetIdAndSubCategoryAndUsageAndSeasonAndBaseColour(
            final UUID closetId, final String subCategory, final String usage, final String season, final String baseColour);
}
