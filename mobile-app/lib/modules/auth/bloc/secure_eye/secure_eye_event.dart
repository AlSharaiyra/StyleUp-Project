import 'package:equatable/equatable.dart';

sealed class SecureEyeEvent  extends Equatable{}

class EyeOnEnable extends SecureEyeEvent{
  @override
  List<Object?> get props => <Object?>[];
}
class EyeOnDisable extends SecureEyeEvent{
  @override
  List<Object?> get props => <Object?>[];
}