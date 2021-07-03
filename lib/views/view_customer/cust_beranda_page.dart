import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:s_riza_sewakamera/constants/functions.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/item_controller.dart';
import 'package:s_riza_sewakamera/controllers/cust_controller.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_item_detail.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:unicons/unicons.dart';

class CustBerandaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustController custController = Get.put(CustController());
    ItemController itemController = Get.put(ItemController());

    itemController.fetchNew();
    itemController.fetchPopuler();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          imgPath + 'icon_title.png',
          width: 150,
        ),
        actions: [
          IconButton(
            icon: Icon(UniconsLine.search),
            color: primaryColor,
            onPressed: () => custController.changePage(1),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                datePicker(custController),
                SizedBox(height: 10),
                Text(
                  "Terbaru",
                  style: textStyle.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                newItem(itemController),
                SizedBox(height: 10),
                Text(
                  "Yang mungkin anda suka",
                  style: textStyle.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                popularItem(itemController),
                Text(
                  "Terpopuler",
                  style: textStyle.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                listItem(itemController)
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget :  Date Picker
  Widget datePicker(CustController custController) {
    return Obx(() => SizedBox(
          width: Get.width,
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(UniconsLine.calendar_alt, color: primaryColor),
                      SizedBox(width: 5),
                      Text(
                        "Tanggal Peminjaman",
                        style: textStyle.copyWith(
                          fontSize: 15,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  InkWell(
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
                          rangeTextStyle:
                              textStyle.copyWith(color: primaryColor),
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(0.3)),
                      child: Text(
                        DateFormat("dd MMM yyyy", 'id')
                                .format(custController.startDate.value) +
                            " - " +
                            DateFormat("dd MMM yyyy", 'id')
                                .format(custController.endDate.value),
                        style: textStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // Widget List Item
  Widget listItem(ItemController itemController) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Obx(
        () => itemController.list.length > 0
            ? ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, i) => Divider(color: accentColor),
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, i) {
                  var val = itemController.list[i];
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => Get.to(() => CustItemDetailPage(item: val),
                        transition: Transition.cupertino),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: baseUrl + 'assets/img/items/' + val.itemImg,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        val.itemName,
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(2)),
                            child: Text(
                              val.categoryName,
                              style: textStyle.copyWith(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Text(rupiah(val.itemPrice),
                              style: textStyle.copyWith(fontSize: 12)),
                        ],
                      ),
                      trailing: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircleAvatar(
                          backgroundColor: accentColor,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : SpinKitCircle(
                color: primaryColor,
              ),
      ),
    );
  }

  // Widget Popular Item
  Widget popularItem(ItemController itemController) {
    return Container(
      height: 145,
      padding: EdgeInsets.symmetric(horizontal: 5),
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
                    onTap: () => Get.to(() => CustItemDetailPage(item: val),
                        transition: Transition.cupertino),
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
                                  placeholder:
                                      AssetImage(imgPath + 'img_preview.jpg'),
                                  image: CachedNetworkImageProvider(
                                    baseUrl + 'assets/img/items/' + val.itemImg,
                                  ),
                                  height: 100,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(color: accentColor),
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
                            style:
                                textStyle.copyWith(fontWeight: FontWeight.bold),
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
    );
  }

  // Widget New Item
  Widget newItem(ItemController itemController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Obx(
        () => itemController.listNew.length > 0
            ? CarouselSlider(
                options: CarouselOptions(height: 150.0),
                items: itemController.listNew.map((val) {
                  return GestureDetector(
                    onTap: () => Get.to(() => CustItemDetailPage(item: val),
                        transition: Transition.cupertino),
                    child: Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: Get.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: accentColor,
                            border: Border.all(color: accentColor, width: 2),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  baseUrl + 'assets/img/items/' + val.itemImg),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.6),
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10)),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    val.itemName,
                                    style: textStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: accentColor,
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Text(
                                          val.categoryName,
                                          style: textStyle.copyWith(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        rupiah(val.itemPrice),
                                        style: textStyle.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              )
            : SpinKitCircle(
                color: primaryColor,
              ),
      ),
    );
  }
}
