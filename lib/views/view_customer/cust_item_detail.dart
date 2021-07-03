import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/functions.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/item_controller.dart';
import 'package:s_riza_sewakamera/controllers/cust_controller.dart';
import 'package:s_riza_sewakamera/models/item_model.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_cart_page.dart';
import 'package:s_riza_sewakamera/widgets/button.dart';
import 'package:unicons/unicons.dart';

class CustItemDetailPage extends StatelessWidget {
  final Item item;

  CustItemDetailPage({this.item});

  @override
  Widget build(BuildContext context) {
    final ItemController itemController = Get.put(ItemController());
    final CustController custController = Get.put(CustController());

    itemController.listPopuler();
    custController.setQtyItem(item.itemStock);

    // print(custController.cart[2].itemStock);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemImage(),
                  itemName(custController),
                  Divider(color: accentColor),
                  itemOther(itemController),
                ],
              ),
            ),
            addToCart(custController)
          ],
        ),
      ),
    );
  }

  // Widget Add To Cart
  Widget addToCart(CustController custController) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 8 / 100,
        width: Get.width,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            InkWell(
                onTap: () => Get.to(() => CustCartPage(),
                    transition: Transition.cupertino),
                child: Obx(() => custController.cart.length > 0
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
                          size: 35,
                        ),
                      )
                    : Icon(
                        UniconsLine.shopping_bag,
                        size: 35,
                      ))),
            SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Button(
                onPress: () => custController.addToCart(item),
                text: "Tambah Ke Keranjang",
                textSize: 16,
                rounded: 5,
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget Item Lainya
  Widget itemOther(ItemController itemController) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Barang Lainya",
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Container(
            height: 200,
            child: Obx(
              () => itemController.listPopuler.length > 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: itemController.listPopuler.length,
                      itemBuilder: (context, i) {
                        var val = itemController.listPopuler[i];
                        return InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => Navigator.of(context).push(
                            new CupertinoPageRoute(
                              builder: (context) =>
                                  CustItemDetailPage(item: val),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    children: [
                                      FadeInImage(
                                        placeholder: AssetImage(
                                            imgPath + 'img_preview.jpg'),
                                        image: CachedNetworkImageProvider(
                                          baseUrl +
                                              'assets/img/items/' +
                                              val.itemImg,
                                        ),
                                        height: 100,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration:
                                            BoxDecoration(color: accentColor),
                                        child: Text(
                                          val.categoryName,
                                          style: textStyle.copyWith(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  val.itemName,
                                  style: textStyle.copyWith(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  rupiah(val.itemPrice),
                                  style: textStyle.copyWith(fontSize: 11),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : SpinKitCircle(
                      color: primaryColor,
                    ),
            ),
          )
        ],
      ),
    );
  }

  // Widget Item Name dan Qty
  Widget itemName(CustController custController) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    rupiah(item.itemPrice),
                    style: textStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("/hari", style: textStyle)
                ],
              ),
              Text(
                "Tersedia : ${item.itemStock}",
                style: textStyle.copyWith(
                    color: item.itemStock > 0 ? Colors.black : Colors.red),
              )
            ],
          ),
          SizedBox(height: 10),
          Text(
            item.itemName,
            style: textStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              item.categoryName,
              style: textStyle.copyWith(
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => custController.decQty(),
                child: Icon(
                  Icons.remove_circle,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                width: 50,
                height: 30,
                child: TextField(
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  controller: custController.textQtyItem,
                  cursorColor: accentColor,
                  textAlign: TextAlign.center,
                  style: textStyle.copyWith(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              InkWell(
                onTap: () => custController.incQty(item.itemStock),
                child: Icon(
                  Icons.add_circle,
                  color: primaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Widget Item Image dan Back
  Widget itemImage() {
    return Container(
      width: Get.width,
      height: Get.height * 45 / 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            baseUrl + 'assets/img/items/' + item.itemImg,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: primaryColor.withOpacity(0.6),
            ),
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
