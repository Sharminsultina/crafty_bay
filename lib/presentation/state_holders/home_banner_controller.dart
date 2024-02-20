import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/banner_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class HomeBannerController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  BannerListModel _bannerListModel = BannerListModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  BannerListModel get bannerListModel => _bannerListModel;

  Future<bool> getBannerList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.homeBanner);
    _inProgress = false;
    if (response.isSuccess) {
      _bannerListModel = BannerListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}