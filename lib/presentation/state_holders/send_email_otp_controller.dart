import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/response_data.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class SendEmailOtpController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = "";

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> sendOtpToEmail(String email) async {
    _inProgress = true;
    update();
    final ResponseData response =
    await NetworkCaller().getRequest(Urls.sentEmailOtp(email));
    _inProgress = false;
    if (response.isSuccess) {
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}