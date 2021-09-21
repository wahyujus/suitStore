import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:suitcore_flutter_getx_base_code/feature/cart/cart_controller.dart';
import 'package:suitcore_flutter_getx_base_code/model/products_model.dart';
import 'package:suitcore_flutter_getx_base_code/resources/resources.dart';
import 'package:suitcore_flutter_getx_base_code/utills/widget/state_handle_widget.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My cart'),
      ),
      body: GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: StateHandleWidget(
              shimmerView: CircularProgressIndicator(),
              // loadingEnabled: controller.isShimmering,
              emptyImage: Resources.images.imageEmpty,
              emptyEnabled: controller.isEmptyData,
              emptySubtitle: 'cart is empty',
              errorEnabled: controller.isError,
              errorText: 'txt_error_general'.tr,
              onRetryPressed: () {
                controller.refreshPage();
              },
              body: SmartRefresher(
                  enablePullDown: false,
                  // enablePullUp: controller.hasNext,
                  controller: controller.refreshController,
                  // onRefresh: controller.getProducts,
                  onLoading: controller.loadNextPage,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: controller.dataList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return index == controller.dataList.length
                          ? bottomBar(controller)
                          : content(controller, index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.white,
                      );
                    },
                  )),
            ),
          );
        },
      ),
    );
  }

  Container content(CartController controller, index) {
    var mData = controller.dataList[index];

    return Container(
      width: double.maxFinite,
      height: 100,
      child: Row(
        children: [
          SizedBox(width: 70, height: 100, child: Image.network(mData.image!)),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${mData.title}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$${mData.price!.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            var indexList = controller.findIndexList(mData.id);

                            if (mData.count! > 1) {
                              controller.updateObject(
                                  mData, -1, -(mData.price! / mData.count!),
                                  indexList: indexList);
                            } else {
                              Get.defaultDialog(
                                  onConfirm: () {
                                    controller.removeObject(mData.id);
                                    Get.back();
                                  },
                                  middleText: "delete item?");
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.minus,
                            color: Colors.white,
                          )),
                      Text(
                        '${mData.count}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            var indexList = controller.findIndexList(mData.id);

                            controller.updateObject(
                                mData, 1, (mData.price! / mData.count!),
                                indexList: indexList);
                          },
                          icon: Icon(
                            CupertinoIcons.plus,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomBar(CartController controller) {
    double sum() {
      double totalScores = 0.0;
      // looping over data array
      controller.dataList.forEach((item) {
        //getting the key direectly from the name of the key
        totalScores += item.price!;
      });

      return totalScores;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total : \$${sum().toStringAsFixed(2)}'),
        ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                  onConfirm: () => Get.back(),
                  middleText: 'Total : \$${sum().toStringAsFixed(2)}');
            },
            child: Text('BUY')),
      ],
    );
  }
}
