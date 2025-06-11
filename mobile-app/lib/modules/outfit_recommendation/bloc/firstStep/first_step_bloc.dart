// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:style_up/modules/outfit_recommendation/bloc/firstStep/first_step_event.dart';
// import 'package:style_up/modules/outfit_recommendation/bloc/firstStep/first_step_state.dart';

// class FirstStepBloc extends Bloc<FirstStepEvent,FirstStepState>{
//   FirstStepBloc() : super(FirstStepInitial()) {
//     on<FirstStepFetchEvents>((event, emit) async {
//       emit(FirstStepLoading());
//       try {
// final respon        await Future.delayed(const Duration(seconds: 2));
//         emit(FirstStepSuccess(events: [])); // Replace with actual events
//       } catch (e) {
//         emit(FirstStepError(error: e.toString()));
//       }
//     });
//   }
// }