import 'package:hive/hive.dart';
import 'package:suitcore_flutter_getx_base_code/model/place.dart';
import 'package:suitcore_flutter_getx_base_code/model/products_model.dart';
import 'package:suitcore_flutter_getx_base_code/model/user.dart';

class HiveAdapters {
  void registerAdapter() {
    Hive.registerAdapter<User>(UserAdapter());
    Hive.registerAdapter<Place>(PlaceAdapter());
    Hive.registerAdapter<ProductsModel>(ProductsModelAdapter());
  }
}
