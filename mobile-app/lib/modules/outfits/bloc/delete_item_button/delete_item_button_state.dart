import 'package:equatable/equatable.dart';

sealed class DeleteItemButtonState extends Equatable {
  const DeleteItemButtonState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends DeleteItemButtonState {}

class OnSuccess extends DeleteItemButtonState {}

class OnFailed extends DeleteItemButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends DeleteItemButtonState {}