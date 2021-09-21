import 'package:get/get.dart';
import 'package:suitcore_flutter_getx_base_code/feature/cart/cart_controller.dart';
import 'package:suitcore_flutter_getx_base_code/feature/grid_products/grid_product_controller.dart';
import 'package:suitcore_flutter_getx_base_code/feature/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
