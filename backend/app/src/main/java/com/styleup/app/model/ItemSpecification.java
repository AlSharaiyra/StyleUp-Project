package com.styleup.app.model;

import com.styleup.app.repository.entity.Item;
import org.springframework.data.jpa.domain.Specification;

import java.util.UUID;

public class ItemSpecification {

    public static Specification<Item> hasClosetId(UUID closetId) {
        return (root, query, cb) -> cb.equal(root.get("closet").get("id"), closetId);
    }

    public static Specification<Item> hasSubCategory(String subCategory) {
        return (root, query, cb) -> cb.equal(cb.lower(root.get("subCategory")), subCategory.toLowerCase());
    }

    public static Specification<Item> hasSeason(String season) {
        return (root, query, cb) -> cb.equal(cb.lower(root.get("season")), season.toLowerCase());
    }
}
