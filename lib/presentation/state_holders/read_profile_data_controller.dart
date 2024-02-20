import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/read_profile_data.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ReadProfileDataController extends GetxController {
  bool _inProgress = false;

  bool _isProfileCompleted = false;

  String _errorMessage = '';

  ReadProfileModel _profileData = ReadProfileModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  ReadProfileModel get profileData => _profileData;

  bool get isProfileCompleted => _isProfileCompleted;

  Future<bool> readProfileData(String token) async {
    _inProgress = true;
    update();
    final response =
    await NetworkCaller().getRequest(Urls.readProfile, token: token);
    _inProgress = false;
    if (response.isSuccess) {
      final profileData = response.responseData['data'];
      if (profileData == null) {
        _isProfileCompleted = false;
        //profileData.isEmpty in params
      } else {
        _profileData = ReadProfileModel.fromJson(profileData);
        _isProfileCompleted = true;
      }
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}