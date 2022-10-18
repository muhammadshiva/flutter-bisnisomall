part of 'order_with_saldo_panen_otp_bloc.dart';

abstract class OrderWithSaldoPanenOtpState extends Equatable {
  const OrderWithSaldoPanenOtpState();
  
  @override
  List<Object> get props => [];
}

class OrderWithSaldoPanenOtpInitial extends OrderWithSaldoPanenOtpState {}

class OrderWithSaldoPanenOtpLoading extends OrderWithSaldoPanenOtpState {}

class OrderWithSaldoPanenOtpSuccess extends OrderWithSaldoPanenOtpState {
  OrderWithSaldoPanenOtpSuccess(this.data);

  final WalletPayment data;

  @override
  List<Object> get props => [data];
}

class OrderWithSaldoPanenOtpFailure extends OrderWithSaldoPanenOtpState {
  final ErrorType type;
  final String message;

  OrderWithSaldoPanenOtpFailure({this.type = ErrorType.general, this.message});

  OrderWithSaldoPanenOtpFailure.network(String message)
      : this(type: ErrorType.network, message: message);

  OrderWithSaldoPanenOtpFailure.general(String message)
      : this(type: ErrorType.general, message: message);

  @override
  List<Object> get props => [type, message];
}

class WithdrawWalletResendOtpLoading extends OrderWithSaldoPanenOtpState {}

class WithdrawWalletResendOtpSuccess extends OrderWithSaldoPanenOtpState {}

class WithdrawWalletResendOtpFailure extends OrderWithSaldoPanenOtpState {
  final ErrorType type;
  final String message;

  WithdrawWalletResendOtpFailure({this.type = ErrorType.general, this.message});

  WithdrawWalletResendOtpFailure.network(String message)
      : this(type: ErrorType.network, message: message);

  WithdrawWalletResendOtpFailure.general(String message)
      : this(type: ErrorType.general, message: message);

  @override
  List<Object> get props => [type, message];
}
