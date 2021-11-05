import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/apiresult.dart';


class Api {
  static const BASE_URL = 'https://covid19.ddc.moph.go.th/api/Cases';

  Future<dynamic> fetch(
      String endPoint, {
        Map<String, dynamic>? queryParams,
      }) async {
    String queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse('$BASE_URL/$endPoint?$queryString');

    final response = await http.get(url,);

    if (response.statusCode == 200) {
      // แปลง text ที่มีรูปแบบเป็น JSON ไปเป็น Dart's data structure (List/Map)
    dynamic jsonBody = json.decode(response.body);

      print('RESPONSE BODY: ${jsonBody[0]}');

      // แปลง Dart's data structure ไปเป็น model (POJO)
      var apiResult = ApiResult.fromJson(jsonBody[0]);

     return apiResult;
    } else {
      throw 'Server connection failed!';
    }
  }
}