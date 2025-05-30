package com.styleup.app.infra.exception;

import lombok.Getter;

/**
 * An exception to be thrown if a user is unverified.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@Getter
public class UnverifiedUserException extends RuntimeException {

    private final String errorCode;

    public UnverifiedUserException(String message, String errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}
