import 'package:equatable/equatable.dart';

class FilterOptions extends Equatable{
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

  const FilterOptions({this.type, this.season});


  FilterOptions copyWith({String? type, String? season}) {
    return FilterOptions(
      type: type ?? this.type, 
      season: season ?? this.season, 
    );
  }
  bool get isActive => type != null || season != null;

  @override
  List<Object?> get props => [type, season];
}
