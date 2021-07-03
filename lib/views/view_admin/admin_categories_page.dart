import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/category_controller.dart';
import 'package:s_riza_sewakamera/models/category_model.dart';
import 'package:s_riza_sewakamera/widgets/button.dart';

class AdminCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.put(CategoryController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kelola Kategori Barang",
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
            onPressed: () => formBottomSheet(
              "Tambah Kategori",
              "Simpan",
              "",
              "",
              "save",
              categoryController,
            ),
            icon: Icon(
              Icons.add_circle_rounded,
              size: 25,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Obx(
            () => categoryController.list.length > 0
                ? Column(
                    children: categoryController.list
                        .map(
                          (val) => Column(
                            children: [
                              ListTile(
                                  title: Text(
                                    val.categoryName,
                                    style: textStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () => formBottomSheet(
                                          "Edit Kategori",
                                          "Ubah Data",
                                          val.id.toString(),
                                          val.categoryName,
                                          "edit",
                                          categoryController,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Icon(
                                            FontAwesome5.pencil_alt,
                                            size: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      InkWell(
                                        onTap: () =>
                                            delDialog(val, categoryController),
                                        borderRadius: BorderRadius.circular(5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Icon(
                                            FontAwesome5.trash_alt,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              Divider(
                                color: primaryColor,
                              ),
                            ],
                          ),
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
                  ),
          ),
        ),
      ),
    );
  }

  // Form untuk Tambah Data dan Edit
  formBottomSheet(String title, String buttonText, String id, String value,
      String action, CategoryController categoryController) {
    if (action == "edit") {
      categoryController.textCategory.text = value;
    }
    return Get.bottomSheet(
      Container(
        height: Get.height * 30 / 100,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: Form(
          key: categoryController.formKey,
          child: Column(
            children: [
              Text(
                title,
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              TextFormField(
                controller: categoryController.textCategory,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: new BorderSide(color: primaryColor),
                  ),
                  labelText: "Masukan Nama Kategori",
                  labelStyle: textStyle,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: Get.size.width,
                height: 50,
                child: Button(
                    color: primaryColor,
                    text: buttonText,
                    textSize: 16,
                    rounded: 10,
                    onPress: () => action == 'save'
                        ? categoryController.insert()
                        : categoryController.edit(id)),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Dialog Konfirmasi Hapus Data
  delDialog(CategoryItem val, CategoryController categoryController) {
    return Get.dialog(
      AlertDialog(
        title: Text(
          "Hapus Kategori",
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Yakin ingin menghapus kategori ${val.categoryName} ?",
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
            onPressed: () => categoryController.delete(val.id.toString()),
          ),
        ],
      ),
    );
  }
}
