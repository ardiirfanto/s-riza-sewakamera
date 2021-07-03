import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:s_riza_sewakamera/constants/string.dart';
import 'package:s_riza_sewakamera/models/user_model.dart';

class AuthServices {
  Dio dio = new Dio();

  Future login(String username, password) async {
    try {
      final res = await dio.post(
        apiUrl + 'login',
        data: {
          "username": username,
          "password": password,
        },
      );

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        User data = userFromJson(toJson);
        return data;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }

  Future register(
      String username, password, custName, custAddress, custPhone) async {
    try {
      final res = await dio.post(
        apiUrl + 'register',
        data: {
          "username": username,
          "password": password,
          "cust_name": custName,
          "cust_address": custAddress,
          "cust_phone": custPhone,
        },
      );

      if (res.statusCode == 200) {
        final toJson = json.encode(res.data['res']);
        User data = userFromJson(toJson);
        return data;
      } else {
        return 1;
      }
    } on DioError catch (e) {
      print(e);
      return 0;
    }
  }
}
