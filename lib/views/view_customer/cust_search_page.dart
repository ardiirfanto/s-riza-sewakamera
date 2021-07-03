import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:s_riza_sewakamera/constants/functions.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';
import 'package:s_riza_sewakamera/controllers/search_controller.dart';
import 'package:s_riza_sewakamera/views/view_customer/cust_item_detail.dart';
import 'package:unicons/unicons.dart';

class CustSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.put(SearchController());

    return Scaffold(
      appBar: _appBar(searchController),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Obx(
          () => searchController.isLoading.value == true
              ? Center(
                  child: SpinKitCircle(
                    color: primaryColor,
                  ),
                )
              : searchController.listSearch.length > 0
                  ? listItem(searchController)
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Image.asset("assets/img/search.png"),
                      ),
                    ),
        ),
      ),
    );
  }

  // Widget : List Item
  Widget listItem(SearchController searchController) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => searchController.listSearch.clear(),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.withOpacity(0.4)),
            child: Icon(Icons.close, color: Colors.grey),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (ctx, i) => Divider(),
            shrinkWrap: true,
            itemCount: searchController.listSearch.length,
            itemBuilder: (context, i) {
              var val = searchController.listSearch[i];
              return InkWell(
                onTap: () => Get.to(() => CustItemDetailPage(item: val),
                    transition: Transition.cupertino),
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder: AssetImage(imgPath + 'img_preview.jpg'),
                          image: CachedNetworkImageProvider(
                            baseUrl + 'assets/img/items/' + val.itemImg,
                          ),
                          height: 90,
                          width: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            val.itemName,
                            style: textStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 7),
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              val.categoryName,
                              style: textStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            rupiah(val.itemPrice),
                            style: textStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 22),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  //Widget : Appbar
  Widget _appBar(SearchController searchController) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.only(left: 2),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: searchController.textSearch,
          autofocus: false,
          textInputAction: TextInputAction.search,
          style: textStyle,
          onSubmitted: (_) => searchController.onSearch(),
          cursorColor: primaryColor,
          decoration: InputDecoration(
            hintText: "Apa yang kamu cari?",
            hintStyle: textStyle.copyWith(
              color: Colors.black45,
              fontSize: 18,
            ),
            labelStyle: textStyle,
            border: InputBorder.none,
            prefixIcon: Icon(
              UniconsLine.search,
              size: 25,
              color: Colors.black54,
            ),
            suffixIcon: IconButton(
              onPressed: () => searchController.textSearch.clear(),
              focusColor: Colors.grey,
              icon: Icon(
                Icons.close,
                color: Colors.black45,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
