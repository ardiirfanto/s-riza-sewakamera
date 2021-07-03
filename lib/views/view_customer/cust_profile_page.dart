import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/auth_controller.dart';
import 'package:s_riza_sewakamera/controllers/profile_controller.dart';
import 'package:s_riza_sewakamera/widgets/button.dart';

class CustProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    AuthController authController = Get.put(AuthController());

    profileController.setProfile();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: Get.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            avatarProfile(),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(20),
              width: Get.width,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(10)),
              child: Obx(
                () => Column(
                  children: [
                    textProfile("Nama", profileController.custName.value),
                    textProfile("Username", profileController.username.value),
                    textProfile("Role", profileController.role.value),
                    textProfile("Alamat", profileController.custAddress.value),
                    textProfile(
                        "No.Handphone", profileController.custPhone.value),
                  ],
                ),
              ),
            ),
            Button(
              color: primaryColor,
              text: "Log Out",
              rounded: 10,
              textSize: 17,
              onPress: () => logOutDialog(authController),
            )
          ],
        ),
      ),
    );
  }

  Widget textProfile(title, text) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textStyle.copyWith(color: Colors.white),
            ),
            Text(
              text,
              style: textStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Divider(color: Colors.white)
      ],
    );
  }

  Widget avatarProfile() {
    return Container(
      padding: EdgeInsets.all(5),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 4,
          color: primaryColor,
        ),
        image: DecorationImage(
          image: AssetImage(
            "assets/img/user.png",
          ),
        ),
      ),
    );
  }

  logOutDialog(AuthController authController) {
    return Get.dialog(
      AlertDialog(
        title: Text(
          "Log Out",
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Anda Ingin Keluar?",
          style: textStyle,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            child:
                Text('Batal', style: textStyle.copyWith(color: primaryColor)),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Keluar', style: textStyle.copyWith(color: Colors.red)),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
    );
  }
}
