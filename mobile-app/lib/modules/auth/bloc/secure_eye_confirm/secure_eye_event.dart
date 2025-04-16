import 'package:equatable/equatable.dart';

sealed class SecureConfirmEyeEvent  extends Equatable{}

class ConfirmEyeOnEnable extends SecureConfirmEyeEvent{
  @override
  List<Object?> get props => <Object?>[];
}
class ConfirmEyeOnDisable extends SecureConfirmEyeEvent{
  @override
  List<Object?> get props => <Object?>[];
}