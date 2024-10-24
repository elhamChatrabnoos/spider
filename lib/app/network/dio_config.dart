import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/local_db.dart';
import 'api_addresses.dart';

class DioConfig {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiAddresses.baseUrl,
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 100),
    ),
  );

  DioConfig() {
    _dio.interceptors.add(
      InterceptorsWrapper(
          onRequest: (options, handler) async {
            if (options.uri.toString() ==
                '${ApiAddresses.baseUrl}api/v1/token/refresh/') {
              return handler.next(options);
            }
            // String? token = await LocalDb.getAccessToken();
            // if (token != null && token.isNotEmpty) {
            //   options.headers = {'Authorization': 'Bearer $token'};
            // }
            return handler.next(options);
          },
          onError: (DioException e, handler) async {
            if (e.response == null) {
              return handler.next(e);
            }
            if (e.response!.statusCode == 401 &&
                e.requestOptions.path != ApiAddresses.verifyOtp) {
              if (e.requestOptions.path == ApiAddresses.refreshToken) {
                await LocalDb.deleteAccessToken();
                await LocalDb.deleteRefreshToken();
                return;
              } else if (e.requestOptions.path == ApiAddresses.login) {
                return handler.next(e);
              } else {
                await _resendLastRequest(e, handler);
                return;
              }
            }

            return handler.next(e);
          },
          onResponse: (response, handler) => handler.next(response)),
    );
    _dio.interceptors.add(PrettyDioLogger(requestHeader: true));
  }

  _resendLastRequest(DioException e, ErrorInterceptorHandler handler) async {
    String? newAccessToken = await refreshToken();

    if (newAccessToken != null) {
      try {
        e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      } catch (error) {
        if (error is DioException) {
          return handler.reject(error);
        }
        return handler.reject(e);
      }
    }
    return null;
  }

  Future<String?> refreshToken() async {
    String? newToken;

    // String? currentRefreshToken = await LocalDb.getRefreshToken();
    // AccountRepository accountRepository = AccountRepository();
    // if (currentRefreshToken != null) {
    //   final result = await accountRepository.refreshToken(
    //       tokenRefresh: currentRefreshToken);
    //   if (result is ResponseSuccess) {
    //     newToken = result.data!.data!.access;
    //     await LocalDb.saveAccessToken(newToken ?? '');
    //     return newToken;
    //   }
    // }
    return newToken;
  }

  Dio get dio => _dio;
}
