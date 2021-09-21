import 'package:get/get.dart';
import 'package:suitcore_flutter_getx_base_code/feature/cart/cart_controller.dart';
import 'package:suitcore_flutter_getx_base_code/feature/dashboardtab/dashboard_tab_controller.dart';
import 'package:suitcore_flutter_getx_base_code/feature/dialog/dialog_controller.dart';
import 'package:suitcore_flutter_getx_base_code/feature/grid_products/grid_product_controller.dart';
import 'package:suitcore_flutter_getx_base_code/feature/maps/maps_controller.dart';
import 'package:suitcore_flutter_getx_base_code/feature/places/places_controller.dart';

class DashBoardTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardTabController>(() => DashBoardTabController());
    // Get.lazyPut<PlaceController>(() => PlaceController());
    Get.lazyPut<GridProductsController>(() => GridProductsController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<DialogController>(() => DialogController());
    Get.lazyPut<MapsController>(() => MapsController());
  }
}
