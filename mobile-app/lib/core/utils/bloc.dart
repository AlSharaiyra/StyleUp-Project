// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/bloc/language/language_bloc.dart';
import 'package:style_up/core/bloc/theme/theme_bloc.dart';
import 'package:style_up/core/utils/material_app.dart';
import 'package:style_up/modules/auth/bloc/age_picker/age_picker_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/VerifyOtp/verify_otp_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/ageAndGender/age_gender_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/editProfile/edit_profile_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/forgetPassword/forget_password_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/resendOtp/resend_otp_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/register/register_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/resetPassword/reset_password_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/page/page_bloc.dart';
import 'package:style_up/modules/auth/bloc/otp/pin_code_bloc.dart';
import 'package:style_up/modules/auth/bloc/change_gender/change_gender_bloc.dart';
import 'package:style_up/modules/auth/bloc/secure_eye/secure_eye_bloc.dart';
import 'package:style_up/modules/auth/bloc/secure_eye_confirm/secure_eye_confirm_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/editProfile/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/forgetPassword/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/register/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/login/login_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/login/form_bloc.dart';
import 'package:style_up/modules/auth/bloc/textfield/resetPassword/reset_password_bloc.dart';
import 'package:style_up/modules/outfits/bloc/delete_item_button/delete_item_button_bloc.dart';
import 'package:style_up/modules/outfits/bloc/filter/expaned_filter_bloc.dart';
import 'package:style_up/modules/auth/bloc/user_profile/user_profile_bloc.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_bloc.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_event.dart';
import 'package:style_up/modules/outfits/model/filter_model.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';
import 'package:style_up/modules/outfits/services/outfit_service.dart';
import 'package:style_up/modules/upload_item/bloc/image_bloc/image_bloc.dart';
import 'package:style_up/modules/upload_item/bloc/upload_image_button/upload_image_button_bloc.dart';

import '../../modules/bottom_bar/bloc/navigationbar/navigation_bloc.dart';

class BlocUtils extends StatelessWidget {
  const BlocUtils({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (repoContext) => OutfitService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => SecureEyeBloc(),
          ),
          BlocProvider(
            create: (context) => SecureEyeConfirmBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => AgePickerBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => UserProfileBloc(),
          ),
          BlocProvider(
            create: (context) => PinCodeBloc(),
          ),
          BlocProvider(
            create: (context) => ChangeGenderBloc(),
          ),
          BlocProvider(
            create: (context) => PageBloc(),
          ),
          BlocProvider(
            create: (context) => UploadImageButtonBloc(),
          ),
          BlocProvider(
            create: (context) => DeleteItemButtonBloc(),
          ),
          BlocProvider(
            create: (context) => LoginFormBloc(),
          ),
          BlocProvider(
            create: (context) => RegisterFieldsFormBloc(),
          ),
          BlocProvider(
            create: (context) => LoginButtonBloc(),
          ),
          BlocProvider(
            create: (context) => RegisterButtonBloc(),
          ),
          BlocProvider(
            create: (context) => ResendOtpButtonBloc(),
          ),
          BlocProvider(
            create: (context) => VerifyOtpButtonBloc(),
          ),
          BlocProvider(
            create: (context) => AgeGenderButtonBloc(),
          ),
          BlocProvider(
            create: (context) => ForgetPasswordBloc(),
          ),
          BlocProvider(
            create: (context) => ForgetPasswordFormBloc(),
          ),
          BlocProvider(
            create: (context) => ResetPasswordButtonBloc(),
          ),
          BlocProvider(
            create: (context) => ResetPasswordFieldsFormBloc(),
          ),
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider(
            create: (context) => LanguageBloc(),
          ),
          BlocProvider(create: (context) => NavigationBloc()),
          BlocProvider(create: (context) => EditProfileButtonBloc()),
          BlocProvider(create: (context) => EditProfileFormBloc()),
          BlocProvider(create: (context) => ExpanedFilterBloc()),
          BlocProvider(create: (context) => ImageBloc()),
          BlocProvider(
            create: (blocContext) {
              return OutfitBloc(context: context)
                ..add(
                  LoadOutfitsEvent(
                    params: const GetOutfitParams(
                      filterOptions: FilterOptions(),
                    ),
                    context: context,
                  ),
                );
            },
          ),
        ],
        child: const MaterialAppUtils(),
      ),
    );
  }
}
