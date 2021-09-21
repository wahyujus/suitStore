import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/wrapper/custom_response.dart';
import 'package:suitcore_flutter_getx_base_code/feature/grid_products/grid_product_controller.dart';
import 'package:suitcore_flutter_getx_base_code/resources/resources.dart';
import 'package:suitcore_flutter_getx_base_code/utills/widget/state_handle_widget.dart';

class GridProducts extends StatelessWidget {
  const GridProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<GridProductsController>(
          init: GridProductsController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: StateHandleWidget(
                shimmerView: CircularProgressIndicator(),
                loadingEnabled: controller.isShimmering,
                emptyEnabled: controller.isEmptyData,
                emptySubtitle: 'txt_empty_user'.tr,
                errorEnabled: controller.isError,
                errorText: 'txt_error_general'.tr,
                onRetryPressed: () {
                  controller.refreshPage();
                },
                body: listBuilder(controller),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget listBuilder(GridProductsController controller) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: controller.hasNext,
      controller: controller.refreshController,
      onRefresh: controller.getProducts,
      onLoading: controller.loadNextPage,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: controller.dataList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          return index == 0
              ? myTextField(controller)
              : listContainer(controller, index);
        },
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(index == 0 ? 4 : 2, index == 0 ? 5.1 : 2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
    );
  }

  Widget myTextField(GridProductsController controller) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey),
              hintText: 'I want to buy..',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              fillColor: Colors.white.withOpacity(0.2)),
        ),
        SizedBox(
          height: 20,
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: Get.width * 0.86,
              height: Get.width * 0.45,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(13)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                width: Get.width * 0.88,
                height: Get.width * 0.45,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20),
                width: double.maxFinite,
                height: Get.width * 0.45,
                decoration: BoxDecoration(
                  color: Resources.color.colorPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New items with\nfree shipping',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        Get.defaultDialog(
                            onConfirm: () => Get.back(),
                            middleText: "Dialog made in 3 lines of code");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 12),
                        child: Text(
                          'Check',
                          style: TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: Get.width * 0.17,
              right: 20,
              child: Icon(
                CupertinoIcons.shopping_cart,
                size: 90,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.maxFinite,
          // color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Popular categories',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.catagories.length,
                  (index) => InkWell(
                    onTap: () => controller.selectedCat.value = index,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11.0, vertical: 15),
                      child: Column(
                        children: [
                          Obx(() => CircleAvatar(
                                backgroundColor: controller.selectedCat == index
                                    ? Color(0xFFd7834f)
                                    : Colors.grey.withOpacity(0.2),
                                child: Icon(
                                  controller.catagories[index]['icon'],
                                  color: Colors.white,
                                  size: 40,
                                ),
                                maxRadius: 35,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(controller.catagories[index]['name'])
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget listContainer(GridProductsController controller, index) {
    CustomResponse mData = controller.dataList[index - 1];
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(mData.image!),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    '\$${mData.price}',
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${mData.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontFamily: "Roboto",
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(Get.context!).showSnackBar(
                  SnackBar(
                    content: Text('added to cart'),
                    duration: Duration(milliseconds: 1000),
                    backgroundColor: Resources.color.colorSecondary,
                    action: SnackBarAction(
                      label: '🗑 Undo',
                      onPressed: () {
                        controller.cartController.removeObject(mData.id);
                      },
                      textColor: Colors.white,
                    ),
                  ),
                );

                controller.cartController.addProduct(
                  id: mData.id!,
                  category: mData.category,
                  description: mData.description,
                  image: mData.image,
                  price: mData.price,
                  title: mData.title,
                  count: 1,
                );
              },
              child: CircleAvatar(
                backgroundColor: Resources.color.colorPrimary,
                maxRadius: 15,
                child: Icon(
                  CupertinoIcons.cart_fill,
                  size: 17,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
