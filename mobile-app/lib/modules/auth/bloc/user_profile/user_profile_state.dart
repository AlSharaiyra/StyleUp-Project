import 'package:equatable/equatable.dart';
import 'package:style_up/modules/auth/model/user_info.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => <Object>[];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}
class UserProfileError extends UserProfileState {
  final String message;
  const UserProfileError(this.message);
}
class UserProfileSucsess extends UserProfileState {
  final GetUserResponse user;
  const UserProfileSucsess(this.user);
}