import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/models/item_model.dart';
import 'package:s_riza_sewakamera/services/item_services.dart';

class SearchController extends GetxController {
  final RxList<Item> listSearch = RxList<Item>();
  ItemServices api = new ItemServices();
  TextEditingController textSearch = new TextEditingController();
  RxBool isLoading = false.obs;

  // Cust : Saat Button Search di klik
  onSearch() {
    if (textSearch.text == '' || textSearch.text == null) {
      snackbar('Peringatan', 'Kolom Search tidak boleh kosong', Colors.orange);
    } else {
      this.isLoading.value = true;
      this.listSearch.clear();
      api.search(textSearch.text).then((value) {
        this.isLoading.value = false;
        if (value == 1 || value == 0) {
          snackbar('Gagal', 'Gagal Mendapatkan Data', Colors.red);
        } else {
          if (value == 2) {
            snackbar('Maaf', 'Apa yang kamu cari tidak ada', Colors.red);
          } else {
            this.listSearch.assignAll(value);
          }
        }
      });
    }
  }

  // All : Open Snackbar untuk Alert
  snackbar(title, msg, Color color) {
    return Get.snackbar(title, msg,
        backgroundColor: color, colorText: Colors.white);
  }
}
