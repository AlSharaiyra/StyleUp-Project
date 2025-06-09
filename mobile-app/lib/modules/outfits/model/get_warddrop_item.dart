import 'package:equatable/equatable.dart';

class GetWarddropItems extends Equatable {
    const GetWarddropItems({
        required this.itemId,
        required this.url,
        required this.description,
    });

    final String itemId;
    final String url;
    final String description;

    factory GetWarddropItems.fromJson(Map<String, dynamic> json){ 
        return GetWarddropItems(
            itemId: json['itemId'] ?? '',
            url: json['url'] ?? '',
            description: json['description'] ?? '',
        );
    }

    Map<String, dynamic> toJson() => {
        'itemId': itemId,
        'url': url,
        'description': description,
    };

    @override
    List<Object?> get props => [
    itemId, url, description, ];
}
