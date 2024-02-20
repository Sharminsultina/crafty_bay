import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/brand_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ProductListByBrandController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  BrandListModel _brandListModel = BrandListModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  BrandListModel get brandListModel => _brandListModel;

  Future<bool> getProductListByBrand({required int brandId}) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response =
    await NetworkCaller().getRequest(Urls.listProductByBrand(brandId));
    _inProgress = false;
    if (response.isSuccess) {
      _brandListModel = BrandListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}