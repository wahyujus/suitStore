import 'package:flutter/material.dart';
import 'package:suitcore_flutter_getx_base_code/data/local/storage/storage_constants.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/api_services.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/base/base_object_controller.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/base/base_refresher_status.dart';
import 'package:suitcore_flutter_getx_base_code/feature/auth/auth_controller.dart';
import 'package:suitcore_flutter_getx_base_code/model/user.dart';
import 'package:suitcore_flutter_getx_base_code/data/remote/errorhandler/error_handler.dart';
import 'package:get/get.dart';

class LoginController extends BaseObjectController<User> {
  final AuthController authController = AuthController.find;

  var isViewPassword = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onReady() {
    setAuthSaved();
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void setAuthSaved() {
    var res = authController.getAuthDetail();

    if (res[StorageName.USERNAME] != null) {
      emailController.text = res[StorageName.USERNAME]!;
      passwordController.text = res[StorageName.PASSWORD]!;
      authController.isSaved.value = res[StorageName.SAVED]!;
      print(res[StorageName.SAVED]!);
      update();
    }
  }

  void signInWithEmailAndPassword() async {
    loadingState();

    var map = {
      "username": emailController.text,
      "password": passwordController.text,
    };

    await client.then(
      (value) => value.loginAuth(map).then(
        (value) {
          authController.saveAuthData(
            user: emailController.text,
            token: value.token!,
            autoSave: authController.isSaved.value,
            password: passwordController.text,
          );
          finishLoadData();
          authController.setAuth();
        },
      ).handleError((onError) {
        finishLoadData(errorMessage: onError);
      }),
    );

    // await client.then((value) => value
    //         .login(emailController.text, passwordController.text)
    //         .validateStatus()
    //         .then((value) {
    // authController.saveAuthData(
    //   user: value.result!.user!,
    //   token: value.result!.token!,
    // );
    // finishLoadData();
    // authController.setAuth();
    //     }).handleError((onError) {
    //       finishLoadData(errorMessage: onError);
    //     }));
  }

  void bypassLogin() async {
    status = RefresherStatus.loading;
    update();
    await Future.delayed(Duration(seconds: 2));
    // var user = User(
    //     id: 1,
    //     name: "suitmedian",
    //     email: emailController.text,
    //     gender: "none",
    //     status: "admin");
    authController.saveAuthData(user: 'dummy', token: "OwO");
    finishLoadData();
    authController.setAuth();
  }
}
