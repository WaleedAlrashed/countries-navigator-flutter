import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:countries_navigator/services/network_service/api_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import 'package:http/http.dart' as http;
import '../services_locator.dart';
import 'package:countries_navigator/services/logging_service.dart';

class NetworkService {
  static const String baseUrl = "https://needica7.abonoktah.com/api/v1/";

  final _log = locator<LogService>();
  final dio = Dio();
  final Map<String, String> _requestHeaders = {
    HttpHeaders.acceptHeader: "application/json",
    "X-Requested-With": "XMLHttpRequest"
  };

  Future<dynamic> get(String url) async {
    _log.i("full url ${baseUrl + url}");
    var responseJson;
    try {
      final response = await retry(
        () => http
            .get(Uri.parse(baseUrl + url), headers: _requestHeaders)
            .timeout(const Duration(seconds: 10)),
        retryIf: (error) =>
            error is SocketException || error is TimeoutException,
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw TimeOutException('Connection timedout');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    _log.i(
      "Response Body: ${response.body.toString()}\nStatus Code: ${response.statusCode.toString()}\nContent Length:${response.contentLength.toString()} \nReason Phrase: ${response.reasonPhrase}\nRequest Method: ${response.request!.method}\nRequest Url: ${response.request!.url}\nIsRedirect? ${response.isRedirect}",
    );
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        if (response.body.contains("already been taken.")) {
          // GetWidgetsHelper.showGetSnackbar(
          //   title: LanguageHelper.translate("ProductsGetDialog.warning"),
          //   message:
          //       LanguageHelper.translate("ProductsGetDialog.duplicatedProduct"),
          //   colorText: Colors.green,
          //   icon: Icon(Icons.warning_outlined),
          // );
        }
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
