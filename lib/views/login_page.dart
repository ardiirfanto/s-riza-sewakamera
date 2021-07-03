import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/auth_controller.dart';
import 'package:s_riza_sewakamera/views/register_page.dart';
import 'package:s_riza_sewakamera/widgets/button.dart';
import 'package:s_riza_sewakamera/widgets/form_container.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController _loginController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Obx(
          () => Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "${imgPath}icon.png",
                  height: 150,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10),
                FormContainer(
                  child: TextFormField(
                    controller: _loginController.userText,
                    style: textStyle,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesome5.user,
                        color: Colors.grey,
                        size: 17,
                      ),
                      hintText: "Masukan Username",
                      hintStyle: textStyle.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                FormContainer(
                  child: TextFormField(
                    controller: _loginController.passText,
                    obscureText: _loginController.isObscure.value,
                    style: textStyle,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesome5.lock,
                        color: Colors.grey,
                        size: 17,
                      ),
                      suffixIcon: GestureDetector(
                        child: _loginController.isObscure.value
                            ? Icon(
                                FontAwesome5.eye_slash,
                                color: Colors.grey,
                                size: 17,
                              )
                            : Icon(
                                FontAwesome5.eye,
                                color: primaryColor,
                                size: 17,
                              ),
                        onTap: () => _loginController.changeObscure(),
                      ),
                      hintText: "Masukan Password",
                      hintStyle: textStyle.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Divider(),
                _loginController.isLogging.value
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: SpinKitCircle(
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    : SizedBox(
                        width: Get.width,
                        height: 50,
                        child: Button(
                          onPress: () => _loginController.login(),
                          color: primaryColor,
                          text: 'Login',
                          rounded: 10,
                          textSize: 15,
                        ),
                      ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum Punya Akun?",
                      style: textStyle.copyWith(color: Colors.grey),
                    ),
                    SizedBox(width: 3),
                    GestureDetector(
                      onTap: () => Get.to(() => RegisterPage(),
                          transition: Transition.cupertino),
                      child: Text(
                        "Daftar Disini",
                        style: textStyle.copyWith(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
