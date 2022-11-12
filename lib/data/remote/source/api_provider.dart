import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'api_request_representable.dart';
import 'exceptions.dart';

class APIProvider {
  static const requestTimeOut = Duration(seconds: 25);
  final _client = GetConnect(timeout: requestTimeOut);
  final Logger logger = Logger();
  Future request(APIRequestRepresentable request) async {
    try {
      logger.d(request.url+request.query.toString());
      final response = await _client.request(
        request.url,
        request.method.string,
        headers: request.headers,
        query: request.query,
        body: request.body,
      );
      logger.d(response.statusCode);
      logger.d(response.headers);
      logger.d(response.body);
      return _returnResponse(response);
    } on TimeoutException catch (e) {
      logger.d(e.message);
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw BadRequestException('Not found');
      case 500:
        throw FetchDataException('Internal Server Error');
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : '
            '${response.statusCode}');
    }
  }
}
