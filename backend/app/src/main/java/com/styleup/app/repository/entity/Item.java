package com.styleup.app.repository.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.Locale;
import java.util.UUID;

/**
 * User`s closet Items entity.
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

    private String objectKey;

    private String gender;

    @Column(name = "MASTER_CATEGORY")
    private String masterCategory;

    @Column(name = "SUB_CATEGORY")
    private String subCategory;

    @Column(name = "ARTICLE_TYPE")
    private String articleType;

    @Column(name = "BASE_COLOUR")
    private String baseColour;

    private String season;

    private String usage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CLOSET_ID")
    private Closet closet;

    @Column(name = "UPLOADED_AT")
    @CreationTimestamp
    private LocalDateTime uploadedAt;
}
