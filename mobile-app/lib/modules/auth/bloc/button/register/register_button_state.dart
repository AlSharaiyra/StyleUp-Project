import 'package:equatable/equatable.dart';
import 'package:style_up/modules/auth/model/create_user.dart';

sealed class RegisterButtonState extends Equatable {
  const RegisterButtonState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends RegisterButtonState {}

class OnSuccess extends RegisterButtonState {
  final CreateUserResponse user;
  const OnSuccess({required this.user});

  @override
  List<Object?> get props => <Object?>[user];
}

class OnFailed extends RegisterButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends RegisterButtonState {}