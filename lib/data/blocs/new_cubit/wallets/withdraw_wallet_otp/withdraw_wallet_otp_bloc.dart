import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/repositories/new_repositories/wallet_repository.dart';

part 'withdraw_wallet_otp_event.dart';
part 'withdraw_wallet_otp_state.dart';

class WithdrawWalletOtpBloc
    extends Bloc<WithdrawWalletOtpEvent, WithdrawWalletOtpState> {
  WithdrawWalletOtpBloc() : super(WithdrawWalletOtpInitial()) {
    on<WithdrawWalletOtpEvent>(onWithdrawWalletOtp);
  }

  final WalletRepository _walletRepository = WalletRepository();

  onWithdrawWalletOtp(WithdrawWalletOtpEvent event,
      Emitter<WithdrawWalletOtpState> emit) async {
    if (event is WithdrawWalletOtpSubmitted) {
      emit(WithdrawWalletOtpLoading());
      try {
        final response = await _walletRepository.withdrawWalletConfirmation(
            logId: event.logId, confirmationCode: event.confirmationCode);
        emit(WithdrawWalletOtpSuccess());
      } catch (error) {
        if (error is NetworkException) {
          emit(WithdrawWalletOtpFailure.network(error.toString()));
          return;
        }
        emit(WithdrawWalletOtpFailure.general(error.toString()));
      }
    } else if (event is WithdrawWalletOtpResend) {
      emit(WithdrawWalletResendOtpLoading());
      try {
        final response =
            await _walletRepository.withdrawWalletResendOTP(logId: event.logId);
        emit(WithdrawWalletResendOtpSuccess());
      } catch (error) {
        if (error is NetworkException) {
          emit(WithdrawWalletOtpFailure.network(error.toString()));
          return;
        }
        emit(WithdrawWalletOtpFailure.general(error.toString()));
      }
    }
  }
}
