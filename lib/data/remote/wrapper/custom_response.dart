import 'package:json_annotation/json_annotation.dart';

part 'custom_response.g.dart';

@JsonSerializable()
class CustomResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'rating')
  RatingResponse? rating;

  CustomResponse({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory CustomResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomResponseToJson(this);
}

@JsonSerializable()
class RatingResponse {
  @JsonKey(name: 'rate')
  double? rate;
  @JsonKey(name: 'count')
  dynamic count;

  RatingResponse({
    this.rate,
    this.count,
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) =>
      _$RatingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RatingResponseToJson(this);
}
