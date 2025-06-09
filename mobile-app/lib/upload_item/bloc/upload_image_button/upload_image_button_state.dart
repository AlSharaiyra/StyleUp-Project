import 'package:equatable/equatable.dart';

sealed class UploadImageButtonState extends Equatable {
  const UploadImageButtonState();

  @override
  List<Object?> get props => <Object?>[];
}
class OnInit extends UploadImageButtonState {}

class OnSuccess extends UploadImageButtonState {}

class OnFailed extends UploadImageButtonState {
  final String errorMessage;

  const OnFailed({required this.errorMessage});

  @override
  List<Object?> get props => <Object?>[errorMessage];
}

class OnLoading extends UploadImageButtonState {}