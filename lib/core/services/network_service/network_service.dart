import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:countries_navigator/core/services/network_service/api_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../services_locator.dart';
import 'package:countries_navigator/core/services/logging_service.dart';

class NetworkService {
  static const String baseUrl = "https://restcountries.com/v3.1";

  final _log = locator<LogService>();

// Global options
  final cacheOptions = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),

    // All subsequent fields are optional.

    // Default.
    policy: CachePolicy.request,
    // Returns a cached response on error but for statuses 401 & 403.
    // Also allows to return a cached response on network errors (e.g. offline usage).
    // Defaults to [null].
    hitCacheOnErrorExcept: [401, 403],
    // Overrides any HTTP directive to delete entry past this duration.
    // Useful only when origin server has no cache config or custom behaviour is desired.
    // Defaults to [null].
    maxStale: const Duration(days: 7),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.high,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended when [true].
    allowPostMethod: false,
  );

  final dio = Dio();

  NetworkService() {
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
    dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print,
        retries: 3,
        retryDelays: const [
          // set delays between retries (optional)
          Duration(seconds: 1), // wait 1 sec before first retry
          Duration(seconds: 2), // wait 2 sec before second retry
          Duration(seconds: 3), // wait 3 sec before third retry
        ],
      ),
    );
  }

  final Map<String, String> _requestHeaders = {
    HttpHeaders.acceptHeader: "application/json",
    "X-Requested-With": "XMLHttpRequest"
  };

  Future<Response<dynamic>> get(String url) async {
    _log.i("full url ${baseUrl + url}");
    var responseJson;
    final Response response;
    try {
      response = await dio
          .get(
            baseUrl + url,
            options: cacheOptions
                .copyWith(policy: CachePolicy.forceCache)
                .toOptions(),
          )
          .timeout(
            const Duration(seconds: 15),
          );

      // responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw TimeOutException('Connection timedout');
    }
    return response;
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
