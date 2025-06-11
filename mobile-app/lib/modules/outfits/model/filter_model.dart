import 'package:equatable/equatable.dart';

class FilterOptions extends Equatable {
  static const List<String> typeOptions = [
    'Apparel',
    'Accessories',
    'Footwear',
  ];

  static const List<String> seasonOptions = [
    'Winter',
    'Spring',
    'Summer',
    'Fall',
  ];
  final String? type;
  final String? season;
  final int page;
  final int limit;
  const FilterOptions({this.type, this.season, this.page = 0, this.limit=8});

  FilterOptions copyWith(
      {String? type, String? season, int? page, int? limit}) {
    return FilterOptions(
      type: type ?? this.type,
      season: season ?? this.season,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  bool get isActive => type != null || season != null;

  @override
  List<Object?> get props => [type, season];
}
