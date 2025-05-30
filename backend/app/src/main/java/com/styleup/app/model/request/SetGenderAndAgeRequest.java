package com.styleup.app.model.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.styleup.app.model.enums.Gender;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * A request model to set user`s age and gender.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class SetGenderAndAgeRequest {

    private Gender gender;

    @Min(10) @Max(85)
    private Integer age;
}
