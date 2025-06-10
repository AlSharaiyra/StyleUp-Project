package com.styleup.app.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

import java.util.UUID;

/**
 * An item representation.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class ItemModel {

    private UUID id;

    private String description;

    private String objectKey;

    private String gender;

    private String masterCategory;

    private String subCategory;

    private String articleType;

    private String baseColour;

    private String season;

    private String usage;
}
