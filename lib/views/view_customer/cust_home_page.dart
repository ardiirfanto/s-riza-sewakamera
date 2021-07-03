import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/cust_controller.dart';
import 'package:unicons/unicons.dart';

import 'cust_cart_page.dart';

class CustHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CustController custController = Get.put(CustController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => custController.page[custController.selectedPage.value]),
      floatingActionButton: Obx(() => FloatingActionButton(
            onPressed: () =>
                Get.to(() => CustCartPage(), transition: Transition.cupertino),
            backgroundColor: primaryColor,
            child: custController.cart.length > 0
                ? Badge(
                    animationType: BadgeAnimationType.scale,
                    animationDuration: Duration(milliseconds: 100),
                    shape: BadgeShape.circle,
                    badgeColor: Colors.red,
                    badgeContent: Text(
                      custController.cart.length.toString(),
                      style: textStyle.copyWith(color: Colors.white),
                    ),
                    child: Icon(
                      UniconsLine.shopping_bag,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                : Icon(
                    UniconsLine.shopping_bag,
                    color: Colors.white,
                    size: 30,
                  ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
            child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              color: primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  iconButton(UniconsLine.home_alt, 0, custController),
                  iconButton(UniconsLine.search, 1, custController),
                  SizedBox(width: 20),
                  SizedBox(width: 20),
                  iconButton(UniconsLine.list_ui_alt, 2, custController),
                  iconButton(UniconsLine.user, 3, custController),
                ],
              ),
            ),
          )),
    );
  }

  Widget iconButton(icon, page, CustController custController) {
    return IconButton(
      icon: Icon(
        icon,
        size: 25,
      ),
      color: page == custController.selectedPage.value
          ? Colors.white
          : Colors.white38,
      onPressed: () => custController.changePage(page),
    );
  }
}
