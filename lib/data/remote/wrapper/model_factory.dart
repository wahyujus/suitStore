import 'package:suitcore_flutter_getx_base_code/model/fake_login.dart';
import 'package:suitcore_flutter_getx_base_code/model/login_result.dart';
import 'package:suitcore_flutter_getx_base_code/model/place.dart';
import 'package:suitcore_flutter_getx_base_code/model/products_model.dart';
import 'package:suitcore_flutter_getx_base_code/model/user.dart';

abstract class ModelFactory {
  factory ModelFactory.fromJson(Type type, Map<String, dynamic> json) {
    var strType = type.toString().replaceAll("?", "");

    if (strType == (FakeLogin).toString()) {
      return FakeLogin.fromJson(json);
    } else if (strType == (ProductsModel).toString()) {
      return ProductsModel.fromJson(json);
    } else {
      throw UnimplementedError('`$type` factory unimplemented.');
    }

    //old
    // if (strType == (User).toString()) {
    //   return User.fromJson(json);
    // } else if (strType == (ProductsModel).toString()) {
    //   return ProductsModel.fromJson(json);
    // } else if (strType == (FakeLogin).toString()) {
    //   return FakeLogin.fromJson(json);
    // } else if (strType == (Place).toString()) {
    //   return Place.fromJson(json);
    // } else if (strType == (LoginResult).toString()) {
    //   return LoginResult.fromJson(json);
    // } else {
    //   throw UnimplementedError('`$type` factory unimplemented.');
    // }
  }
}
