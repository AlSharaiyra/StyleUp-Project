package com.styleup.app.repository.repo;

import com.styleup.app.repository.entity.Closet;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

/**
 * Closet repository.
 *
 * @author Walid Sharaiyra
 * @since 2025
 * @version 1.0
 */
public interface ClosetRepository extends JpaRepository<Closet, UUID> {
}
