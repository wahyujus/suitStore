import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suitcore_flutter_getx_base_code/resources/resources.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(
            color: Resources.color.colorPrimary,
          ),
        ),
      ),
    );
  }
}
