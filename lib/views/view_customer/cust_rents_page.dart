import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/functions.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/rent_controller.dart';
import 'package:s_riza_sewakamera/models/rent_model.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_rent_detail_page.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_rent_upload_payment.dart';
import 'package:s_riza_sewakamera/widgets/button.dart';
import 'package:unicons/unicons.dart';

class CustRentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RentController rentController = Get.put(RentController());
    rentController.fetchAll();
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              Icon(
                UniconsLine.clipboard_notes,
                color: primaryColor,
              ),
              SizedBox(width: 10),
              Text(
                "Riwayat Pinjaman",
                style: textStyle.copyWith(
                    color: primaryColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: primaryColor,
            labelStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
            labelColor: primaryColor,
            isScrollable: true,
            tabs: [
              Tab(text: "Belum Dibayar"),
              Tab(text: "Menunggu Konfirmasi"),
              Tab(text: "Sudah Lunas"),
              Tab(text: "Sedang Dipinjam"),
              Tab(text: "Sudah Dikembalikan"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() => listRent('booked', rentController)),
            Obx(() => listRent('waiting', rentController)),
            Obx(() => listRent('lunas', rentController)),
            Obx(() => listRent('dipinjam', rentController)),
            Obx(() => listRent('selesai', rentController)),
          ],
        ),
      ),
    );
  }

  // Widget : List Rent
  Widget listRent(String status, RentController rentController) {
    List<Rent> listData = [];
    if (status == 'booked') {
      listData = rentController.listBooked;
    } else if (status == 'waiting') {
      listData = rentController.listWaiting;
    } else if (status == 'lunas') {
      listData = rentController.listLunas;
    } else if (status == 'dipinjam') {
      listData = rentController.listDipinjam;
    } else if (status == 'selesai') {
      listData = rentController.listSelesai;
    }
    return Container(
        padding: EdgeInsets.all(15),
        child: listData.length > 0
            ? ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, i) {
                  var val = listData[i];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      onTap: () => Get.to(() => CustRentDetailPage(rent: val),
                          transition: Transition.cupertino),
                      borderRadius: BorderRadius.circular(5),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  val.invoiceNumber,
                                  style: textStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                badgeStatus(val.status)
                              ],
                            ),
                            Text(
                              "Booked : " + dateformat(val.bookDatetime),
                              style: textStyle.copyWith(
                                  color: Colors.grey, fontSize: 12),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Masa : " +
                                      dateformat(val.rentDatetimeStart) +
                                      " - " +
                                      dateformat(val.rentDatetimeEnd),
                                  style: textStyle.copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                val.status == 'Belum Dibayar'
                                    ? Button(
                                        onPress: () => Get.to(
                                                () => CustRentUploadPaymentPage(
                                                    rent: val, back: 0),
                                                transition: Transition.downToUp)
                                            .whenComplete(() =>
                                                rentController.fetchAll()),
                                        text: "Bayar",
                                        textSize: 14,
                                        rounded: 10,
                                        color: primaryColor,
                                      )
                                    : Container()
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/note.png",
                      width: 150,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Belum ada Pinjaman",
                      style: textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ));
  }

  // Widget : Badge Status
  Widget badgeStatus(String status) {
    Color color;

    if (status == 'Belum Dibayar') {
      color = Colors.orange;
    } else if (status == 'Menunggu Konfirmasi') {
      color = Colors.pink;
    } else if (status == 'Lunas') {
      color = Colors.teal;
    } else if (status == 'Dipinjam') {
      color = Colors.blue;
    } else if (status == 'Selesai') {
      color = Colors.green;
    }

    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color.withOpacity(0.2),
      ),
      child: Text(
        status,
        style: textStyle.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }
}
