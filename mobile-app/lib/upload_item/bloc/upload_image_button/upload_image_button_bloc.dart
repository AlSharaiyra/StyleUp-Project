
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/core/constant/error_codes.dart';
import 'package:style_up/modules/outfits/controller/outfit_controller.dart';
import 'package:style_up/modules/outfits/model/upload_warrdrop_item.dart';
import 'package:style_up/modules/outfits/params/upload_outfit.dart';
import 'upload_image_button_event.dart';
import 'upload_image_button_state.dart';

class UploadImageButtonBloc extends Bloc<UploadImageButtonEvent, UploadImageButtonState> {
  UploadImageButtonBloc() : super(OnInit()) {
    on<UploadButtonPressed>(_onUploadButtonPressed);
  }

  Future<void> _onUploadButtonPressed(
    UploadButtonPressed event,
    Emitter<UploadImageButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));
      final SecureTokenStorage secureTokenStorage = SecureTokenStorage.instance;
      final response = await OutfitController()
          .addOutfit(UploadOutfitParams(image: event.file, description: event.desc,accessToken: await secureTokenStorage.getAccessToken()??''), event.context);
      response.fold(
        (String l) {
          final errorMessage = getErrorMessage(event.context, l);

          emit(OnFailed(errorMessage: errorMessage));
        },
        (UploadWarddropItem r) {


          emit(OnSuccess());
        },
      );
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
