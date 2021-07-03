import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/models/rent_model.dart';

// Class Rent
class RentServices {
  Dio dio = new Dio();

  Future insertRent(String custId, rentStart, rentEnd, List items) async {
    try {
      final res = await dio.post(
        apiUrl + "rent/add",
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: json.encode(
          {
            "cust_id": custId,
            "rent_start": rentStart,
            "rent_end": rentEnd,
            "items": items,
          },
        ),
      );

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        Rent data = rentFromJson(toJson);
        return data;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }

  Future fetchRent(String custId, String status) async {
    try {
      final res = await dio.get(
        apiUrl + 'rent/$status/$custId',
        options: Options(receiveTimeout: 10000, sendTimeout: 10000),
      );

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        List<Rent> data = listRentFromJson(toJson);
        return data;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }

  Future uploadPayment(String imgPath, String rentId) async {
    try {
      String fileName = imgPath.split('/').last;

      FormData data = FormData.fromMap(
          {"file": await MultipartFile.fromFile(imgPath, filename: fileName)});

      final res =
          await dio.post(apiUrl + "rent/update_file/$rentId", data: data);

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

  Future updateStatus(String rentId) async {
    try {
      final res = await dio.get(apiUrl + "rent/update_status/$rentId");

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

  Future updateReturn(String rentId) async {
    try {
      final res = await dio.get(apiUrl + "rent/update_return/$rentId");

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
