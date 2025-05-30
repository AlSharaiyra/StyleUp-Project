package com.styleup.app.infra.exception;

import lombok.Getter;

/**
 * An exception to be thrown if credentials are invalid.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@Getter
public class ErrorSendingOtpException extends RuntimeException{

    private final String errorCode;

    public ErrorSendingOtpException(String message, String errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}
