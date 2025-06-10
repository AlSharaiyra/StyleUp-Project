// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:style_up/l10n/app_localizations.dart';

class ErrorCodes {
  static const String INTERNAL_SERVER_ERROR = 'INTERNAL_SERVER_ERROR';
  static const String VALIDATION_EXCEPTION = 'VALIDATION_EXCEPTION';
  static const String USER_NOT_FOUND = 'USER_NOT_FOUND';
  static const String OTP_NOT_FOUND = 'OTP_NOT_FOUND';
  static const String OTP_IS_EXPIRED = 'OTP_IS_EXPIRED';
  static const String UNVERIFIED_USER = 'UNVERIFIED_USER';
  static const String INVALID_CREDENTIALS = 'INVALID_CREDENTIALS';
  static const String EXPIRED_CREDENTIALS = 'EXPIRED_CREDENTIALS';
  static const String EMAIL_ALREADY_EXISTS = 'EMAIL_ALREADY_EXISTS';
  static const String V_TOKEN_NOT_FOUND = 'V_TOKEN_NOT_FOUND';
  static const String PASSWORD_MISMATCH = 'PASSWORD_MISMATCH';
  static const String REQUEST_TIMEOUT = 'REQUEST_TIMEOUT';
  static const String EMPTY_WARDROBE = 'EMPTY_WARDROBE';
  static const String IMG_UPLOAD_ERROR = 'IMG_UPLOAD_ERROR';
  static const String FEATURE_EXTRACTION_FAILED = 'FEATURE_EXTRACTION_FAILED';
  static const String ITEM_NOT_FOUND = 'ITEM_NOT_FOUND';
  static const String ACTION_NOT_ALLOWED = 'ACTION_NOT_ALLOWED';
  static const String IMG_DELETE_ERROR = 'IMG_DELETE_ERROR';
}

String getErrorMessage(BuildContext context, String errorCode) {
  final loc = AppLocalizations.of(context)!;

  final errorMessages = {
    'INTERNAL_SERVER_ERROR': loc.internalServerError,
    'VALIDATION_EXCEPTION': loc.validationException,
    'USER_NOT_FOUND': loc.userNotFound,
    'OTP_NOT_FOUND': loc.otpNotFound,
    'OTP_IS_EXPIRED': loc.otpIsExpired,
    'UNVERIFIED_USER': loc.unverifiedUser,
    'INVALID_CREDENTIALS': loc.invalidCredentials,
    'EXPIRED_CREDENTIALS': loc.expiredCredentials,
    'EMAIL_ALREADY_EXISTS': loc.emailAlreadyExists,
    'V_TOKEN_NOT_FOUND': loc.vTokenNotFound,
    'PASSWORD_MISMATCH': loc.passMismatch,
    'REQUEST_TIMEOUT': loc.requestTimeout,
    'IMG_DELETE_ERROR':loc.imageDeleteError,
    'ACTION_NOT_ALLOWED':loc.actionNotAllowed,
    'ITEM_NOT_FOUND': loc.itemNotFound,

  };

  // Fallback for unknown error codes
  return errorMessages[errorCode] ?? loc.internalServerError;
}
