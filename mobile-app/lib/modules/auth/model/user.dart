// ignore_for_file: unnecessary_getters_setters, must_be_immutable


import 'package:equatable/equatable.dart';

import '../../../core/enum/gender.dart';

class User extends Equatable{
  String _email;
  String _username;
  int _age;
  GenderEnum _gender;
  String _password;

  User({
    required String email,
    required String username,
    required int age,
    required GenderEnum gender,
    required String password,
  })  : _email = email,
        _username = username,
        _age = age,
        _gender = gender,
        _password = password;

  // Getters
  String get email => _email;
  String get username => _username;
  int get age => _age;
  GenderEnum get gender => _gender;
  String get password => _password;

  // Setters
  set email(String email) => _email = email;
  set username(String username) => _username = username;
  set age(int age) => _age = age;
  set gender(GenderEnum gender) => _gender = gender;
  set password(String password) => _password = password;

  // Convert from JSON
  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        username: json['username'],
        age: json['age'],
        gender: GenderEnum.values.firstWhere((GenderEnum e) => e.toString().split('.').last == json['gender']),
        password: json['password'],
      );

  // Convert to JSON
  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': _email,
        'username': _username,
        'age': _age,
        'gender': _gender.toString().split('.').last,
        'password': _password,
      };
      
        @override
        List<Object?> get props => <Object?>[_email,_username,_age,_gender,_password];
}
