import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ForgetPasswordPressed extends ForgetPasswordEvent {
  final String email;

  const ForgetPasswordPressed({
    required this.email,
  });

  @override
  List<Object?> get props => <Object?>[
        email,
      ];
}
