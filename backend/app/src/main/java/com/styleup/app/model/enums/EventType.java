package com.styleup.app.model.enums;

import lombok.Getter;

import java.util.List;

@Getter
public enum EventType {
    SCHOOL_COLLEGE("School / College", List.of(Formality.CASUAL, Formality.FORMAL)),
    OFFICE_WORK("Office / Work", List.of(Formality.CASUAL, Formality.FORMAL)),
    INTERVIEW("Interview / Presentation", List.of(Formality.FORMAL)),
    WEDDING("Wedding / Engagement", List.of(Formality.FORMAL)),
    PARTY("Party / Night Out", List.of(Formality.CASUAL, Formality.FORMAL)),
    OUTDOOR("Outdoor Activity / Sports", List.of(Formality.CASUAL, Formality.SPORTS)),
    HANGOUT("Casual Hangout / Coffee Shop", List.of(Formality.CASUAL));

    private final String displayName;
    private final List<Formality> formalities;

    EventType(String displayName, List<Formality> formalities) {
        this.displayName = displayName;
        this.formalities = formalities;
    }
}
