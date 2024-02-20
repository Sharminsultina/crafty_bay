import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/product_details_data.dart';
import '../../data/models/product_details_model.dart';
import '../../data/models/response_data.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = "";

  ProductDetailsModel _productDetailsModel = ProductDetailsModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  ProductDetailsData get productDetails =>
      _productDetailsModel.productDetailsDataList!.first;

  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final ResponseData response =
    await NetworkCaller().getRequest(Urls.productDetails(productId));
    if (response.isSuccess) {
      _productDetailsModel =
          ProductDetailsModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}