import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/catagory_list_ model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CategoryController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  CategoryListModel _categoryListModel = CategoryListModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  CategoryListModel get categoryListModel => _categoryListModel;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.categoryList);
    _inProgress = false;
    if (response.isSuccess) {
      _categoryListModel = CategoryListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}