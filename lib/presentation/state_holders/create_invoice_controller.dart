import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/payment_method_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CreateInvoiceController extends GetxController {
  bool _inProgress = true;

  String _errorMessage = "";

  PaymentMethodListModel _paymentMethodListModel = PaymentMethodListModel();

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  PaymentMethodListModel get paymentMethodListModel => _paymentMethodListModel;

  Future<bool> createInvoice() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.createInvoice);
    if (response.isSuccess) {
      _paymentMethodListModel =
          PaymentMethodListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}