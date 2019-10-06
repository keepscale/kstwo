import 'dart:async';

import 'package:http/http.dart' as http;

class NetworkService {

  static final String base_path = "https://booking.crossfit-nancy.fr/";

  static Map<String, String> headers = {"content-type": "text/json"};
  static Map<String, String> cookies = {};

  static void _updateCookie(http.Response response) {
    String allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {

      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      headers['cookie'] = _generateCookieHeader();
    }
  }

  static void _setCookie(String rawCookie) {
    if (rawCookie.length > 0) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires')
          return;

        cookies[key] = value;
      }
    }
  }

  static String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.length > 0)
        cookie += ";";
      cookie += key + "=" + cookies[key];
    }

    return cookie;
  }

  static Future<http.Response> get(String url) {
    return http.get(base_path + url, headers: headers).then((http.Response response) {

      print("GET " + url + "=>" + response.statusCode.toString());

      _updateCookie(response);

      return response;
    });
  }

  static Future<http.Response> post(String url, {body, encoding}) {
    return http
        .post(base_path + url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {

      print("POST " + url + "=>" + response.statusCode.toString());

      _updateCookie(response);

      return response;
    });
  }

  static Future<http.Response> postFormData(String url, {body, encoding}) {
    return http
        .post(base_path + url, body: body, encoding: encoding)
        .then((http.Response response) {

        print("POST " + url + "=>" + response.statusCode.toString());

      _updateCookie(response);

      return response;
    });
  }
}