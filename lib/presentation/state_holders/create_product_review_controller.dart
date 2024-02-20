import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CreateProductReviewController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = "";

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> createReview(
      int productId, String description, int rating) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> inputParams = {
      "description": description,
      "product_id": productId,
      "rating": rating,
    };
    final response = await NetworkCaller().postRequest(
      Urls.createProductReview,
      body: inputParams,
    );
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