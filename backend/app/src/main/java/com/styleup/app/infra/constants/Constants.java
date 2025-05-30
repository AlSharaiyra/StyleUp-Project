package com.styleup.app.infra.constants;

import org.springframework.beans.factory.annotation.Value;

public class Constants {

    public static final long OTP_LIFETIME = 1; // 1 Minute
    public static final long VERIFICATION_TOKEN_LIFETIME = 2; // 2 MinuteS
    public static final long JWT_ACCESS_EXPIRATION = 1000 * 60 * 60; // 1 Hour
    public static final long JWT_REFRESH_EXPIRATION = 1000 * 60 * 60 * 24 * 15; // 15 Days

}
