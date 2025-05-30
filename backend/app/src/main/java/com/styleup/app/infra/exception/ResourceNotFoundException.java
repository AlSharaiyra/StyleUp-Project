package com.styleup.app.infra.exception;

import lombok.Getter;

/**
 * An exception to be thrown if a resource was not found.
 *
 * @author Walid Sharaiyra
 * @since 04/2025
 * @version 1.0
 */
@Getter
public class ResourceNotFoundException extends RuntimeException {

    private final String errorCode;

    public ResourceNotFoundException(String message, String errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}