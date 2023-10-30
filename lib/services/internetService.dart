import 'package:connectivity/connectivity.dart';

Future<bool> checkInternetConnectivity() async {
  var connectivityResult = (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}