import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/complete_profile_model.dart';
import '../../data/models/create_profile_params.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import 'auth_controller.dart';

class CompleteProfileController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = "";

  CompleteProfileModel _completeProfileModel = CompleteProfileModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  CompleteProfileModel get completeProfileModel => CompleteProfileModel();

  Future<bool> createProfileData(
      String token, CreateProfileParams params) async {
    _inProgress = true;
    update();
    final response = await NetworkCaller()
        .postRequest(Urls.createProfile, token: token, body: params.toJson());
    log(token);
    _inProgress = false;
    if (response.isSuccess) {
      _completeProfileModel =
          CompleteProfileModel.fromJson(response.responseData["data"]);
      await Get.find<AuthController>()
          .saveUserDetails(token, null, _completeProfileModel);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}