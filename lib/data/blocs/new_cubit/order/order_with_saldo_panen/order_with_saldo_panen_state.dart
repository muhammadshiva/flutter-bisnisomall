part of 'order_with_saldo_panen_cubit.dart';

abstract class OrderWithSaldoPanenState extends Equatable {
  const OrderWithSaldoPanenState();

  @override
  List<Object> get props => [];
}

class OrderWithSaldoPanenInitial extends OrderWithSaldoPanenState {}

class OrderWithSaldoPanenLoading extends OrderWithSaldoPanenState {}

class OrderWithSaldoPanenSuccess extends OrderWithSaldoPanenState {
  OrderWithSaldoPanenSuccess(this.data);

  final WalletPayment data;

  @override
  List<Object> get props => [data];
}

class OrderWithSaldoPanenFailure extends OrderWithSaldoPanenState {
  final ErrorType type;
  final String message;

  OrderWithSaldoPanenFailure({this.type = ErrorType.general, this.message});

  OrderWithSaldoPanenFailure.network(String message)
      : this(type: ErrorType.network, message: message);

  OrderWithSaldoPanenFailure.general(String message)
      : this(type: ErrorType.general, message: message);

  @override
  List<Object> get props => [type, message];
}
