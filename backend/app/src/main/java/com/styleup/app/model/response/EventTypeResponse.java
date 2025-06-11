package com.styleup.app.model.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class EventTypeResponse {

    private String name;
    private String displayName;

}
