import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/category_controller.dart';
import 'package:s_riza_sewakamera/controllers/item_controller.dart';
import 'package:s_riza_sewakamera/widgets/button.dart';

class AdminItemAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemController itemController = Get.find();
    CategoryController categoryController = Get.put(CategoryController());

    itemController.resetVariable();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            ),
            onPressed: () => Get.back()),
        title: Text(
          "Tambah Barang",
          style: textStyle.copyWith(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: itemController.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imgPick(itemController),
                Text(
                  "Klik untuk mengunggah",
                  style: textStyle.copyWith(color: Colors.grey),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kategori Barang",
                      style: textStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      width: Get.width / 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: accentColor,
                          width: 1,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Obx(
                          () => DropdownButton(
                            isExpanded: true,
                            onChanged: (val) => itemController.setCategory(val),
                            value: itemController.categoryId.value,
                            items: categoryController.list
                                .map(
                                  (cat) => DropdownMenuItem(
                                    value: cat.id.toString(),
                                    child: Text(
                                      cat.categoryName,
                                      style: textStyle.copyWith(fontSize: 15),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                textNamaBarang(itemController),
                SizedBox(height: 20),
                textPriceAndStock(itemController),
                SizedBox(height: 10),
                buttonSave(itemController)
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Image Picker
  Widget imgPick(ItemController itemController) {
    return GestureDetector(
      onTap: () => itemController.pickImg(),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Obx(
              () => Image(
                image: itemController.imgFilePath.value != ''
                    ? FileImage(File(itemController.imgFilePath.value))
                    : AssetImage(imgPath + 'img_preview.jpg'),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }

  // Text Nama Barang
  Widget textNamaBarang(ItemController itemController) {
    return Container(
      height: 50,
      color: Colors.white,
      child: TextFormField(
        controller: itemController.textName,
        cursorColor: primaryColor,
        style: textStyle,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: new BorderSide(color: primaryColor),
          ),
          labelText: "Nama Barang",
          labelStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  // Text Price And Stock
  Widget textPriceAndStock(ItemController itemController) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            color: Colors.white,
            child: TextFormField(
              controller: itemController.textPrice,
              keyboardType: TextInputType.number,
              cursorColor: primaryColor,
              style: textStyle,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: new BorderSide(color: primaryColor),
                ),
                labelText: "Harga Sewa Barang",
                labelStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Container(
            height: 50,
            color: Colors.white,
            child: TextFormField(
              controller: itemController.textStock,
              keyboardType: TextInputType.number,
              cursorColor: primaryColor,
              style: textStyle,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: new BorderSide(color: primaryColor),
                ),
                labelText: "Stok Barang",
                labelStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Button Save
  Widget buttonSave(ItemController itemController) {
    return SizedBox(
      width: Get.width,
      height: 50,
      child: Button(
        color: primaryColor,
        text: "Simpan",
        textSize: 16,
        rounded: 10,
        onPress: () => itemController.insert(),
      ),
    );
  }
}
