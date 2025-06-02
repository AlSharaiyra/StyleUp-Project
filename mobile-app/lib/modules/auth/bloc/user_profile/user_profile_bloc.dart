import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/core/constant/error_codes.dart';
import 'package:style_up/modules/auth/bloc/user_profile/user_profile_event.dart';
import 'package:style_up/modules/auth/bloc/user_profile/user_profile_state.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'package:style_up/modules/auth/model/user_info.dart';
import 'package:style_up/modules/auth/params/get_user_info_params.dart';

class UserProfileBloc
    extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc() : super(UserProfileInitial()) {
    on<GetUserProfile>(_onUserProfileGet);
  }

  Future<void> _onUserProfileGet(
    GetUserProfile event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(UserProfileLoading());

    try {
      final SecureTokenStorage storage=SecureTokenStorage.instance;
      final response = await AuthController().getUserInfo(GetUserInfoParams(accessToken:await storage.getAccessToken() ??''));
      await Future.delayed(const Duration(seconds: 2));
      response.fold(
        (String l) {
          log('error message $l');
          final errorMessage = getErrorMessage(event.context, l);

          emit( UserProfileError(errorMessage));
        },
        (GetUserResponse r) {
          emit(UserProfileSucsess( r));
        },
      );
    } catch (e) {
      emit(UserProfileError( e.toString()));
    }
  }
}
