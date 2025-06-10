package com.styleup.app.infra.exception;

import lombok.Getter;

/**
 * An exception to be thrown if an error occurred while handling Wasabi operations.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@Getter
public class WasabiErrorException extends RuntimeException{

    private final String errorCode;

    public WasabiErrorException(String message, String errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}
