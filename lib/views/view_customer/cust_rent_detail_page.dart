import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/functions.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/models/rent_model.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_rent_upload_payment.dart';
import 'package:s_riza_sewakamera/widgets/button.dart';
import 'package:s_riza_sewakamera/widgets/image_view.dart';

class CustRentDetailPage extends StatelessWidget {
  final Rent rent;
  final int back;

  CustRentDetailPage({this.rent, this.back = 0});

  @override
  Widget build(BuildContext context) {
    print(back);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Detail Pinjaman",
          style: textStyle.copyWith(
              color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "NO.INV : " + rent.invoiceNumber,
                    style: textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  badgeStatus(rent.status)
                ],
              ),
              Divider(),
              listRow("Booked", dateformat(rent.bookDatetime)),
              listRow(
                  "Masa Pinjam",
                  dateformat(rent.rentDatetimeStart) +
                      ' - ' +
                      dateformat(rent.rentDatetimeEnd)),
              listRow(
                  "Dikembalikan",
                  rent.returnDatetime != null
                      ? dateformat(DateTime.parse(rent.returnDatetime))
                      : '-'),
              Divider(),
              listRow(
                  "Dibayar",
                  rent.paymentDatetime != null
                      ? dateformat(DateTime.parse(rent.paymentDatetime))
                      : '-'),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bukti Bayar", style: textStyle),
                    rent.paymentFile != null
                        ? GestureDetector(
                            onTap: () => Get.to(() => ImageView(
                                img: baseUrl +
                                    'assets/img/payments/' +
                                    rent.paymentFile)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl: baseUrl +
                                    'assets/img/payments/' +
                                    rent.paymentFile,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Text(
                            "-",
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.bold),
                          )
                  ],
                ),
              ),
              Divider(),
              listRow("Nama Peminjam", rent.custName),
              listRow("Alamat Peminjam", rent.custAddress),
              listRow("Kontak Peminjam", rent.custPhone),
              Divider(),
              listItems(),
              Divider(),
              listRow("Total Pembayaran", rupiah(rent.totalPrice), size: 19.0),
              SizedBox(height: 20),
              rent.status == 'Belum Dibayar'
                  ? SizedBox(
                      width: Get.width,
                      height: 50,
                      child: Button(
                        onPress: () => Get.to(
                            () => CustRentUploadPaymentPage(
                                  rent: rent,
                                  back: back,
                                ),
                            transition: Transition.downToUp),
                        text: "Bayar",
                        textSize: 17,
                        color: primaryColor,
                        rounded: 10,
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  // Widget : List Item
  Widget listItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Daftar Barang",
            style: textStyle.copyWith(fontWeight: FontWeight.bold)),
        ListView.separated(
          separatorBuilder: (ctx, i) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(),
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: rent.items.length,
          itemBuilder: (context, i) {
            var val = rent.items[i];
            return Padding(
              padding: const EdgeInsets.all(10),
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
                          rupiah(val.rentItemPrice),
                          style: textStyle.copyWith(
                            color: primaryColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Qty : " + val.itemQty.toString(),
                          style: textStyle.copyWith(
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // Widget : list Row
  Widget listRow(String title, text, {size = 12.0}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textStyle),
          Text(text,
              style: textStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: size)),
        ],
      ),
    );
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
