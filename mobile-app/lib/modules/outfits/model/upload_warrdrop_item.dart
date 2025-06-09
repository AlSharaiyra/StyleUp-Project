import 'package:equatable/equatable.dart';

class UploadWarddropItem extends Equatable {
    const UploadWarddropItem({
        required this.id,
        required this.description,
        required this.url,
        required this.gender,
        required this.masterCategory,
        required this.subCategory,
        required this.articleType,
        required this.baseColour,
        required this.season,
        required this.usage,
    });

    final String id;
    final String description;
    final String url;
    final String gender;
    final String masterCategory;
    final String subCategory;
    final String articleType;
    final String baseColour;
    final String season;
    final String usage;

    factory UploadWarddropItem.fromJson(Map<String, dynamic> json){ 
        return UploadWarddropItem(
            id: json['id'] ?? '',
            description: json['description'] ?? '',
            url: json['url'] ?? '',
            gender: json['gender'] ?? '',
            masterCategory: json['masterCategory'] ?? '',
            subCategory: json['subCategory'] ?? '',
            articleType: json['articleType'] ?? '',
            baseColour: json['baseColour'] ?? '',
            season: json['season'] ?? '',
            usage: json['usage'] ?? '',
        );
    }

    Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'url': url,
        'gender': gender,
        'masterCategory': masterCategory,
        'subCategory': subCategory,
        'articleType': articleType,
        'baseColour': baseColour,
        'season': season,
        'usage': usage,
    };

    @override
    List<Object?> get props => [
    id, description, url, gender, masterCategory, subCategory, articleType, baseColour, season, usage, ];
}
