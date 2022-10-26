import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/general.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/models/new_models/order.dart';
import 'package:marketplace/data/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';
import 'package:marketplace/utils/constants.dart' as AppConst;

class TransactionRepository {
  final ApiProvider _provider = ApiProvider();
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  final String _adsKey = AppConst.API_ADS_KEY;
  final String _baseUrl = AppConst.API_URL;
  final gs = GetStorage();

  Dio dio = new Dio();

  Future<OrderResponse> fetchTransactions() async {
    final token = await _authenticationRepository.getToken();
    final response = await _provider.get("/order", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': _adsKey
    });
    return OrderResponse.fromJson(response);
  }

  Future<OrderResponse> fetchTransactionsWithoutBaseurl(String url) async {
    final token = await _authenticationRepository.getToken();
    final response = await _provider.getWithoutBaseurl(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': _adsKey
    });
    return OrderResponse.fromJson(response);
  }

  Future<OrderMenungguPembayaran> fetchMenungguPembayaranTransactions() async {
    final token = await _authenticationRepository.getToken();
    final response = await _provider.get("/payment?status=1", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': _adsKey
    });
    return OrderMenungguPembayaran.fromJson(response);
  }

  Future<OrderResponse> fetchFilterTransactions(
      {String status, String dateFrom, String dateTo, String kategori}) async {
    final token = await _authenticationRepository.getToken();
    debugPrint(
        "/order?status=$status&category_id=$kategori&start_date=$dateFrom&end_date=$dateTo");
    final response = await _provider.get(
        "/order?status=$status&category_id=$kategori&start_date=$dateFrom&end_date=$dateTo",
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          'ADS-Key': _adsKey
        });
    return OrderResponse.fromJson(response);
  }

  Future<OrderResponse> fetchSupplierTransactions() async {
    try {
      final token = await _authenticationRepository.getToken();
      final response = await _provider.get("/supplier/orders", headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
        'ADS-Key': _adsKey
      });
      return OrderResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }

  Future<OrderResponse> fetchFilterSupplierTransactions(
      {String status, String dateFrom, String dateTo}) async {
    final token = await _authenticationRepository.getToken();
    final response = await _provider.get(
        "/supplier/orders?status=$status&start_date=$dateFrom&end_date=$dateTo",
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          'ADS-Key': _adsKey
        });
    return OrderResponse.fromJson(response);
  }

  Future<OrderDetailResponse> fetchOrderDetail({@required int orderId}) async {
    final token = await _authenticationRepository.getToken();
    final response = await _provider.get("/order/detail/$orderId", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': _adsKey
    });
    return OrderDetailResponse.fromJson(response, false);
  }

  Future<OrderDetailResponse> fetchOrderDetailNoAuth(
      {@required int paymentId}) async {
    final response = await _provider.get("/order/noauth/detail/$paymentId",
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'ADS-Key': _adsKey
        });
    return OrderDetailResponse.fromJson(response, true);
  }

  Future<OrderDetailSupplierResponse> fetchProductSupplierDetail(
      {@required int orderId}) async {
    final token = await _authenticationRepository.getToken();
    final response = await _provider.get("/supplier/orders/$orderId", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': _adsKey
    });
    return OrderDetailSupplierResponse.fromJson(response);
  }

  Future<OrderDetailMenungguPembayaranResponse> fetchPaymentDetail(
      {@required int paymentId}) async {
    final token = await _authenticationRepository.getToken();
    final response = await _provider.get("/payment/$paymentId", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': _adsKey
    });
    return OrderDetailMenungguPembayaranResponse.fromJson(response);
  }

  Future<OrderMenungguPembayaran> deleteExpired(
      {@required List<int> paymentId}) async {
    final token = await _authenticationRepository.getToken();

    final Map<String, dynamic> body = {
      'payment_id': paymentId,
    };
    final response = await _provider
        .post("/payment/cancel", body: jsonEncode(body), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': _adsKey
    });
    return OrderMenungguPembayaran.fromJson(response);
  }

  Future<PaymentMethodResponse> fetchPaymentMethod() async {
    final token = await _authenticationRepository.getToken();

    final response = await _provider.get("/payment/show/method", headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      'ADS-Key': _adsKey
    });
    return PaymentMethodResponse.fromJson(response);
  }

  Future<GeneralOrderResponse> changePaymentMethod({
    @required int paymentId,
    @required int paymentMethodId,
  }) async {
    var formData = new FormData.fromMap({
      "payment_method_id": paymentMethodId,
    });
    final token = await _authenticationRepository.getToken();
    var response = await dio.post(
      "$_baseUrl/payment/change/$paymentId",
      data: formData,
      options: Options(headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
        'ADS-Key': _adsKey
      }, validateStatus: (status) => true),
    );

    // debugPrint("status code ${response.statusCode}");
    debugPrint("response $response");

    if (response.statusCode == 200) {
      final statusCode = response.data['status'];
      final message = response.data['message'] ?? 'Terjadi Kesalahan';

      return GeneralOrderResponse.fromJson(response.data);
    } else {
      debugPrint("myresponse ${response}");
      throw GeneralException(response.data.toString());
    }
  }

  void setPaymentCheck({
    @required bool value,
  }) {
    gs.write("paymentCheck", value);
  }

  void setPaymentDetailCheck({
    @required bool value,
  }) {
    gs.write("paymentDetailCheck", value);
  }

  bool getPaymentCheck() {
    return gs.read('paymentCheck') ?? false;
  }

  bool getPaymentDetailCheck() {
    return gs.read('paymentDetailCheck') ?? false;
  }
}
