import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CreateWishListController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = "";

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> createWishList(int wishProductId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response =
    await NetworkCaller().getRequest(Urls.createWishList(wishProductId));
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}