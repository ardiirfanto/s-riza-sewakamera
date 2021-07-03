import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/auth_controller.dart';
import 'package:s_riza_sewakamera/widgets/button.dart';
import 'package:s_riza_sewakamera/widgets/form_container.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController _registerController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
        ),
        title: Text(
          "Halaman Register",
          style: textStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                      controller: _registerController.nameText,
                      style: textStyle,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesome5.address_card,
                          color: Colors.grey,
                          size: 17,
                        ),
                        hintText: "Masukan Nama Lengkap",
                        hintStyle: textStyle.copyWith(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FormContainer(
                    child: TextFormField(
                      controller: _registerController.userText,
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
                      controller: _registerController.passText,
                      obscureText: _registerController.isObscure.value,
                      style: textStyle,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesome5.lock,
                          color: Colors.grey,
                          size: 17,
                        ),
                        suffixIcon: GestureDetector(
                          child: _registerController.isObscure.value
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
                          onTap: () => _registerController.changeObscure(),
                        ),
                        hintText: "Masukan Password",
                        hintStyle: textStyle.copyWith(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FormContainer(
                    child: TextFormField(
                      controller: _registerController.addressText,
                      maxLines: 3,
                      style: textStyle,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Icon(
                            FontAwesome5.map,
                            color: Colors.grey,
                            size: 17,
                          ),
                        ),
                        hintText: "Masukan Alamat Lengkap",
                        hintStyle: textStyle.copyWith(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FormContainer(
                    child: TextFormField(
                      controller: _registerController.phoneText,
                      style: textStyle,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesome5.phone_alt,
                          color: Colors.grey,
                          size: 17,
                        ),
                        hintText: "Masukan No.HP",
                        hintStyle: textStyle.copyWith(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Divider(),
                  _registerController.isLogging.value
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
                            onPress: () => _registerController.register(),
                            color: primaryColor,
                            text: 'Daftar',
                            rounded: 10,
                            textSize: 15,
                          ),
                        ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sudah Punya Akun?",
                        style: textStyle.copyWith(color: Colors.grey),
                      ),
                      SizedBox(width: 3),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          "Login Disini",
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
      ),
    );
  }
}
