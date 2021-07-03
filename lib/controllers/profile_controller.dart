import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  Rx<String> userId = "".obs;
  Rx<String> custId = "".obs;
  Rx<String> username = "".obs;
  Rx<String> role = "".obs;
  Rx<String> custName = "".obs;
  Rx<String> custAddress = "".obs;
  Rx<String> custPhone = "".obs;

  @override
  void onInit() {
    super.onInit();
    setProfile();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setProfile() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    this.userId.value = _pref.getInt('user_id').toString();
    this.custId.value = _pref.getInt('cust_id').toString();
    this.username.value = _pref.getString('username');
    this.role.value = _pref.getString('roles');
    this.custName.value = _pref.getString('cust_name');
    this.custAddress.value = _pref.getString('cust_address');
    this.custPhone.value = _pref.getString('cust_phone');
  }
}
