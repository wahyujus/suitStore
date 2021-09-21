import 'package:suitcore_flutter_getx_base_code/data/remote/wrapper/model_factory.dart';

class FakeLogin implements ModelFactory {
  final String? token;

  const FakeLogin({
    this.token,
  });

  factory FakeLogin.fromJson(Map<String, dynamic> json) => FakeLogin(
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'token': this.token,
      };
}
