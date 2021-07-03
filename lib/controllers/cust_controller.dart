import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/models/item_model.dart';
import 'package:s_riza_sewakamera/services/rent_services.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_beranda_page.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_profile_page.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_rent_detail_page.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_rents_page.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustController extends GetxController {
  //Cart
  RxList<Item> cart = RxList<Item>();
  Rx<DateTime> startDate = new DateTime.now().obs;
  Rx<DateTime> endDate = new DateTime.now().add(Duration(days: 1)).obs;
  RxInt totalDay = 1.obs;
  DateRangePickerController pinjamDate = new DateRangePickerController();
  RxInt totalPrice = 0.obs;

  // List Page
  List page = [
    CustBerandaPage(),
    CustSearchPage(),
    CustRentPage(),
    CustProfilePage(),
  ];

  Rx<int> selectedPage = 0.obs;

  TextEditingController textQtyItem = new TextEditingController();

  RentServices rentApi = new RentServices();

  // CustItemDetailPage : Set Init Untuk Qty Item
  setQtyItem(int itemQty) {
    var qty = 0;
    if (itemQty > 0) {
      qty = 1;
    } else {
      qty = 0;
    }

    this.textQtyItem.text = qty.toString();
  }

  // CustHomePage : Merubah Page pada Tabs
  changePage(int index) => this.selectedPage.value = index;

  // CustItemDetailPage : Menambah Cart
  addToCart(Item val) {
    Item item = new Item();

    item.id = val.id;
    item.categoryId = val.categoryId;
    item.categoryName = val.categoryName;
    item.itemName = val.itemName;
    item.itemImg = val.itemImg;
    item.itemPrice = val.itemPrice;
    item.itemStock = val.itemStock;
    item.itemQty = int.parse(this.textQtyItem.text);

    if (this.cart.any((element) => element.id == item.id)) {
      int i = this.cart.indexWhere((element) => element.id == item.id);
      int currentQty = this.cart[i].itemQty + int.parse(this.textQtyItem.text);
      if (currentQty <= item.itemStock) {
        this.cart[i].itemQty = currentQty;
      }
    } else {
      this.cart.add(item);
    }
  }

  // CustCartPage : Bersihkan Keranjang
  clearCart() {
    this.cart.clear();
    this.calculatePrice();
  }

  // CustItemDetailPage : Menambah Qty Item untuk dimasukan ke Cart
  incQty(int stock) {
    var qty = int.parse(this.textQtyItem.text);
    if (qty < stock) {
      qty++;
    }

    this.textQtyItem.text = qty.toString();
  }

  // CustItemDetailPage : Mengurangi Qty Item untuk dimasukan ke Cart
  decQty() {
    var qty = int.parse(this.textQtyItem.text);
    if (qty >= 2) {
      qty--;
    }

    this.textQtyItem.text = qty.toString();
  }

  // CartPage : Menambah Qty item dalam Keranjang
  incItemQty(Item val) {
    int i = this.cart.indexWhere((element) => element.id == val.id);

    int qty = this.cart[i].itemQty;
    if (qty < val.itemStock) {
      qty++;
    }

    this.cart[i].itemQty = qty;
    this.cart.refresh();
    this.calculatePrice();
  }

  // CartPage : Mengurangi Qty item dalam Keranjang
  decItemQty(Item val) {
    int i = this.cart.indexWhere((element) => element.id == val.id);

    int qty = this.cart[i].itemQty;
    if (qty >= 2) {
      qty--;
    }

    this.cart[i].itemQty = qty;

    this.cart.refresh();
    this.calculatePrice();
  }

  // CartPage : Hapus Item dari Keranjang
  removeItem(Item item) {
    this.cart.removeWhere((element) => element.id == item.id);
    this.calculatePrice();
  }

  // CartPage : Update Tanggal Mulai dan Selesai
  updateDate() {
    DateTime start = pinjamDate.selectedRange.startDate;
    DateTime end = pinjamDate.selectedRange.endDate;

    if (end != null && start != null) {
      this.startDate.value = start;
      this.endDate.value = end;
      this.totalDay.value = end.difference(start).inDays;
    }
    this.cart.refresh();
    this.calculatePrice();
    Get.back();
  }

  // CartPage : Menghitung Total Biaya
  calculatePrice() {
    var sum = 0;
    if (this.cart.length > 0) {
      this.cart.forEach((element) {
        sum += (element.itemPrice * element.itemQty) * this.totalDay.value;
      });
      this.totalPrice.value = sum;
    }
  }

  // CartPage : Checkout
  checkout() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    List items = [];
    var custId = _pref.getInt('cust_id').toString();

    this.cart.forEach((item) {
      var itemsData = {
        'item_id': item.id,
        'qty': item.itemQty,
        'price': (item.itemQty * item.itemPrice) * totalDay.value
      };

      items.add(itemsData);
    });
    Get.back();

    dialogLoading();

    rentApi
        .insertRent(
            custId, startDate.value.toString(), endDate.value.toString(), items)
        .then((value) {
      Get.back();
      if (value == 1 || value == 0) {
        snackbar('Gagal', 'Gagal Melakukan Checkout', Colors.red);
      } else {
        snackbar('Sukses', 'Checkout Berhasil', Colors.green);
        this.cart.clear();
        Get.off(
            () => CustRentDetailPage(
                  rent: value,
                  back: 1,
                ),
            transition: Transition.cupertino);
      }
    });
  }

  // CartPage : Loading Dialog
  dialogLoading() {
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
                "Proses Checkout",
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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

  // All : Open Snackbar untuk Alert
  snackbar(title, msg, Color color) {
    return Get.snackbar(title, msg,
        backgroundColor: color, colorText: Colors.white);
  }
}
