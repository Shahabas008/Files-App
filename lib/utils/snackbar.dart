import 'package:get/get.dart';

class Utils{

  static void snackbar({String? title, String? message}) {
    Get.showSnackbar(
  GetSnackBar(
    title: title,
    message : message,
    duration: const Duration(seconds: 3),
  ),
);
  }
}