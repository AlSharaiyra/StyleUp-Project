package com.styleup.app.repository.repo;

import com.styleup.app.repository.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

/**
 * User repository.
 *
 * @author Walid Sharaiyra
 * @since 04/2025
 * @version 1.0
 */
public interface UserRepository extends JpaRepository<User, UUID> {

//    Optional<User> findByUsername(String username);

    Optional<User> findByEmail(String email);

    boolean existsByEmail(String email);

}
