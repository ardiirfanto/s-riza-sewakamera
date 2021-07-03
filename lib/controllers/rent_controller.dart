import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/models/rent_model.dart';
import 'package:s_riza_sewakamera/services/rent_services.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RentController extends GetxController {
  // Contructor : List untuk menampung data Rent
  RxList<Rent> listBooked = RxList<Rent>();
  RxList<Rent> listWaiting = RxList<Rent>();
  RxList<Rent> listLunas = RxList<Rent>();
  RxList<Rent> listDipinjam = RxList<Rent>();
  RxList<Rent> listSelesai = RxList<Rent>();

  RentServices rentApi = new RentServices();

  RxString custId = "".obs;
  RxString imgFilePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setCustId();
  }

  // Cust : Ambil Foto Bukti Bayar
  pickImg() async {
    final picked = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 40);

    if (picked != null) {
      imgFilePath.value = picked.path;
    }
  }

  // Global : Set Cust Id dan Validasi Roles
  setCustId() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var roles = _pref.getString('roles');

    if (roles == 'admin') {
      this.custId.value = '0';
    } else {
      this.custId.value = _pref.getInt('cust_id').toString();
    }
  }

  // Panggil Semua Fetch
  fetchAll() async {
    await this.setCustId();
    this.fetchBooked();
    this.fetchWaiting();
    this.fetchLunas();
    this.fetchDipinjam();
    this.fetchSelesai();
  }

  // Global : fetch Data by status Booked/Belum Bayar
  fetchBooked() {
    rentApi.fetchRent(custId.value, 'booked').then((value) {
      if (value != 1 && value != 0) {
        this.listBooked.assignAll(value);
      } else {
        print("Booked" + value.toString());
      }
    });
  }

  // Global : fetch Data by status Menunggu Konfirmasi
  fetchWaiting() {
    rentApi.fetchRent(custId.value, 'waiting').then((value) {
      if (value != 1 && value != 0) {
        this.listWaiting.assignAll(value);
      } else {
        print("Waiting" + value.toString());
      }
    });
  }

  // Global : fetch Data by status Lunas
  fetchLunas() {
    rentApi.fetchRent(custId.value, 'lunas').then((value) {
      if (value != 1 && value != 0) {
        this.listLunas.assignAll(value);
      } else {
        print("Lunas" + value.toString());
      }
    });
  }

  // Global : fetch Data by status Dipinjam
  fetchDipinjam() {
    rentApi.fetchRent(custId.value, 'dipinjam').then((value) {
      if (value != 1 && value != 0) {
        this.listDipinjam.assignAll(value);
      } else {
        print("Dipinjam" + value.toString());
      }
    });
  }

  // Global : fetch Data by status Selesai
  fetchSelesai() {
    rentApi.fetchRent(custId.value, 'selesai').then((value) {
      if (value != 1 && value != 0) {
        this.listSelesai.assignAll(value);
      } else {
        print("Selesai" + value.toString());
      }
    });
  }

  // CustUploadPayment : Unggah Dokumen Pembayaran
  uploadPayment(String rentId, int back) {
    if (imgFilePath.value != '') {
      dialogLoading("Mengunggah Bukti Pembayaran");
      rentApi.uploadPayment(imgFilePath.value, rentId).then((value) {
        Get.back();
        if (value == 1 || value == 0) {
          snackbar('Gagal', 'Gagal Mengunggah', Colors.red);
        } else {
          Get.back();
          if (back == 1) {
            Get.off(() => CustHomePage(), transition: Transition.cupertino);
          } else {
            Get.back();
          }
          Get.back();
          snackbar(
              'Sukses', 'Berhasil Mengunggah Bukti Pembayaran', Colors.green);
        }
      });
    } else {
      snackbar('Peringatan', 'Unggah Gambar Dahulu', Colors.orange);
    }
  }

  // CartPage : Loading Dialog
  dialogLoading(String content) {
    return Get.dialog(
      AlertDialog(
        content: Container(
          width: 50,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitCircle(
                color: primaryColor,
              ),
              SizedBox(height: 10),
              Text(
                content,
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Mohon Tunggu",
                style: textStyle,
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Admin : Update Status Lunas
  updateStatus(String rentId) {
    Get.back();
    dialogLoading("Merubah Status Pembayaran");
    rentApi.updateStatus(rentId).then((value) {
      Get.back();
      if (value == 1 || value == 0) {
        snackbar('Gagal', 'Gagal Merubah', Colors.red);
      } else {
        Get.back();
        snackbar('Sukses', 'Pembayaran Sudah Lunas', Colors.green);
      }
      Get.back();
    });
  }

  // Admin : Update Status Pinjaman Kembali
  updateReturn(String rentId) {
    Get.back();
    dialogLoading("Merubah Status Pinjaman");
    rentApi.updateReturn(rentId).then((value) {
      Get.back();
      if (value == 1 || value == 0) {
        snackbar('Gagal', 'Gagal Merubah', Colors.red);
      } else {
        Get.back();
        snackbar('Sukses', 'Pinjaman Sudah Dikembalikan', Colors.green);
      }
      Get.back();
    });
  }

  // All : Open Snackbar untuk Alert
  snackbar(title, msg, Color color) {
    return Get.snackbar(title, msg,
        backgroundColor: color, colorText: Colors.white);
  }
}
