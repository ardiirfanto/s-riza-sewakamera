import 'package:get/get.dart';
import 'package:s_riza_sewakamera/views/view_admin/admin_categories_page.dart';
import 'package:s_riza_sewakamera/views/view_admin/admin_items_page.dart';
import 'package:s_riza_sewakamera/views/view_admin/admin_rents_page.dart';

class AdminController extends GetxController {
  List page = [
    AdminRentPage(),
    AdminCategoryPage(),
    AdminItemPage(),
  ];

  Rx<int> selectedIndex = 0.obs;

  changePage(int index) => this.selectedIndex.value = index;
}
