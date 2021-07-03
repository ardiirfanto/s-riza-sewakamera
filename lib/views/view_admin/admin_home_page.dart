import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/admin_controller.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AdminController _adminController = Get.put(AdminController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Container(
          padding: EdgeInsets.all(3),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) => _adminController.changePage(index),
              currentIndex: _adminController.selectedIndex.value,
              backgroundColor: primaryColor,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              selectedFontSize: 12,
              selectedLabelStyle: textStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(FontAwesome5.clipboard_list),
                  label: "Data Rental",
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesome5.tag),
                  label: "Kategori Barang",
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesome5.camera_retro),
                  label: "Barang",
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => _adminController.page[_adminController.selectedIndex.value],
      ),
    );
  }
}
