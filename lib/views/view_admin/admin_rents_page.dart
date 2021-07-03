import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/functions.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/auth_controller.dart';
import 'package:s_riza_sewakamera/controllers/rent_controller.dart';
import 'package:s_riza_sewakamera/models/rent_model.dart';
import 'package:s_riza_sewakamera/views/view_admin/admin_rent_detail_page.dart';

class AdminRentPage extends StatelessWidget {
  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final RentController rentController = Get.put(RentController());
    rentController.fetchAll();
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Admin Dashboard",
            style: textStyle.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () => logOutDialog(_authController),
              icon: Icon(
                Icons.logout,
                size: 20,
                color: primaryColor,
              ),
            ),
          ],
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
                      onTap: () => Get.to(() => AdminRentDetailPage(rent: val),
                              transition: Transition.cupertino)
                          .whenComplete(() => rentController.fetchAll()),
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
                                    fontSize: 12,
                                  ),
                                ),
                                badgeStatus(val.status)
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Booked : " + dateformat(val.bookDatetime),
                                  style: textStyle.copyWith(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                Text(
                                  "Oleh : " + val.custName,
                                  style: textStyle.copyWith(
                                      color: Colors.grey, fontSize: 12),
                                )
                              ],
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

  // Void : LogOut Dialoh
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
