import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../config/app_config.dart';
import '../domain/model/network_status_model.dart';
import '../domain/model/response_model.dart';
import '../env.dart';
import '../presentation/logic/shared_preferences_logic.dart';
import '../session.dart';
import 'http_config.dart';

enum HttpMethod { get, post, put, patch, delete }

enum ProviderType { membership, pos }

class ApiProvider {
  final client = http.Client();
  final String baseUrl;
  final int timeoutSeconds;

  ApiProvider({String? baseUrl, int? timeoutSeconds})
      : baseUrl = baseUrl ?? Env.value.beUrl,
        timeoutSeconds = timeoutSeconds ?? 120;

  String? get token {
    if (Get.isRegistered<SharedPreferencesLogic>()) {
      final localSession = Get.find<SharedPreferencesLogic>();
      return baseUrl == AppConfig.posBaseUrl
          ? localSession.getTokenPOS
          : localSession.getToken;
    }
    return Session().getToken();
  }

  /// Main handler for JSON requests
  Future<ResponseModel> request(
    HttpMethod method,
    String endpoint, {
    Map<String, dynamic>? query,
    Object? body,
    Map<String, String>? headers,
  }) async {
    final fullUrlString = baseUrl.endsWith('/') || endpoint.startsWith('/')
        ? '$baseUrl$endpoint'
        : '$baseUrl/$endpoint';
    final url = Uri.parse(fullUrlString)
        .replace(queryParameters: query?.map((k, v) => MapEntry(k, '$v')));

    final baseHeader = await headerLogin();
    if (headers != null) baseHeader.addAll(headers);

    if (baseUrl == AppConfig.posBaseUrl &&
        body is Map<String, dynamic> &&
        token != null) {
      body['access_token'] = token;
    }

    if (kDebugMode) {
      log('[${method.name.toUpperCase()}] $url');
      if (body != null) log('Body: ${jsonEncode(body)}');
    }

    try {
      final clientUsed =
          !kIsWeb ? TrustAllCertificates.getInstance.sslClient() : client;

      late http.Response response;

      switch (method) {
        case HttpMethod.get:
          response = await clientUsed
              .get(url, headers: baseHeader)
              .timeout(Duration(seconds: timeoutSeconds));
          break;
        case HttpMethod.post:
          response = await clientUsed
              .post(url, headers: baseHeader, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutSeconds));
          break;
        case HttpMethod.put:
          response = await clientUsed
              .put(url, headers: baseHeader, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutSeconds));
          break;
        case HttpMethod.patch:
          response = await clientUsed
              .patch(url, headers: baseHeader, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutSeconds));
          break;
        case HttpMethod.delete:
          response = await clientUsed
              .delete(url, headers: baseHeader, body: jsonEncode(body))
              .timeout(Duration(seconds: timeoutSeconds));
          break;
      }

      if (kDebugMode) {
        log('Response (${response.statusCode}) => ${response.body}');
      }

      if (NetworkStatusModel.isStatusOkay(response.statusCode)) {
        return ResponseModel(isError: false, result: response, msg: 'Success');
      }

      if (NetworkStatusModel.isUnauthorized(response.statusCode)) {
        return ResponseModel(
            isError: true, result: response, msg: 'Unauthorized');
      }

      final decoded = jsonDecode(response.body);
      final msg =
          decoded['error_message'] ?? decoded['message'] ?? 'Server Error';
      return ResponseModel(isError: true, result: response, msg: msg);
    } on TimeoutException {
      throw 'Connection Timeout, please check your connection';
    } catch (e) {
      log('Request failed: $e');
      return ResponseModel(isError: true, result: null, msg: e.toString());
    }
  }

  Future<ResponseModel> get(String endpoint,
          {Map<String, dynamic>? query, Map<String, String>? headers}) =>
      request(HttpMethod.get, endpoint, query: query, headers: headers);

  Future<ResponseModel> post(String endpoint,
          {Object? body, Map<String, String>? headers}) =>
      request(HttpMethod.post, endpoint, body: body, headers: headers);

  Future<ResponseModel> put(String endpoint,
          {Object? body, Map<String, String>? headers}) =>
      request(HttpMethod.put, endpoint, body: body, headers: headers);

  Future<ResponseModel> patch(String endpoint,
          {Object? body, Map<String, String>? headers}) =>
      request(HttpMethod.patch, endpoint, body: body, headers: headers);

  Future<ResponseModel> delete(String endpoint,
          {Object? body, Map<String, String>? headers}) =>
      request(HttpMethod.delete, endpoint, body: body, headers: headers);

  /// Upload Image (Single or Multiple)
  Future<ResponseModel> uploadImage(
    String endpoint, {
    List<http.MultipartFile> files = const [],
    Map<String, String>? fields,
    Map<String, String>? headers,
  }) async {
    final fullUrlString = baseUrl.endsWith('/') || endpoint.startsWith('/')
        ? '$baseUrl$endpoint'
        : '$baseUrl/$endpoint';
    final url = Uri.parse(fullUrlString);
    final baseHeader = await headerImage();
    if (headers != null) baseHeader.addAll(headers);

    try {
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(baseHeader);

      if (fields != null) request.fields.addAll(fields);
      if (files.isNotEmpty) request.files.addAll(files);

      final clientUsed =
          !kIsWeb ? TrustAllCertificates.getInstance.sslClient() : client;

      final streamedResponse = await clientUsed
          .send(request)
          .timeout(Duration(seconds: timeoutSeconds));

      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        log('Upload Response (${response.statusCode}) => ${response.body}');
      }

      if (NetworkStatusModel.isStatusOkay(response.statusCode)) {
        return ResponseModel(
            isError: false, result: response, msg: 'Upload success');
      }

      final decoded = jsonDecode(response.body);
      final msg =
          decoded['error_message'] ?? decoded['message'] ?? 'Upload failed';
      return ResponseModel(isError: true, result: response, msg: msg);
    } on TimeoutException {
      throw 'Upload Timeout, please check your connection';
    } catch (e) {
      log('Upload failed: $e');
      return ResponseModel(isError: true, result: null, msg: e.toString());
    }
  }

  /// Legacy methods for backward compatibility with features/core
  Future<ResponseModel> getApi(String urlPrefix,
      {bool header = true, Map<String, dynamic>? query}) async {
    return request(
      HttpMethod.get,
      urlPrefix,
      query: query,
      headers: (header) ? await headerLogin() : headerNormal(),
    );
  }

  Future<ResponseModel> postApi(String urlPrefix,
      {Object? body, bool header = true}) async {
    return request(
      HttpMethod.post,
      urlPrefix,
      body: body,
      headers: (header) ? await headerLogin() : headerNormal(),
    );
  }

  Future<ResponseModel> patchApi(String urlPrefix,
      {Object? body, bool header = true}) async {
    return request(
      HttpMethod.patch,
      urlPrefix,
      body: body,
      headers: (header) ? await headerLogin() : headerNormal(),
    );
  }

  Future<Map<String, String>> headerLogin() async => {
        'Authorization': 'Bearer ${token ?? ''}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Map<String, String> headerNormal() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<Map<String, String>> headerImage() async => {
        'Authorization': 'Bearer ${token ?? ''}',
        'Accept': 'application/json',
      };
}
