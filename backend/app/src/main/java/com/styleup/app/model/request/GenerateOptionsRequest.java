package com.styleup.app.model.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.styleup.app.model.enums.EventType;
import lombok.Data;

@JsonInclude(JsonInclude.Include.NON_NULL)
@Data
public class GenerateOptionsRequest {

    private EventType eventType;
    private String season;
    // add items identifier
}
