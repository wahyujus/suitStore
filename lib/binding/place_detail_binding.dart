import 'package:get/get.dart';
import 'package:suitcore_flutter_getx_base_code/feature/places/detail/place_detail_controller.dart';

class PlaceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaceDetailController>(
        () => PlaceDetailController(id: Get.arguments));
  }
}
