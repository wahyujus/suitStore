// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomResponse _$CustomResponseFromJson(Map<String, dynamic> json) {
  return CustomResponse(
    id: json['id'] as int?,
    title: json['title'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    description: json['description'] as String?,
    category: json['category'] as String?,
    image: json['image'] as String?,
    rating: json['rating'] == null
        ? null
        : RatingResponse.fromJson(json['rating'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CustomResponseToJson(CustomResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
      'rating': instance.rating,
    };

RatingResponse _$RatingResponseFromJson(Map<String, dynamic> json) {
  return RatingResponse(
    rate: (json['rate'] as num?)?.toDouble(),
    count: json['count'],
  );
}

Map<String, dynamic> _$RatingResponseToJson(RatingResponse instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'count': instance.count,
    };
