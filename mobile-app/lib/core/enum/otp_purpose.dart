 enum OtpPurpose {

    CREATE_USER,
    RESET_PASSWORD
}
String getOtpPurpose(OtpPurpose otpPurpose) {
  switch (otpPurpose) {
    case OtpPurpose.CREATE_USER:
      return 'CREATE_USER';
    case OtpPurpose.RESET_PASSWORD:
      return 'RESET_PASSWORD';
  }
}