import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/new_repositories/transaction_repository.dart';
import 'package:marketplace/data/repositories/order_repository.dart';
import 'package:marketplace/data/repositories/repositories.dart';

part 'change_payment_method_state.dart';

class ChangePaymentMethodCubit extends Cubit<ChangePaymentMethodState> {
  ChangePaymentMethodCubit() : super(ChangePaymentMethodInitial());

  final TransactionRepository _transactionRepo = TransactionRepository();

  Future<void> changePaymentMethod(
      {@required int paymentId, @required int paymentMethodId}) async {
    emit(ChangePaymentMethodLoading());
    try {
      await Future.delayed(Duration(milliseconds: 300));
      var response = await _transactionRepo.changePaymentMethod(
          paymentId: paymentId, paymentMethodId: paymentMethodId);
      emit(ChangePaymentMethodSuccess(response.data));
    } catch (error) {
      emit(ChangePaymentMethodFailure(error.toString()));
    }
  }
}
