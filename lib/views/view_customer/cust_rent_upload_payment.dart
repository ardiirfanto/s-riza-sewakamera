import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/rent_controller.dart';
import 'package:s_riza_sewakamera/models/rent_model.dart';
import 'package:s_riza_sewakamera/widgets/button.dart';

class CustRentUploadPaymentPage extends StatelessWidget {
  final Rent rent;
  final int back;

  CustRentUploadPaymentPage({this.rent, this.back});

  @override
  Widget build(BuildContext context) {
    final RentController rentController = Get.find();

    rentController.imgFilePath.value = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.close,
            color: primaryColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Unggah Bukti Pembayaran",
          style: textStyle.copyWith(
              color: primaryColor, fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            imgPick(rentController),
            Divider(),
            SizedBox(
              width: Get.width,
              height: 50,
              child: Button(
                onPress: () =>
                    rentController.uploadPayment(rent.id.toString(), back),
                text: "Unggah Bukti Bayar",
                textSize: 15,
                color: primaryColor,
                rounded: 15,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: Get.width,
              height: 50,
              child: TextButton(
                onPressed: () => Get.bottomSheet(
                  Container(
                    height: Get.height * 30 / 100,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Info Rekening",
                          style:
                              textStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Divider(),
                        listAtm("BNI", "7778889900", "Cahaya Melati"),
                        listAtm("BCA", "330099001010", "Cahaya Melati S "),
                        listAtm("Mandiri", "65566890066997", "Riza"),
                      ],
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outline, color: primaryColor, size: 19),
                    SizedBox(width: 3),
                    Text(
                      "Info Rekening",
                      style: textStyle.copyWith(
                          fontWeight: FontWeight.bold, color: primaryColor),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Catatan : Unggah bukti bayar sesuai nominal. Setelah Mengunggah Pembayaran akan di validasi oleh Admin.",
                style: textStyle.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listAtm(String title, String rek, String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                "a.n " + name,
                style: textStyle,
              ),
            ],
          ),
          Text(
            rek,
            style: textStyle,
          ),
        ],
      ),
    );
  }

  Widget imgPick(RentController rentController) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "NO.INV : " + rent.invoiceNumber,
              style: textStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => rentController.pickImg(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Obx(
                  () => Image(
                    image: rentController.imgFilePath.value != ''
                        ? FileImage(File(rentController.imgFilePath.value))
                        : AssetImage(imgPath + 'img_preview.jpg'),
                    width: Get.width,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Klik Gambar Untuk Mengunggah",
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
