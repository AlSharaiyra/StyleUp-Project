// lib/modules/outfits/bloc/outfit_bloc.dart
// ignore_for_file: avoid_dynamic_calls

// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_event.dart';
import 'package:style_up/modules/outfits/bloc/outfit/outfit_state.dart';
import 'package:style_up/modules/outfits/services/outfit_interface.dart';
import 'package:style_up/modules/outfits/services/outfit_service.dart';


class OutfitBloc extends Bloc<OutfitEvent, OutfitState> {
  final IOutfitService _outfitService;

  OutfitBloc(this._outfitService, {required BuildContext context, required OutfitService outfitService}) : super(const OutfitInitial()) {
   on<LoadOutfitsEvent>((event, emit) => _onLoadOutfits(event, emit));
  }

  
  Future<void> _onLoadOutfits(LoadOutfitsEvent event, Emitter<OutfitState> emit) async {
    emit(const OutfitLoading());

    final result = await _outfitService.getOutfits(event.params, event.context);

    result.fold(
      (errorString) => emit(OutfitError(message: errorString)), 
      (outfits) => emit(OutfitLoaded(outfits: outfits)),       
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}