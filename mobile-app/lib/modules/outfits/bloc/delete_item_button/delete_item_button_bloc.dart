import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/core/constant/error_codes.dart';
import 'package:style_up/modules/outfits/controller/outfit_controller.dart';
import 'package:style_up/modules/outfits/params/delete_outfit.dart';
import 'delete_item_button_event.dart';
import 'delete_item_button_state.dart';

class DeleteItemButtonBloc extends Bloc<DeleteItemButtonEvent, DeleteItemButtonState> {
  DeleteItemButtonBloc() : super(OnInit()) {
    on<DeleteItemButtonPressed>(_onUploadButtonPressed);
  }

  Future<void> _onUploadButtonPressed(
    DeleteItemButtonPressed event,
    Emitter<DeleteItemButtonState> emit,
  ) async {
    emit(OnLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));
      final SecureTokenStorage secureTokenStorage = SecureTokenStorage.instance;
      final response = await OutfitController()
          .removeOutfitById(DeleteOutfitParams(accessToken:await secureTokenStorage.getAccessToken()??'',outfitId: event.id), event.context);
      response.fold(
        (String l) {
          final errorMessage = getErrorMessage(event.context, l);

          emit(OnFailed(errorMessage: errorMessage));
        },
        (String r) {


          emit(OnSuccess(message: r));
        },
      );
    } catch (e) {
      emit(OnFailed(errorMessage: e.toString()));
    }
  }
}
