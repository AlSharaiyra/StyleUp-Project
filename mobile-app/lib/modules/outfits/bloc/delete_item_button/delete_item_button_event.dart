import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DeleteItemButtonEvent extends Equatable {
  const DeleteItemButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class DeleteItemButtonPressed extends DeleteItemButtonEvent {
  final File file;
  final String? desc;
final BuildContext context;
  const DeleteItemButtonPressed({required this.desc,required this.file,required this.context});

  @override
  List<Object?> get props => <Object?>[file, desc];
}