import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';
import 'package:suitcore_flutter_getx_base_code/data/local/hive/hive_constants.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/api_services.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/base/base_list_controller.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/errorhandler/error_handler.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/wrapper/custom_response.dart';
import 'package:suitcore_flutter_getx_base_code/feature/cart/cart_controller.dart';
import 'package:suitcore_flutter_getx_base_code/model/products_model.dart';
import 'package:get/get.dart';

class GridProductsController extends BaseListController<CustomResponse> {
  final CartController cartController = CartController.find;
  static GridProductsController find = Get.find();

  @override
  void onInit() {
    // getCacheBox(HiveConstants.PRODUCTS).then((value) => getProducts());
    getProducts();
    super.onInit();
  }

  @override
  void loadNextPage() {
    getProducts(page: page.value += 4);
  }

  @override
  void refreshPage() {
    getProducts();
  }

  Future<void> getProducts({int page = 4}) async {
    loadingState();
    await client.then(
      (value) => value.getProducts(page).then(
        (data) {
          hasNext = data.isNotEmpty;
          if (page == 1) {
            dataList.clear();
            saveCache(data, idList: data.map((e) => "${e.id}"));
          }
          setFinishCallbacks(data);
        },
      ).handleError((onError) {
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
      }),
    );
  }

  var selectedCat = 0.obs;

  List<Map<String, dynamic>> catagories = [
    {
      "name": "T-Shirts",
      "icon": LineIcons.tShirt,
    },
    {
      "name": "Sneakers",
      "icon": LineIcons.shoePrints,
    },
    {
      "name": "Guitar",
      "icon": LineIcons.guitar,
    },
    {
      "name": "Wallet",
      "icon": LineIcons.wallet,
    },
  ];
}
