import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/order_repository.dart';

part 'order_with_saldo_panen_state.dart';

class OrderWithSaldoPanenCubit extends Cubit<OrderWithSaldoPanenState> {
  OrderWithSaldoPanenCubit() : super(OrderWithSaldoPanenInitial());

  final OrderRepository _orderRepository = OrderRepository();

  Future<void> order({
    @required int amount,
  }) async {
    emit(OrderWithSaldoPanenLoading());
    try {
      final response = await _orderRepository.orderWithSaldoPanen(amount: amount);
      emit(OrderWithSaldoPanenSuccess(response.data));
    } catch (error) {
      if (error is NetworkException) {
        emit(OrderWithSaldoPanenFailure.network(error.toString()));
        return;
      }
      emit(OrderWithSaldoPanenFailure.general(error.toString()));
    }
  }

}
