import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UploadImageButtonEvent extends Equatable {
  const UploadImageButtonEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class UploadButtonPressed extends UploadImageButtonEvent {
  final File file;
  final String? desc;
final BuildContext context;
  const UploadButtonPressed({required this.desc,required this.file,required this.context});

  @override
  List<Object?> get props => <Object?>[file, desc];
}