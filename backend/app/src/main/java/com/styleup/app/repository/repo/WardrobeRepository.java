package com.styleup.app.repository.repo;

import com.styleup.app.repository.entity.Wardrobe;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

/**
 * Wardrobe repository.
 *
 * @author Walid Sharaiyra
 * @since 2025
 * @version 1.0
 */
public interface WardrobeRepository extends JpaRepository<Wardrobe, UUID> {
}
