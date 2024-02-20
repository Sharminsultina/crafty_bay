import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'auth_controller.dart';

class MainBottomNavController extends GetxController {
  int _selectedIndex = 0;

  int get currentIndex => _selectedIndex;

  void changeIndex(int index) {
    if (_selectedIndex == index) {
      return;
    }
    if (index == 2 || index == 3) {
      if (Get.find<AuthController>().isTokenNotNull == false) {
        AuthController.goToLogin();
        return;
      }
    }
    _selectedIndex = index;
    update();
  }

  void backToHome() {
    changeIndex(0);
  }
}