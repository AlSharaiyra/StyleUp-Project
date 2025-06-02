class FilterEvent {}

class ToggleTypeSection extends FilterEvent{}

class ToggleSeasonSection extends FilterEvent{}

class SelectType extends FilterEvent {
  final String type;
  SelectType(this.type);
}

class SelectSeason extends FilterEvent {
  final String season;
  SelectSeason(this.season);
}