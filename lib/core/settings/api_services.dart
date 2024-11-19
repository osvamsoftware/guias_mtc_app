import 'dart:convert';

import 'package:app_remision/core/settings/exception_handler.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client _client;

  ApiService() : _client = http.Client();

  Future<String> getToken() async {
    return '';
    // return Preferences.getAuthToken;
  }

  Future<dynamic> _request(http.Request request, bool withAuth, bool decoded) async {
    try {
      final token = withAuth ? await getToken() : '';

      if (withAuth && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      request.headers['Content-Type'] = 'application/json; charset=utf-8';
      final http.Response response =
          await _client.send(request).then((streamedResponse) => http.Response.fromStream(streamedResponse));

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        var decodedResponse = utf8.decode(response.bodyBytes);
        var jsonResponse = jsonDecode(decodedResponse);
        return decoded ? jsonResponse : response;
      } else {
        throw ApiException('HTTP Error: ${response.statusCode} ${response.body}', response.statusCode);
      }
    } catch (e) {
      // Handle exceptions
      rethrow;
    }
  }

  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    bool withAuth = true,
    bool decoded = true,
    Map<String, String>? queryParameters,
  }) {
    final uri = Uri.parse(url);
    final uriWithQuery = uri.replace(queryParameters: queryParameters);
    final request = http.Request('GET', uriWithQuery);
    request.headers.addAll(headers ?? {});
    return _request(request, withAuth, decoded);
  }

  Future<dynamic> getFormatted(
    String url, {
    Map<String, String>? headers,
    bool withAuth = true,
    bool decoded = true,
    Map<String, String>? queryParameters,
    int page = 1,
    int perPage = 30,
  }) {
    late String uriWithQuery;
    if (queryParameters == null || queryParameters.isEmpty) {
      uriWithQuery = "$url?per_page=$perPage&page=$page";
    } else {
      final queryParams = queryParameters.entries.map((entry) {
        return '${entry.key}=${entry.value}';
      }).join('&');
      uriWithQuery = "$url?per_page=$perPage&page=$page&$queryParams";
    }

    final uri = Uri.parse(uriWithQuery);
    final request = http.Request('GET', uri);
    request.headers.addAll(headers ?? {});

    return _request(request, withAuth, decoded);
  }

  Future<dynamic> getFormatted2(
    String url, {
    Map<String, String>? headers,
    bool withAuth = true,
    bool decoded = true,
    Map<String, String>? queryParameters,
    int page = 1,
    int perPage = 30,
  }) {
    final uriWithQuery = "$url?page=$page&per_page=$perPage&queryParams=${queryParameters!.entries.map((entry) {
      return '${entry.key}%3D${entry.value}';
    }).join('%26')}";
    final uri = Uri.parse(uriWithQuery);

    final request = http.Request('GET', uri);
    request.headers.addAll(headers ?? {});
    return _request(request, withAuth, decoded);
  }

  Future<dynamic> post(String url,
      {Map<String, String>? headers, dynamic body, bool withAuth = true, bool decoded = true}) {
    final request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(headers ?? {})
      ..headers['content-type'] = 'application/json';

    if (body != null) {
      request.body = json.encode(body);
    }

    return _request(request, withAuth, decoded);
  }

  Future<dynamic> put(String url,
      {Map<String, String>? headers, dynamic body, bool withAuth = true, bool decoded = true}) {
    final request = http.Request('PUT', Uri.parse(url))
      ..headers.addAll(headers ?? {})
      ..headers['content-type'] = 'application/json';

    if (body != null) {
      request.body = json.encode(body);
    }
    return _request(request, withAuth, decoded);
  }

  Future<dynamic> delete(String url,
      {Map<String, String>? headers, dynamic body, bool withAuth = true, bool decoded = true}) {
    final request = http.Request('DELETE', Uri.parse(url))
      ..headers.addAll(headers ?? {})
      ..headers['content-type'] = 'application/json';

    if (body != null) {
      request.body = json.encode(body);
    }

    return _request(request, withAuth, decoded);
  }
}
