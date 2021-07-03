import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/models/category_model.dart';
import 'package:s_riza_sewakamera/services/category_services.dart';

class CategoryController extends GetxController {
  CategoryServices api = new CategoryServices();

  final RxList<CategoryItem> list = RxList<CategoryItem>();
  CategoryItem data = new CategoryItem();
  final formKey = GlobalKey<FormState>();
  TextEditingController textCategory = new TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  fetch() {
    api.fetch().then((value) => this.list.assignAll(value));
  }

  getRow(String id) {
    api.getRow(id).then((value) => this.data = value);
  }

  insert() {
    if (textCategory.text == '' || textCategory.text == null) {
      snackbar('Peringatan', 'Harap Lengkapi Kolom', Colors.orange);
    } else {
      api.insert(textCategory.text).then((value) {
        if (value == 1 || value == 0) {
          snackbar('Gagal', 'Gagal Menyimpan', Colors.red);
        } else {
          textCategory.text = '';
          Get.back();
          fetch();
          snackbar('Sukses', 'Berhasil Menyimpan', Colors.green);
        }
      });
    }
  }

  edit(String id) {
    if (textCategory.text == '' || textCategory.text == null) {
      snackbar('Peringatan', 'Harap Lengkapi Kolom', Colors.orange);
    } else {
      api.edit(id, textCategory.text).then((value) {
        if (value == 1 || value == 0) {
          snackbar('Gagal', 'Gagal Mengubah', Colors.red);
        } else {
          textCategory.text = '';
          Get.back();
          fetch();
          snackbar('Sukses', 'Berhasil Mengubah Data', Colors.green);
        }
      });
    }
  }

  delete(String id) {
    api.delete(id).then((value) {
      if (value == 1 || value == 0) {
        snackbar('Gagal', 'Gagal Menghapus', Colors.red);
      } else {
        textCategory.text = '';
        Get.back();
        fetch();
        snackbar('Sukses', 'Berhasil Menghapus Data', Colors.green);
      }
    });
  }

  snackbar(title, msg, Color color) {
    return Get.snackbar(title, msg,
        backgroundColor: color, colorText: Colors.white);
  }
}
