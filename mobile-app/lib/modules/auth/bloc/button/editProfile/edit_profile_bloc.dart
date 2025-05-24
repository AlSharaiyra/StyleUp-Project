import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

class EditProfileButtonBloc
    extends Bloc<EditProfileButtonEvent, EditProfileButtonState> {
  EditProfileButtonBloc() : super(OnInit()) {
    on<EditProfileButtonPressed>(_onEditProfileButtonPressed);
  }

  Future<void> _onEditProfileButtonPressed(
    EditProfileButtonPressed event,
    Emitter<EditProfileButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));
      bool isSucssess =
          await AuthController().editProfile(event.email, event.username);
      if (isSucssess) {
        emit(OnSuccess());
      } else {
        emit(const OnFailed(errorMessage: 'EditProfile failed'));
      }
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
