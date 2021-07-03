import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/item_controller.dart';
import 'package:s_riza_sewakamera/models/item_model.dart';
import 'package:s_riza_sewakamera/views/view_admin/admin_items_add_page.dart';
import 'package:s_riza_sewakamera/views/view_admin/admin_items_edit_page.dart';

class AdminItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemController itemController = Get.put(ItemController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kelola Data Barang",
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
            onPressed: () => Get.to(() => AdminItemAddPage(),
                    transition: Transition.cupertino)
                .whenComplete(() => itemController.fetch()),
            icon: Icon(
              Icons.add_box_rounded,
              size: 25,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
            child: Obx(() => itemController.list.length > 0
                ? Column(
                    children: itemController.list
                        .map(
                          (val) => listItem(val, itemController),
                        )
                        .toList(),
                  )
                : Container(
                    height: Get.size.height,
                    child: Center(
                      child: SpinKitCircle(
                        color: primaryColor,
                      ),
                    ),
                  ))),
      ),
    );
  }

  // Widget List Item
  Widget listItem(Item val, ItemController itemController) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: baseUrl + 'assets/img/items/' + val.itemImg,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      val.itemName,
                      style: textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      val.categoryName,
                      style: textStyle.copyWith(color: Colors.grey),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp.${val.itemPrice}",
                            style: textStyle.copyWith(color: Colors.grey)),
                        Text("Stok: ${val.itemStock}",
                            style: textStyle.copyWith(color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      secondaryActions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: IconSlideAction(
              caption: 'Edit',
              color: Colors.blue,
              icon: FontAwesome5.pencil_alt,
              onTap: () => Get.to(
                      () => AdminItemEditPage(
                            item: val,
                          ),
                      transition: Transition.cupertino)
                  .whenComplete(() => itemController.fetch()),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: IconSlideAction(
                caption: 'Hapus',
                color: Colors.red,
                icon: FontAwesome5.trash_alt,
                onTap: () => delDialog(val, itemController)),
          ),
        ),
      ],
    );
  }

  // Dialog Konfirmasi Hapus Data
  delDialog(Item val, ItemController itemController) {
    return Get.dialog(
      AlertDialog(
        title: Text(
          "Hapus Barang",
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Yakin ingin menghapus Item ${val.itemName} ?",
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
            child: Text('Hapus', style: textStyle.copyWith(color: Colors.red)),
            onPressed: () => itemController.delete(val.id.toString()),
          ),
        ],
      ),
    );
  }
}
