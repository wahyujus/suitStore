import 'package:json_annotation/json_annotation.dart';

part 'fake_login_response.g.dart';

@JsonSerializable()
class FakeLoginResponse {
  @JsonKey(name: 'token')
  String? token;

  FakeLoginResponse({
    this.token,
  });

  factory FakeLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$FakeLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FakeLoginResponseToJson(this);
}
