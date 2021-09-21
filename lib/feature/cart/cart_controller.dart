import 'package:get/get.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/base/base_list_controller.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/wrapper/custom_response.dart';
import 'package:suitcore_flutter_getx_base_code/model/products_model.dart';

class CartController extends BaseListController<ProductsModel> {
  var myCartList = <ProductsModel>[].obs;
  static CartController find = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void loadNextPage() {
    print('object');
  }

  @override
  void refreshPage() {
    print('object');
  }

  Future<void> addProduct({
    required int id,
    category,
    description,
    image,
    price,
    title,
    required int count,
  }) async {
    ProductsModel productsModel = ProductsModel(
        id: id,
        category: category,
        description: description,
        image: image,
        price: price,
        title: title,
        count: count);

    if (myCartList.isNotEmpty) {
      var indexList = findIndexList(id);
      print(indexList);
      if (indexList >= 0) {
        if (myCartList[indexList].id == id) {
          print("${indexList} - $id");
          print(myCartList[indexList].title);
          updateObject(productsModel, count, price, indexList: indexList);
        } else {
          print("id not match");
        }
      } else {
        if (myCartList.every((element) => element.id == id)) {
          print("same");
        } else {
          addObject(productsModel);
        }
      }
    } else {
      addObject(productsModel);
    }
  }

  updateObject(ProductsModel obj, int count, double price, {int? indexList}) {
    myCartList.value[indexList!] = ProductsModel(
        id: obj.id,
        category: obj.category,
        description: obj.description,
        image: obj.image,
        title: obj.title,
        price: (myCartList[indexList].price! + price),
        count: (myCartList[indexList].count! + count));
    setFinishCallbacks(myCartList);
  }

  addObject(ProductsModel productsModel) {
    myCartList.add(productsModel);
    setFinishCallbacks(myCartList);
  }

  removeObject(id) {
    myCartList.removeWhere((element) => element.id == id);
    setFinishCallbacks(myCartList);
  }

  int findIndexList(int id) {
    var indexList = myCartList.indexWhere((element) => element.id == id);

    return indexList;
  }
}
