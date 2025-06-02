import 'package:flutter/material.dart';

sealed class UserProfileEvent {}
class GetUserProfile extends UserProfileEvent {
  final BuildContext context;
  GetUserProfile(this.context);
}