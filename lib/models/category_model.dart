import 'dart:convert';

CategoryItem categoryItemFromJson(String str) =>
    CategoryItem.fromJson(json.decode(str));

String categoryItemToJson(CategoryItem data) => json.encode(data.toJson());

List<CategoryItem> listCategoryItemFromJson(String str) =>
    List<CategoryItem>.from(
        json.decode(str).map((x) => CategoryItem.fromJson(x)));

String listCategoryItemToJson(List<CategoryItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryItem {
  CategoryItem({
    this.id,
    this.categoryName,
  });

  int id;
  String categoryName;

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        id: json["id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
      };
}
