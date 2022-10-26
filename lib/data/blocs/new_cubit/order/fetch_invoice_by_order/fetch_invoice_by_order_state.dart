part of 'fetch_invoice_by_order_cubit.dart';

abstract class FetchInvoiceByOrderState extends Equatable {
  const FetchInvoiceByOrderState();

  @override
  List<Object> get props => [];
}

class FetchInvoiceByOrderInitial extends FetchInvoiceByOrderState {}

class FetchInvoiceByOrderLoading extends FetchInvoiceByOrderState {}

class FetchInvoiceByOrderSuccess extends FetchInvoiceByOrderState {
  FetchInvoiceByOrderSuccess(this.data);

  final InvoiceByOrder data;

  @override
  List<Object> get props => [data];
}

class FetchInvoiceByOrderFailure extends FetchInvoiceByOrderState {
  final ErrorType type;
  final String message;

  FetchInvoiceByOrderFailure({this.type = ErrorType.general, this.message});

  FetchInvoiceByOrderFailure.network(String message)
      : this(type: ErrorType.network, message: message);

  FetchInvoiceByOrderFailure.general(String message)
      : this(type: ErrorType.general, message: message);

  @override
  List<Object> get props => [type, message];
}
