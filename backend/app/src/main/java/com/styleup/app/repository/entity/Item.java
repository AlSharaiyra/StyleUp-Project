package com.styleup.app.repository.entity;

import com.styleup.app.model.enums.*;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * User`s Wardrobe Items entity.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 2025
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "ITEMS")
public class Item {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    private String description;

    private String url;

    // TODO: might need to change it to ItemGender
    @Enumerated(EnumType.STRING)
    private Gender gender;

    @Column(name = "MASTER_CATEGORY")
    @Enumerated(EnumType.STRING)
    private MasterCategory masterCategory;

    @Column(name = "SUB_CATEGORY")
    @Enumerated(EnumType.STRING)
    private SubCategory subCategory;

    @Column(name = "ARTICLE_TYPE")
    @Enumerated(EnumType.STRING)
    private ArticleType articleType;

    @Column(name = "BASE_COLOUR")
    @Enumerated(EnumType.STRING)
    private BaseColour baseColour;

    @Enumerated(EnumType.STRING)
    private Season season;

    @Enumerated(EnumType.STRING)
    private Usage usage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "WARDROBE_ID")
    private Wardrobe wardrobe;
}
