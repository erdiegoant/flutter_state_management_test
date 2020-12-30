import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:state_management_test/app/locator.dart';
import 'package:state_management_test/services/shared_preferences_service.dart';

@lazySingleton
class ApiService {
  final _preferencesService = locator<SharedPreferencesService>();
  final baseUrl = 'http://10.0.2.2:8000/api/';

  Future<Dio> api() async {
    var options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
    );

    var dio = await Dio(options);
    // Uncomment this to view the requests in the logs
    // dio.interceptors.add(LogInterceptor());

    return dio;
  }

  Future<Dio> apiWithToken() async {
    var preferences = await _preferencesService;
    final token = await preferences.getToken();

    var options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${token}',
      },
    );

    var dio = await Dio(options);
    // Uncomment this to view the requests in the logs
    dio.interceptors.add(LogInterceptor());

    return dio;
  }
}
