import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:s_riza_sewakamera/models/item_model.dart';
import 'package:s_riza_sewakamera/services/item_services.dart';

class ItemController extends GetxController {
  ItemServices api = new ItemServices();

  final RxList<Item> list = RxList<Item>();
  final RxList<Item> listNew = RxList<Item>();
  final RxList<Item> listPopuler = RxList<Item>();
  Item data = new Item();
  final formKey = GlobalKey<FormState>();
  TextEditingController textName = new TextEditingController();
  TextEditingController textPrice = new TextEditingController();
  TextEditingController textStock = new TextEditingController();
  RxString imgFilePath = ''.obs;
  RxString categoryId = '1'.obs;

  // Kondisi Saat Controller Pertama di Panggil
  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  // Global : Ambil Semua Data Item
  fetch() {
    api.fetch().then((value) => this.list.assignAll(value));
  }

  // Cust : Ambil Data -> Terbaru
  fetchNew() {
    api.fetchNew().then((value) => this.listNew.assignAll(value));
  }

  // Cust : Ambil Data -> Populer
  fetchPopuler() {
    api.fetchPopuler().then((value) => this.listPopuler.assignAll(value));
  }

  // Admin : Insert Item Baru
  insert() {
    if (imgFilePath.value == '') {
      snackbar('Peringatan', 'Gambar Wajib di Unggah', Colors.orange);
    } else {
      if (textName.text == '' ||
          textName.text == null ||
          textPrice.text == '' ||
          textPrice.text == null ||
          textStock.text == '' ||
          textStock.text == null) {
        snackbar('Peringatan', 'Harap Lengkapi Kolom', Colors.orange);
      } else {
        api
            .insert(imgFilePath.value, categoryId.value, textName.text,
                textPrice.text, textStock.text)
            .then((value) {
          if (value == 1 || value == 0) {
            snackbar('Gagal', 'Gagal Menyimpan', Colors.red);
          } else {
            Get.back();
            snackbar('Sukses', 'Berhasil Menyimpan', Colors.green);
          }
        });
      }
    }
  }

  // Admin : Edit Item
  edit(String id) {
    if (textName.text == '' ||
        textName.text == null ||
        textPrice.text == '' ||
        textPrice.text == null ||
        textStock.text == '' ||
        textStock.text == null) {
      snackbar('Peringatan', 'Harap Lengkapi Kolom', Colors.orange);
    } else {
      api
          .edit(id, imgFilePath.value, categoryId.value, textName.text,
              textPrice.text, textStock.text)
          .then((value) {
        if (value == 1 || value == 0) {
          snackbar('Gagal', 'Gagal Merubah Data', Colors.red);
        } else {
          Get.back();
          snackbar('Sukses', 'Berhasil Merubah Data', Colors.green);
        }
      });
    }
  }

  // Admin : Hapus Item
  delete(String id) {
    api.delete(id).then((value) {
      if (value == 1 || value == 0) {
        snackbar('Gagal', 'Gagal Menghapus', Colors.red);
      } else {
        Get.back();
        fetch();
        snackbar('Sukses', 'Berhasil Menghapus Data', Colors.green);
      }
    });
  }

  // Admin : Ambil Foto Item
  pickImg() async {
    final picked = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    if (picked != null) {
      imgFilePath.value = picked.path;
    }
  }

  // Admin : Set Combobox Kategori awal
  setCategory(val) {
    categoryId.value = val;
  }

  // Admin : Reset Variabel di Form AddItemPage
  resetVariable() {
    imgFilePath.value = '';
    categoryId.value = '1';
    textName.text = '';
    textPrice.text = '';
    textStock.text = '';
  }

  // All : Open Snackbar untuk Alert
  snackbar(title, msg, Color color) {
    return Get.snackbar(title, msg,
        backgroundColor: color, colorText: Colors.white);
  }
}
