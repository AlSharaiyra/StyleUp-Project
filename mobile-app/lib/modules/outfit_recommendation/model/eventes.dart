import 'package:equatable/equatable.dart';

class EventsResponse extends Equatable {
    const EventsResponse({
        required this.name,
        required this.displayName,
    });

    final String name;
    final String displayName;

    factory EventsResponse.fromJson(Map<String, dynamic> json){ 
        return EventsResponse(
            name: json['name'] ?? '',
            displayName: json['displayName'] ?? '',
        );
    }

    Map<String, dynamic> toJson() => {
        'name': name,
        'displayName': displayName,
    };

    @override
    List<Object?> get props => [
    name, displayName, ];
}
