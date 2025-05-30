package com.styleup.app.infra.exception;

import lombok.Getter;

/**
 * An exception to be thrown if a resource already exists in database.
 *
 * @author Walid Sharaiyra
 * @since 04/2025
 * @version 1.0
 */
@Getter
public class ResourceAlreadyExistsException extends RuntimeException {

    private final String errorCode;

    public ResourceAlreadyExistsException(String message, String errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}
