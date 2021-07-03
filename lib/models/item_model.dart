import 'dart:convert';

List<Item> itemFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  Item(
      {this.id,
      this.categoryId,
      this.itemName,
      this.itemStock,
      this.itemQty,
      this.itemPrice,
      this.itemImg,
      this.categoryName});

  int id;
  int categoryId;
  String itemName;
  int itemStock;
  int itemQty = 0;
  int itemPrice;
  String itemImg;
  String categoryName;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        categoryId: json["category_id"],
        itemName: json["item_name"],
        itemStock: json["item_stock"],
        itemQty: 0,
        itemPrice: json["item_price"],
        itemImg: json["item_img"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "item_name": itemName,
        "item_stock": itemStock,
        "item_qty": itemQty,
        "item_price": itemPrice,
        "item_img": itemImg,
        "category_name": categoryName,
      };
}
