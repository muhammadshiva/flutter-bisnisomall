import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/data/models/new_models/wallets.dart';
import 'package:marketplace/data/repositories/order_repository.dart';
import 'package:marketplace/data/repositories/repositories.dart';

part 'order_with_saldo_panen_otp_event.dart';
part 'order_with_saldo_panen_otp_state.dart';

class OrderWithSaldoPanenOtpBloc
    extends Bloc<OrderWithSaldoPanenOtpEvent, OrderWithSaldoPanenOtpState> {
  OrderWithSaldoPanenOtpBloc() : super(OrderWithSaldoPanenOtpInitial()) {
    on<OrderWithSaldoPanenOtpEvent>(onOrderWithSaldoPanenOtp);
  }

  final OrderRepository _orderRepository = OrderRepository();

  onOrderWithSaldoPanenOtp(OrderWithSaldoPanenOtpEvent event,
      Emitter<OrderWithSaldoPanenOtpState> emit) async {
    if (event is OrderWithSaldoPanenOtpSubmitted) {
      emit(OrderWithSaldoPanenOtpLoading());
      try {
        final response = await _orderRepository.orderWithSaldoPanenConfirmation(
            logId: event.logId, confirmationCode: event.confirmationCode);
        emit(OrderWithSaldoPanenOtpSuccess(response.data));
      } catch (error) {
        if (error is NetworkException) {
          emit(OrderWithSaldoPanenOtpFailure.network(error.toString()));
          return;
        }
        emit(OrderWithSaldoPanenOtpFailure.general(error.toString()));
      }
    }
  }
}
