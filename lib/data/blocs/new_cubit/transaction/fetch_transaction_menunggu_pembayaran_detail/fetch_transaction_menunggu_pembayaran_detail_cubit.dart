import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/new_models/order.dart';
import 'package:marketplace/data/repositories/new_repositories/transaction_repository.dart';
import 'package:meta/meta.dart';

import '../../../../models/payment.dart';

part 'fetch_transaction_menunggu_pembayaran_detail_state.dart';

class FetchTransactionMenungguPembayaranDetailCubit
    extends Cubit<FetchTransactionMenungguPembayaranDetailState> {
  FetchTransactionMenungguPembayaranDetailCubit()
      : super(FetchTransactionMenungguPembayaranDetailInitial());

  final TransactionRepository _repository = TransactionRepository();

  Future<void> fetchDetail({@required int paymentId}) async {
    emit(FetchTransactionMenungguPembayaranDetailLoading());
    try {
      debugPrint("id $paymentId");
      final response =
          await _repository.fetchPaymentDetail(paymentId: paymentId);
      emit(FetchTransactionMenungguPembayaranDetailSuccess(response.data));
    } catch (error) {
      if (error is NetworkException) {
        emit(FetchTransactionMenungguPembayaranDetailFailure.network(
            error.toString()));
        return;
      }
      emit(FetchTransactionMenungguPembayaranDetailFailure.general(
          error.toString()));
    }
  }
}
