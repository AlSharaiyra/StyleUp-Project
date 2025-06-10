package com.styleup.app.repository.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * User`s Closet entity.
 *
 * @author Walid Sharaiyra
 * @since 2025
 * @version 1.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "CLOSETS")
public class Closet {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    private Integer noOfItems = 0;

    @OneToMany(mappedBy = "closet", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Item> items = new ArrayList<>();

    @OneToOne
    @JoinColumn(name = "USER_ID", nullable = false, unique = true)
    private User user;
}
