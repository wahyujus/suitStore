import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:suitcore_flutter_getx_base_code/feature/places/widgets/place_item.dart';

import '../places_controller.dart';

class ListPlacebuilder extends StatelessWidget {
  const ListPlacebuilder(
    this.controller, {
    Key? key,
  }) : super(key: key);
  final PlaceController controller;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: controller.hasNext,
      controller: controller.refreshController,
      onRefresh: controller.getPlaces,
      onLoading: controller.loadNextPage,
      child: ListView.builder(
        itemCount: controller.dataList.length,
        itemBuilder: (context, index) {
          return PlaceListItem(
            index: index,
            mData: controller.dataList[index],
          );
        },
      ),
    );
  }
}
