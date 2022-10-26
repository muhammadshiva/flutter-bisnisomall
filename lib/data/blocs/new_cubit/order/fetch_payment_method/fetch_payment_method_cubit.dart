import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/order_repository.dart';
import 'package:marketplace/data/repositories/repositories.dart';

import '../../../../repositories/new_repositories/transaction_repository.dart';

part 'fetch_payment_method_state.dart';

class FetchPaymentMethodCubit extends Cubit<FetchPaymentMethodState> {
  FetchPaymentMethodCubit() : super(FetchPaymentMethodInitial());

  final TransactionRepository _transactionRepo = TransactionRepository();

  Future<void> load() async {
    emit(FetchPaymentMethodLoading());
    try {
      final response = await _transactionRepo.fetchPaymentMethod();
      emit(FetchPaymentMethodSuccess(response.data));
    } catch (error) {
      emit(FetchPaymentMethodFailure(error.toString()));
    }
  }
}
