part of 'order_with_saldo_panen_otp_bloc.dart';

abstract class OrderWithSaldoPanenOtpEvent extends Equatable {
  const OrderWithSaldoPanenOtpEvent();

  @override
  List<Object> get props => [];
}

class OrderWithSaldoPanenOtpSubmitted extends OrderWithSaldoPanenOtpEvent {
  const OrderWithSaldoPanenOtpSubmitted({@required this.logId, @required this.confirmationCode});

  final int logId;
  final int confirmationCode;

  @override
  List<Object> get props => [logId, confirmationCode];
}
