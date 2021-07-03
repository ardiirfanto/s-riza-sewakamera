import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:s_riza_sewakamera/constants/functions.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/cust_controller.dart';
import 'package:s_riza_sewakamera/models/item_model.dart';
import 'package:s_riza_sewakamera/widgets/button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:unicons/unicons.dart';

class CustCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CustController custController = Get.put(CustController());

    custController.calculatePrice();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(
            () => custController.cart.length > 0
                ? IconButton(
                    icon: Icon(
                      UniconsLine.trash_alt,
                      color: primaryColor,
                      size: 25,
                    ),
                    onPressed: () => clearCartDialog(custController),
                  )
                : Container(),
          )
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Keranjang Pinjaman",
          style: textStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      body: Obx(
        () => custController.cart.length > 0
            ? Stack(
                children: [
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          dateEditor(custController),
                          SizedBox(height: 10),
                          listItem(custController),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Pembayaran",
                                      style: textStyle.copyWith(
                                        fontSize: 13,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    Text(
                                      rupiah(custController.totalPrice.value),
                                      style: textStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                width: Get.width,
                                height: 50,
                                child: Button(
                                  onPress: () => checkoutDialog(custController),
                                  text: "Checkout",
                                  rounded: 10,
                                  color: primaryColor,
                                  textSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(20),
                height: Get.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/img/empty-cart.png"),
                    Text(
                      "Keranjang Kamu Kosong",
                      style: textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: accentColor,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  // Widget : Date Editor
  Widget dateEditor(CustController custController) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => Get.bottomSheet(
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          child: SfDateRangePicker(
            controller: custController.pinjamDate,
            selectionMode: DateRangePickerSelectionMode.range,
            minDate: DateTime.now(),
            endRangeSelectionColor: primaryColor,
            startRangeSelectionColor: primaryColor,
            initialSelectedRange: PickerDateRange(
              custController.startDate.value,
              custController.endDate.value,
            ),
            cancelText: "Batal",
            confirmText: "Pilih",
            onCancel: () => Get.back(),
            showActionButtons: true,
            onSubmit: (val) => custController.updateDate(),
            rangeTextStyle: textStyle.copyWith(color: primaryColor),
          ),
        ),
      ),
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(UniconsLine.calendar_alt, size: 20, color: Colors.grey[700]),
            SizedBox(width: 10),
            Text(
              DateFormat("dd MMM yy", 'id')
                      .format(custController.startDate.value) +
                  " - " +
                  DateFormat("dd MMM yy", 'id')
                      .format(custController.endDate.value),
              style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Icon(
              UniconsLine.pen,
              size: 18,
              color: Colors.grey[700],
            )
          ],
        ),
      ),
    );
  }

  // Widget : List Item
  Widget listItem(CustController custController) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Column(
          children: [
            Row(
              children: [
                Icon(UniconsLine.shopping_bag, color: primaryColor, size: 27),
                SizedBox(width: 5),
                Text(
                  "Daftar Barang",
                  style: textStyle.copyWith(
                    fontSize: 15,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      separatorBuilder: (context, i) => Divider(),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: custController.cart.length,
                      itemBuilder: (context, i) {
                        var val = custController.cart[i];
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            itemListTile(val, custController),
                            InkWell(
                              onTap: () => custController.removeItem(val),
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  UniconsLine.trash,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    Container(
                      color: Colors.transparent,
                      height: Get.width * 40 / 100,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget : Item List Tile
  Widget itemListTile(Item val, CustController custController) {
    return Expanded(
      flex: 6,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: baseUrl + 'assets/img/items/' + val.itemImg,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    val.itemName,
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    rupiah((val.itemPrice * val.itemQty) *
                        custController.totalDay.value),
                    style: textStyle.copyWith(
                      color: primaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () => custController.decItemQty(val),
                        child: Icon(
                          Icons.remove_circle,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        val.itemQty.toString(),
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () => custController.incItemQty(val),
                        child: Icon(
                          Icons.add_circle,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Void : Dialog Clear Cart
  clearCartDialog(CustController custController) {
    return Get.dialog(
      AlertDialog(
        title: Text(
          "Bersihkan Keranjang",
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Anda Yakin ingin menghapus semua data di keranjang?",
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
              child: Text(
                'Bersihkan',
                style: textStyle.copyWith(color: Colors.red),
              ),
              onPressed: () {
                custController.clearCart();
                Get.back();
              }),
        ],
      ),
    );
  }

  // Void : Dialog Checkout
  checkoutDialog(CustController custController) {
    return Get.dialog(
      AlertDialog(
        title: Text(
          "Konfirmasi Checkout",
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Anda Yakin ingin checkout keranjang?",
          style: textStyle,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            child:
                Text('Batal', style: textStyle.copyWith(color: primaryColor)),
            onPressed: () => Get.back(),
          ),
          Button(
            onPress: () => custController.checkout(),
            color: primaryColor,
            text: "Checkout",
            rounded: 5,
            textSize: 15,
          ),
        ],
      ),
    );
  }
}
