import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:suitcore_flutter_getx_base_code/feature/auth/auth_controller.dart';
import 'package:suitcore_flutter_getx_base_code/resources/resources.dart';
import 'package:suitcore_flutter_getx_base_code/utills/helper/validator.dart';
import 'package:suitcore_flutter_getx_base_code/utills/widget/forms/form_input_field_with_icon.dart';
import 'package:suitcore_flutter_getx_base_code/utills/widget/primary_button.dart';
import 'package:suitcore_flutter_getx_base_code/utills/widget/statefull_wrapper.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = AuthController.find;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () async {
        var storage = await Permission.storage.status;
        if (storage.isDenied) {
          await Permission.storage.request();
        }
      },
      child: Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: GetBuilder<LoginController>(
                      init: LoginController(),
                      builder: (controller) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: Image(
                                image: Resources.images.imageLogo,
                                color: Resources.color.colorPrimary,
                              ),
                            ),
                            SizedBox(height: 48.0),
                            FormInputFieldWithIcon(
                              enabled: !controller.isLoading,
                              controller: controller.emailController,
                              iconPrefix: Icons.email,
                              labelText: 'txt_email'.tr,
                              validator: Validator().notEmpty,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => null,
                              onSaved: (value) =>
                                  controller.emailController.text = value!,
                            ),
                            FormVerticalSpace(),
                            Obx(() => FormInputFieldWithIcon(
                                  enabled: !controller.isLoading,
                                  controller: controller.passwordController,
                                  iconPrefix: Icons.lock,
                                  labelText: 'txt_password'.tr,
                                  validator: Validator().password,
                                  iconWidget: IconButton(
                                      onPressed: () {
                                        controller.isViewPassword.toggle();
                                      },
                                      icon: !controller.isViewPassword.value
                                          ? Icon(CupertinoIcons.eye_slash_fill)
                                          : Icon(CupertinoIcons.eye_fill)),
                                  obscureText: !controller.isViewPassword.value,
                                  onChanged: (value) => null,
                                  onSaved: (value) => controller
                                      .passwordController.text = value!,
                                  maxLines: 1,
                                )),
                            FormVerticalSpace(height: 0),
                            Obx(() => Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('saved?'),
                                    IconButton(
                                        onPressed: () {
                                          controller.authController.isSaved
                                              .toggle();

                                          if (controller
                                              .authController.isSaved.value) {
                                            ScaffoldMessenger.of(Get.context!)
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text('login info saved'),
                                              ),
                                            );
                                          }
                                        },
                                        icon: Icon(
                                          controller
                                                  .authController.isSaved.value
                                              ? Icons.check_box
                                              : Icons.check_box_outline_blank,
                                          color: controller
                                                  .authController.isSaved.value
                                              ? Colors.green
                                              : Colors.grey,
                                        ))
                                  ],
                                )),
                            FormVerticalSpace(height: 20),
                            controller.isLoading
                                ? CircularProgressIndicator()
                                : Container(),
                            controller.isLoading
                                ? Container()
                                : PrimaryButton(
                                    title: 'txt_button_login'.tr,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        controller.signInWithEmailAndPassword();
                                      }
                                    }),
                            FormVerticalSpace(height: 20),
                            controller.isLoading
                                ? Container()
                                : PrimaryButton(
                                    title: 'Skip',
                                    reverse: true,
                                    onPressed: () async {
                                      controller.bypassLogin();
                                    }),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormVerticalSpace extends SizedBox {
  FormVerticalSpace({double height = 24.0}) : super(height: height);
}
