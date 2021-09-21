import 'package:get/get.dart';
import 'package:suitcore_flutter_getx_base_code/feature/auth/auth_controller.dart';
import 'package:suitcore_flutter_getx_base_code/model/user.dart';
import 'package:suitcore_flutter_getx_base_code/utills/helper/secure_storage_manager.dart';

class OtherController extends GetxController {
  final AuthController authController = AuthController.find;
  var mToken = "".obs;

  String? get user => authController.user;
  SecureStorageManager? get myToken => authController.secureStorage;

  @override
  void onInit() {
    getMyToken();
    super.onInit();
  }

  Future<void> getMyToken() async {
    await myToken!.getToken().then((value) => mToken.value = value!);
    update();
  }

  Future<void> signOut() async {
    await authController.signOut();
  }
}
