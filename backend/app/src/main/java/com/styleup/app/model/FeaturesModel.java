package com.styleup.app.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

/**
 * Feature extraction model response model.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class FeaturesModel {

    private String gender;

    private String masterCategory;

    private String subCategory;

    private String articleType;

    private String baseColour;

    private String season;

    private String usage;
}
