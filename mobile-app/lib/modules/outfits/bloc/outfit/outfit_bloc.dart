// lib/modules/outfits/bloc/outfit_bloc.dart
// ignore_for_file: avoid_dynamic_calls

// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/config/secure_token_storage.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_event.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_state.dart';
import 'package:style_up/modules/outfits/controller/outfit_controller.dart';
import 'package:style_up/modules/outfits/params/get_outfit.dart';

class OutfitBloc extends Bloc<OutfitEvent, OutfitState> {
  OutfitBloc({required BuildContext context}) : super(const OutfitInitial()) {
    on<LoadOutfitsEvent>((event, emit) => _onLoadOutfits(event, emit));
  }

  Future<void> _onLoadOutfits(
      LoadOutfitsEvent event, Emitter<OutfitState> emit) async {
        final state=this.state is OutfitLoaded? this.state as OutfitLoaded :null;
final isInitialLoad = event.params.filterOptions.page == 0;
    if (isInitialLoad) {
      emit(const OutfitLoading(isInitialLoad: true));
    }    OutfitController outfitController = OutfitController();
    final secureTokenStorage = SecureTokenStorage.instance;

    final result = await outfitController.getOutfits(
        GetOutfitParams(
            filterOptions: event.params.filterOptions,
            accessToken: await secureTokenStorage.getAccessToken()),
        event.context);
    result.fold(
      (errorString) => emit(OutfitError(message: errorString)),
      (outfits) {
        final totalOutfits=(state?.totalOutfits??[])+outfits;

        emit(OutfitLoaded(outfits: outfits,totalOutfits: totalOutfits));
      },
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
