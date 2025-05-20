import 'package:flutter/material.dart';
class SettingsItemModel {
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  SettingsItemModel({
    required this.title,
    required this.trailing,
    this.onTap,
  });
}
class SettingsSection {
  final String sectionTitle;
  final List<SettingsItemModel> items;

  SettingsSection({required this.sectionTitle, required this.items});
}
