import 'package:get/get.dart';
import 'package:suitcore_flutter_getx_base_code/binding/dashboard_tab_binding.dart';
import 'package:suitcore_flutter_getx_base_code/binding/login_binding.dart';
import 'package:suitcore_flutter_getx_base_code/binding/place_detail_binding.dart';
import 'package:suitcore_flutter_getx_base_code/feature/dashboardtab/dashboard_tab_page.dart';
import 'package:suitcore_flutter_getx_base_code/feature/loader/loading_page.dart';
import 'package:suitcore_flutter_getx_base_code/feature/login/login_page.dart';
import 'package:suitcore_flutter_getx_base_code/feature/other/other_page.dart';
import 'package:suitcore_flutter_getx_base_code/feature/places/detail/place_detail_page.dart';

import 'page_names.dart';

class PageRoutes {
  static final pages = [
    GetPage(
      name: PageName.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: PageName.LOADER,
      page: () => LoadingPage(),
    ),
    GetPage(
        name: PageName.DASHBOARD,
        page: () => DashBoardTabPage(),
        binding: DashBoardTabBinding()),
    GetPage(name: PageName.OTHER, page: () => OtherPage()),
    GetPage(
        name: PageName.USER_DETAIL,
        page: () => PlaceDetailPage(),
        binding: PlaceDetailBinding()),
  ];
}
