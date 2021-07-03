import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/models/item_model.dart';

// Class Barang
class ItemServices {
  Dio dio = new Dio();

  Future fetch() async {
    try {
      final res = await dio.get(apiUrl + 'item');

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        List<Item> data = itemFromJson(toJson);
        return data;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }

  Future fetchNew() async {
    try {
      final res = await dio.get(apiUrl + 'item/new');

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        List<Item> data = itemFromJson(toJson);
        return data;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }

  Future fetchPopuler() async {
    try {
      final res = await dio.get(apiUrl + 'item/populer');

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        List<Item> data = itemFromJson(toJson);
        return data;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }

  Future search(String content) async {
    try {
      final res = await dio.post(
        apiUrl + 'item/search',
        data: {"content": content},
      );

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        List<Item> data = itemFromJson(toJson);
        if (data.length > 0) {
          return data;
        } else {
          return 2;
        }
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }

  Future insert(String imgPath, catId, itemName, itemPrice, itemStock) async {
    try {
      String fileName = imgPath.split('/').last;

      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(imgPath, filename: fileName),
        "category_id": catId,
        "item_name": itemName,
        "item_stock": itemStock,
        "item_price": itemPrice,
      });

      final res = await dio.post(apiUrl + "item/store", data: data);

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

  Future edit(String id, imgPath, catId, itemName, itemPrice, itemStock) async {
    try {
      FormData data = FormData.fromMap({
        "category_id": catId,
        "item_name": itemName,
        "item_stock": itemStock,
        "item_price": itemPrice,
      });

      if (imgPath != '') {
        String fileName = imgPath.split('/').last;
        data.files.add(
          MapEntry('file',
              await MultipartFile.fromFile(imgPath, filename: fileName)),
        );
      }

      final res = await dio.post(apiUrl + "item/update/$id", data: data);

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
      final res = await dio.post(apiUrl + "item/delete/$id");

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
