import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:s_riza_sewakamera/models/user_model.dart';
import 'package:s_riza_sewakamera/services/auth_services.dart';
import 'package:s_riza_sewakamera/views/login_page.dart';
import 'package:s_riza_sewakamera/views/view_admin/admin_home_page.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  AuthServices _services = new AuthServices();
  final loginFormKey = GlobalKey<FormState>();
  RxBool isObscure = true.obs;
  RxBool isLogging = false.obs;
  TextEditingController userText = new TextEditingController();
  TextEditingController passText = new TextEditingController();
  TextEditingController nameText = new TextEditingController();
  TextEditingController addressText = new TextEditingController();
  TextEditingController phoneText = new TextEditingController();

  changeObscure() {
    if (isObscure.value == true) {
      isObscure.value = false;
    } else {
      isObscure.value = true;
    }
  }

  login() {
    if (userText.text == '' ||
        userText.text == null ||
        passText.text == '' ||
        passText.text == null) {
      snackbar('Peringatan', 'Harap Lengkapi Kolom', Colors.orange);
    } else {
      isLogging.value = true;
      _services.login(userText.text, passText.text).then((value) {
        if (value == 1 || value == 0) {
          isLogging.value = false;
          snackbar('Peringatan', 'Data tidak ditemukan', Colors.red);
        } else {
          saveSharedUser(value);
          isLogging.value = false;
          userText.text = '';
          passText.text = '';
          redirect(value);
        }
      });
    }
  }

  register() {
    if (userText.text == '' ||
        userText.text == null ||
        passText.text == '' ||
        passText.text == null ||
        nameText.text == '' ||
        nameText.text == null ||
        addressText.text == '' ||
        addressText.text == null ||
        phoneText.text == '' ||
        phoneText.text == null) {
      snackbar('Peringatan', 'Harap Lengkapi Kolom', Colors.orange);
    } else {
      isLogging.value = true;
      _services
          .register(userText.text, passText.text, nameText.text,
              addressText.text, phoneText.text)
          .then((value) {
        if (value == 1 || value == 0) {
          isLogging.value = false;
          snackbar('Peringatan', 'Username Sudah digunakan', Colors.red);
        } else {
          saveSharedUser(value);
          isLogging.value = false;
          userText.text = '';
          passText.text = '';
          nameText.text = '';
          addressText.text = '';
          phoneText.text = '';
          redirect(value);
        }
      });
    }
  }

  redirect(User data) {
    if (data.roles == 'admin') {
      Get.offAll(() => AdminHomePage(), transition: Transition.cupertino);
    } else {
      Get.offAll(() => CustHomePage(), transition: Transition.cupertino);
    }
  }

  saveSharedUser(User data) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    _pref.setBool('logged_in', true);
    _pref.setInt('user_id', data.userId);
    _pref.setInt('cust_id', data.custId);
    _pref.setString('username', data.username);
    _pref.setString('roles', data.roles);
    _pref.setString('cust_name', data.custName);
    _pref.setString('cust_address', data.custAddress);
    _pref.setString('cust_phone', data.custPhone);
  }

  logout() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.remove('logged_in');
    _pref.remove('user_id');
    _pref.remove('cust_id');
    _pref.remove('username');
    _pref.remove('roles');
    _pref.remove('cust_name');
    _pref.remove('cust_address');
    _pref.remove('cust_phone');
    Get.offAll(() => LoginPage(), transition: Transition.cupertino);
  }

  snackbar(title, msg, Color color) {
    return Get.snackbar(title, msg,
        backgroundColor: color, colorText: Colors.white);
  }
}
