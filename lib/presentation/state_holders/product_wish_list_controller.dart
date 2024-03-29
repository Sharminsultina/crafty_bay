import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/wish_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ProductWishListController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  WishListModel _wishListModel = WishListModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  WishListModel get wishListModel => _wishListModel;

  Future<bool> getProductWishList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.productWishList);
    if (response.isSuccess) {
      _wishListModel = WishListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> deleteWishList(int wishId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response =
    await NetworkCaller().getRequest(Urls.removeWishList(wishId));
    if (response.isSuccess) {
      isSuccess = true;
      getProductWishList();
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}