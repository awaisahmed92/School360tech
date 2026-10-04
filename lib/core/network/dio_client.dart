import 'package:dio/dio.dart';

import '../config/app_config.dart';

typedef TokenProvider = Future<String?> Function();

class DioClient {
  DioClient({TokenProvider? tokenProvider})
      : _tokenProvider = tokenProvider,
        dio = Dio(
          BaseOptions(
            baseUrl: AppConfig.apiBaseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 25),
            headers: const {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_tokenProvider != null) {
            final token = await _tokenProvider!.call();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          handler.next(options);
        },
      ),
    );
  }

  final Dio dio;
  final TokenProvider? _tokenProvider;
}
