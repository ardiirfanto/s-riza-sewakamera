import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/models/category_model.dart';

// Class Kategori
class CategoryServices {
  Dio dio = new Dio();

  Future fetch() async {
    try {
      final res = await dio.get(apiUrl + 'category');

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        List<CategoryItem> data = listCategoryItemFromJson(toJson);
        return data;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }

  Future getRow(String id) async {
    try {
      final res = await dio.get(apiUrl + "category/get/$id");

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        CategoryItem data = categoryItemFromJson(toJson);
        return data;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }

  Future insert(String category) async {
    try {
      final res = await dio
          .post(apiUrl + "category/store", data: {"category_name": category});

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        return toJson;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }

  Future edit(String id, String category) async {
    try {
      final res = await dio.post(apiUrl + "category/update/$id",
          data: {"category_name": category});

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        return toJson;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }

  Future delete(String id) async {
    try {
      final res = await dio.post(apiUrl + "category/delete/$id");

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        return toJson;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }
}
