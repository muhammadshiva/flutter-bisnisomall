import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/models/new_models/order.dart';
import 'package:marketplace/data/repositories/order_repository.dart';

part 'fetch_invoice_by_order_state.dart';

class FetchInvoiceByOrderCubit extends Cubit<FetchInvoiceByOrderState> {
  FetchInvoiceByOrderCubit() : super(FetchInvoiceByOrderInitial());

  final OrderRepository _repo = OrderRepository();

  Future<void> load({int orderId}) async {
    emit(FetchInvoiceByOrderLoading());
    try {
      final response = await _repo.fetchInvoiceByOrder(orderId: orderId);
      emit(FetchInvoiceByOrderSuccess(response.data));
    } catch (error) {
      if (error is NetworkException) {
        emit(FetchInvoiceByOrderFailure.network(error.toString()));
        return;
      }
      emit(FetchInvoiceByOrderFailure.general(error.toString()));
    }
  }
}
