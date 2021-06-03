import 'package:dio/dio.dart' as dio;
import 'package:flutter_smart_contract/app/app.locator.dart';
import 'package:flutter_smart_contract/core/api/api.dart';
import 'package:flutter_smart_contract/core/constant/constant.dart';
import 'package:basic_services/basic_services.dart';

class ApiService extends BasicApiService {
  var _dioInstance = dio.Dio()
    ..interceptors.add(dio.LogInterceptor())
    ..options.baseUrl = locator<Api>().baseUrl;

  // cancel token
  final dio.CancelToken cancelToken = dio.CancelToken();

  @override
  Future<dio.Response> dioDownload(String url, String savePath) async {
    dio.Response response;
    response = await _dioInstance
        .download(url, savePath,
            cancelToken: cancelToken,
            onReceiveProgress: (count, total) => print((count / total * 100).toStringAsFixed(0) + "%"))
        .timeout(const Duration(seconds: TIMEOUT_DURATION))
        .whenComplete(() => _dioInstance.clear());

    return response;
  }

  @override
  Future<dio.Response> dioGet(String url,
      {String? token,
      responseType = dio.ResponseType.json,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? query}) async {
    Map<String, dynamic> _headers = Map<String, dynamic>();
    if (token != null) _headers['Authorization'] = "Token token=$token";
    dio.Response response;
    response = await _dioInstance
        .get(url,
            queryParameters: query,
            cancelToken: cancelToken,
            options: dio.Options(responseType: dio.ResponseType.json, headers: _headers),
            onReceiveProgress: (count, total) => print((count / total * 100).toStringAsFixed(0) + "%"))
        .timeout(const Duration(seconds: TIMEOUT_DURATION))
        .whenComplete(() => _dioInstance.clear());
    return response;
  }

  @override
  Future<dio.Response> dioPost(String url,
      {data,
      String? token,
      responseType = dio.ResponseType.json,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? query}) async {
    Map<String, dynamic> _headers = Map<String, dynamic>();
    if (token != null) _headers['Authorization'] = "Token token=$token";
    dio.Response response;
    response = await _dioInstance
        .post(url,
            data: data,
            queryParameters: query,
            cancelToken: cancelToken,
            options: dio.Options(responseType: dio.ResponseType.json, headers: _headers),
            onReceiveProgress: (count, total) => print((count / total * 100).toStringAsFixed(0) + "%"),
            onSendProgress: (received, total) => print((received / total * 100).toStringAsFixed(0) + "%"))
        .timeout(const Duration(seconds: TIMEOUT_DURATION))
        .whenComplete(() => _dioInstance.clear());
    return response;
  }
}
