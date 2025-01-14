import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

/// This interceptor add "Authorization" header and then, send it to the [API]
class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // adds the access-token with the header

    options.headers['x-rapidapi-key'] = FlutterConfig.get('RAPID_API_KEY');
    handler.next(options); // continue with the request
  }
}
