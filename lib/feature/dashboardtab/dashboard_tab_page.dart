import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'package:suitcore_flutter_getx_base_code/feature/cart/cart_view.dart';
import 'package:suitcore_flutter_getx_base_code/feature/dialog/sample_dialog_page.dart';
import 'package:suitcore_flutter_getx_base_code/feature/grid_products/grid_products.dart';
import 'package:suitcore_flutter_getx_base_code/feature/maps/maps_page.dart';
import 'package:suitcore_flutter_getx_base_code/feature/other/other_page.dart';
import 'package:suitcore_flutter_getx_base_code/feature/places/places_page.dart';
import 'package:suitcore_flutter_getx_base_code/utills/widget/colored_status_bar.dart';

import 'dashboard_tab_controller.dart';

class DashBoardTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardTabController>(
      builder: (controller) {
        return ColoredStatusBar(
          child: Scaffold(
            body: IndexedStack(
              index: controller.tabIndex,
              children: [
                // PlacePage(),
                GridProducts(),
                Cart(),
                // DialogPage(),
                // MapsPage(),
                OtherPage(),
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border(
                    top: BorderSide(color: Colors.transparent, width: 1.0)),
              ),
              child: BottomNavigationBar(
                onTap: controller.changeTabIndex,
                currentIndex: controller.tabIndex,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: [
                  _bottomNavigationBarItem(
                    icon: LineIcons.home,
                    label: 'txt_menu_home'.tr,
                  ),
                  _bottomNavigationBarItem(
                    icon: CupertinoIcons.cart_fill,
                    label: 'Cart',
                  ),
                  // _bottomNavigationBarItem(
                  //   icon: CupertinoIcons.map,
                  //   label: 'txt_menu_maps'.tr,
                  // ),
                  _bottomNavigationBarItem(
                    icon: CupertinoIcons.bag,
                    label: 'txt_menu_other'.tr,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
