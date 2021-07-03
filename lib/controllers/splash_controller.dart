import 'dart:async';

import 'package:get/state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:s_riza_sewakamera/views/login_page.dart';
import 'package:s_riza_sewakamera/views/view_admin/admin_home_page.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  RxBool isLoggedIn = false.obs;
  Timer _timer;

  @override
  void onInit() {
    super.onInit();
    getAuthState();
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }

  getAuthState() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    bool _loggedIn = _pref.getBool('logged_in');

    return _timer = Timer(Duration(seconds: 3), () {
      if (_loggedIn != null) {
        isLoggedIn.value = true;

        String _roles = _pref.getString('roles');

        if (_roles == 'admin') {
          Get.offAll(() => AdminHomePage(), transition: Transition.cupertino);
        } else {
          Get.offAll(() => CustHomePage(), transition: Transition.cupertino);
        }
      } else {
        isLoggedIn.value = false;
        Get.offAll(() => LoginPage(), transition: Transition.cupertino);
      }
    });
  }
}
