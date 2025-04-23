import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:suktha_crm/validations/check_internet_connection.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    if (connectivityResults.contains(ConnectivityResult.none)) {
      Get.to(() => NoInternetConnectionScreen());

      //use snackbar or other widget
    } else {
      //if using snackbar it will automatically close when connects to the internet
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
