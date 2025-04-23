// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suktha_crm/Model/login_model.dart';
import 'package:suktha_crm/utils/Data/custom_print.dart';
import 'package:suktha_crm/utils/api/common_api.dart';
import 'package:suktha_crm/utils/check_token_expired.dart';

enum TheResponseType { list, map, bytes, bool }

Future<dynamic> apiCallService(
  String endpoint,
  String method,
  dynamic body,
  TheResponseType responseType,
  Map<String, dynamic>? queryParameters,
  bool isAuth,
) async {
  final dio = Dio();
  final url = isAuth ? '$baseAuthUrl/auth$endpoint' : "$baseUrl$endpoint";

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  LoginModel? loginDetails;
  if (isAuth != true) {
    final logindecoded = json.decode(sharedPreferences.getString('userMap')!);
    loginDetails = LoginModel.fromJson(logindecoded);
  }

  try {
    late Response response;

    if (method == 'GET') {
      if (responseType == TheResponseType.bytes) {
        //any images or something
        response = await dio.get(url,
            options: Options(responseType: responseType == TheResponseType.bytes ? ResponseType.bytes : null, headers: isAuth ? {} : {"Authorization": "Bearer ${loginDetails!.token}"}));
      } else {
        //normal get method
        response = await dio.get(url, options: Options(headers: isAuth ? {} : {"Authorization": "Bearer ${loginDetails!.token}", "content-type": "application/json"}));
      }
    } else if (method == 'POST') {
      if (responseType == TheResponseType.bytes) {
        response = await dio.request(url,
            queryParameters: queryParameters,
            data: body,
            options:
                Options(method: 'POST', responseType: responseType == TheResponseType.bytes ? ResponseType.bytes : null, headers: isAuth ? {} : {"Authorization": "Bearer ${loginDetails!.token}"}));
      } else {
        response = await dio.post(url, queryParameters: queryParameters, data: body, options: Options(headers: isAuth ? {} : {"Authorization": "Bearer ${loginDetails!.token}"}));
      }
    } else if (method == 'PUT') {
      response = await dio.put(url, data: body, options: Options(headers: isAuth ? {} : {"Authorization": "Bearer ${loginDetails!.token}"}));
    } else if (method == 'DELETE') {
      response = await dio.delete(url, options: Options(headers: isAuth ? {} : {"Authorization": "Bearer ${loginDetails!.token}"}));
    }

    CustomPrint.printSuccess("Success: true, " +
        "url: $url, " +
        "method: $method, " +
        "para: $queryParameters, " +
        "body: $body, " +
        "status code: ${response.statusCode}, " +
        "data: ${response.data}" +
        "use Token: ${isAuth ? false : true}, ");
    log("Success: true, " +
        "\nurl: $url, " +
        "\nmethod: $method, " +
        "\npara: $queryParameters, " +
        "\nbody: $body, " +
        "\nstatus code: ${response.statusCode}, " +
        "\ndata: ${response.data}" +
        "\nuse Token: ${isAuth ? false : true}, ");

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Successful response
      if (response.data == TheResponseType.list) {
        return response.data as List<dynamic>;
      } else if (response.data == TheResponseType.map) {
        return response.data as Map<String, dynamic>;
      } else if (response.data == TheResponseType.bytes) {
        return response.data;
      } else if (response.data == null) {
        log("response is null");
      } else {
        // Handle other response types if needed
        return response.data;
      }
    } else {
      print("some issues");
      return null;
      // Handle error response
    }
  } on DioException catch (e) {
    await checkTokenExpired(e.response!.statusCode ?? 0);
    // Handle network errors

    CustomPrint.printError(
        "{ Success: False, url: $url, method: $method, para: $queryParameters, body: $body, status code: ${e.response!.statusCode}, data: ${e.response!.data}, use Token: ${isAuth ? false : true}, }");
    log("Success: False, " +
        "\nurl: $url, " +
        "\nmethod: $method, " +
        "\npara: $queryParameters, " +
        "\nbody: $body, " +
        "\nstatus code: ${e.response!.statusCode}, " +
        "\ndata: ${e.response!.data}" +
        "\nuse Token: ${isAuth ? false : true}, ");

    if (e.response!.data != null || e.response!.data != "") {
      // print("errorr-----${e.response!.data['error']}");
      // customSnackbar(e.response!.data['error'].toString(), e.response!.data['message'].toString(), 'error');
    } else {}
  } finally {}
}
