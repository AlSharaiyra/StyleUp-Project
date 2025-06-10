package com.styleup.app.repository.repo;

import com.styleup.app.repository.entity.Item;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.UUID;

/**
 * Item repository.
 *
 * @author Walid Sharaiyra
 * @since 2025
 * @version 1.0
 */
public interface ItemRepository extends JpaRepository<Item, UUID>, JpaSpecificationExecutor<Item> {

    Page<Item> findAllByClosetId(UUID closetId, Pageable pageable);

}
