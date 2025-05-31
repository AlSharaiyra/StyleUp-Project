import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @socialSignIn.
  ///
  /// In en, this message translates to:
  /// **'Or Sign in with'**
  String get socialSignIn;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Created Account'**
  String get registerTitle;

  /// No description provided for @acceptPolicy.
  ///
  /// In en, this message translates to:
  /// **'By creating your account you accept the Terms of use and Privacy Policy'**
  String get acceptPolicy;

  /// No description provided for @registerDesc.
  ///
  /// In en, this message translates to:
  /// **'Fill Your Information below or register with your social account.'**
  String get registerDesc;

  /// No description provided for @loginDesc.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, you\'ve been missed'**
  String get loginDesc;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @createAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get createAccountButton;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note '**
  String get note;

  /// No description provided for @accountGoverned.
  ///
  /// In en, this message translates to:
  /// **'This account is governed by our '**
  String get accountGoverned;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// No description provided for @termsAndCondition.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions.'**
  String get termsAndCondition;

  /// No description provided for @appPolicy.
  ///
  /// In en, this message translates to:
  /// **'By using this app, you agree to comply with these policies.'**
  String get appPolicy;

  /// No description provided for @verifyAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Account'**
  String get verifyAccountTitle;

  /// No description provided for @otpDesc.
  ///
  /// In en, this message translates to:
  /// **'We want to know it’s you !!'**
  String get otpDesc;

  /// No description provided for @otpEnterCodeDesc.
  ///
  /// In en, this message translates to:
  /// **'Please enter the code we sent to your E-mail'**
  String get otpEnterCodeDesc;

  /// No description provided for @didntReceive.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive OTP?'**
  String get didntReceive;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @verifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyButton;

  /// No description provided for @agePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'How old are You?'**
  String get agePickerTitle;

  /// No description provided for @agePickerDesc.
  ///
  /// In en, this message translates to:
  /// **'This helps to find the best for you'**
  String get agePickerDesc;

  /// No description provided for @genderTitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get genderTitle;

  /// No description provided for @genderDesc.
  ///
  /// In en, this message translates to:
  /// **'To give you a better experience, we want to know your gender'**
  String get genderDesc;

  /// No description provided for @maleGender.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get maleGender;

  /// No description provided for @femaleGender.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get femaleGender;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @internalServerError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again later.'**
  String get internalServerError;

  /// No description provided for @validationException.
  ///
  /// In en, this message translates to:
  /// **'Please check the entered information.'**
  String get validationException;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get userNotFound;

  /// No description provided for @otpNotFound.
  ///
  /// In en, this message translates to:
  /// **'OTP not found. Please request a new one.'**
  String get otpNotFound;

  /// No description provided for @otpIsExpired.
  ///
  /// In en, this message translates to:
  /// **'OTP has expired. Please request a new one.'**
  String get otpIsExpired;

  /// No description provided for @unverifiedUser.
  ///
  /// In en, this message translates to:
  /// **'Your account is not verified.'**
  String get unverifiedUser;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get invalidCredentials;

  /// No description provided for @expiredCredentials.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get expiredCredentials;

  /// No description provided for @emailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered.'**
  String get emailAlreadyExists;

  /// No description provided for @vTokenNotFound.
  ///
  /// In en, this message translates to:
  /// **'Verification token not found.'**
  String get vTokenNotFound;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordMismatch;

  /// No description provided for @requestTimeout.
  ///
  /// In en, this message translates to:
  /// **'The request timed out. Please try again.'**
  String get requestTimeout;

  /// No description provided for @finishButton.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishButton;

  /// No description provided for @forgetPass.
  ///
  /// In en, this message translates to:
  /// **'Forget your pass?'**
  String get forgetPass;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @passRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'\'Please enter a valid email address\''**
  String get invalidEmail;

  /// No description provided for @invalidPass.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long and include:\n- One uppercase letter\n- One lowercase letter\n- One digit\n- One special character (!@#\$%^&*)'**
  String get invalidPass;

  /// No description provided for @passMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passMismatch;

  /// No description provided for @invalidUsername.
  ///
  /// In en, this message translates to:
  /// **'Username must be 3-16 characters long and can only contain letters, numbers, and underscores'**
  String get invalidUsername;

  /// No description provided for @usernameRequired.
  ///
  /// In en, this message translates to:
  /// **'username is required'**
  String get usernameRequired;

  /// No description provided for @forgetPassTitle.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassTitle;

  /// No description provided for @forgetPassButton.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassButton;

  /// No description provided for @forgetPassDesc.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get forgetPassDesc;

  /// No description provided for @resetPassButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassButton;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logout_confirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logout_confirm;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @resetPassDesc.
  ///
  /// In en, this message translates to:
  /// **'Please enter your new password'**
  String get resetPassDesc;

  /// No description provided for @resetPassTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassTitle;

  /// No description provided for @resetPassSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully'**
  String get resetPassSuccess;

  /// No description provided for @resetPassError.
  ///
  /// In en, this message translates to:
  /// **'Error resetting password'**
  String get resetPassError;

  /// No description provided for @resetPassSuccessDesc.
  ///
  /// In en, this message translates to:
  /// **'Your password has been reset successfully. You can now log in with your new password.'**
  String get resetPassSuccessDesc;

  /// No description provided for @resetPassErrorDesc.
  ///
  /// In en, this message translates to:
  /// **'There was an error resetting your password. Please try again later.'**
  String get resetPassErrorDesc;

  /// No description provided for @recommendationSelectEvent.
  ///
  /// In en, this message translates to:
  /// **'Select your events'**
  String get recommendationSelectEvent;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationToggle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationToggle;

  /// No description provided for @regional.
  ///
  /// In en, this message translates to:
  /// **'Regional'**
  String get regional;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @acccesibilty_tools.
  ///
  /// In en, this message translates to:
  /// **'Accessibilty tools'**
  String get acccesibilty_tools;

  /// No description provided for @my_closet.
  ///
  /// In en, this message translates to:
  /// **'My Closet'**
  String get my_closet;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @edit_profile_desc.
  ///
  /// In en, this message translates to:
  /// **'Change your name and email on the website below'**
  String get edit_profile_desc;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
