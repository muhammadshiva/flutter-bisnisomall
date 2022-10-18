import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/data/blocs/bottom_nav/bottom_nav_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/order/add_order/add_order_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/order/order_with_saldo_panen/order_with_saldo_panen_cubit.dart';
import 'package:marketplace/data/blocs/new_cubit/order/order_with_saldo_panen_otp/order_with_saldo_panen_otp_bloc.dart';
import 'package:marketplace/data/blocs/new_cubit/recipent/fetch_selected_recipent/fetch_selected_recipent_cubit.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/data/repositories/repositories.dart';
import 'package:marketplace/ui/screens/new_screens/new_screens.dart';
import 'package:marketplace/ui/widgets/widgets.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:pin_code_fields/pin_code_fields.dart';

class PaymentSaldoPanenOtpScreen extends StatefulWidget {
  const PaymentSaldoPanenOtpScreen(
      {Key key, this.amountTake, this.isPayWithFullWallet, this.checkoutTemp})
      : super(key: key);

  final int amountTake;
  final bool isPayWithFullWallet;
  final CheckoutTemp checkoutTemp;

  @override
  State<PaymentSaldoPanenOtpScreen> createState() =>
      _PaymentSaldoPanenOtpScreenState();
}

class _PaymentSaldoPanenOtpScreenState
    extends State<PaymentSaldoPanenOtpScreen> {
  final recipentRepo = RecipentRepository();

  AddOrderCubit _addOrderCubit;
  OrderWithSaldoPanenCubit _orderWithSaldoPanenCubit;
  OrderWithSaldoPanenOtpBloc _orderWithSaldoPanenOtpBloc;
  FetchSelectedRecipentCubit _fetchSelectedRecipentCubit;

  // Timer _timer;

  int logId = 0;
  int confirmationCode = 0;
  int recipentId = 0;
  // int _start = 60;

  bool disableButton = true;

  @override
  void initState() {
    _orderWithSaldoPanenCubit = OrderWithSaldoPanenCubit()
      ..order(amount: widget.amountTake);
    _orderWithSaldoPanenOtpBloc = OrderWithSaldoPanenOtpBloc();
    _addOrderCubit = AddOrderCubit();
    _fetchSelectedRecipentCubit = FetchSelectedRecipentCubit()
      ..fetchSelectedRecipent();
    // _startTimer();
    super.initState();
  }

  // void _startTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) => setState(
  //       () {
  //         if (_start < 1) {
  //           timer.cancel();
  //         } else {
  //           _start = _start - 1;
  //         }
  //       },
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _orderWithSaldoPanenCubit.close();
    _orderWithSaldoPanenOtpBloc.close();
    _addOrderCubit.close();
    _fetchSelectedRecipentCubit.close();
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _orderWithSaldoPanenCubit,
        ),
        BlocProvider(
          create: (context) => _orderWithSaldoPanenOtpBloc,
        ),
        BlocProvider(
          create: (context) => _fetchSelectedRecipentCubit,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: _orderWithSaldoPanenCubit,
            listener: (context, state) {
              if (state is OrderWithSaldoPanenSuccess) {
                setState(() {
                  logId = state.data.id;
                });
              }
              if (state is OrderWithSaldoPanenFailure) {
                debugPrint(state.message);
              }
            },
          ),
          BlocListener<OrderWithSaldoPanenOtpBloc, OrderWithSaldoPanenOtpState>(
            listener: (context, state) {
              if (state is OrderWithSaldoPanenOtpSuccess) {
                if (widget.isPayWithFullWallet) {
                  LoadingDialog.show(context);
                  _addOrderCubit.addOrder(
                      itemId: widget.checkoutTemp.itemId,
                      recipientId: recipentId,
                      shippingCode: widget.checkoutTemp.shippingCode
                          .map((e) => e.shippingCode)
                          .toList(),
                      ongkir: widget.checkoutTemp.ongkir
                          .map((e) => e.ongkir)
                          .toList(),
                      note:
                          widget.checkoutTemp.note.map((e) => e.note).toList(),
                      verificationMethod: "manual",
                      paymentMethodId: 3,
                      walletLogId: state.data.id,
                      walletLogToken: state.data.token);
                } else {
                  AppExt.pushScreen(
                      context,
                      PaymentScreen(
                          checkoutTemp: widget.checkoutTemp,
                          isUseWallet: true,
                          walletLogId: state.data.id,
                          walletLogToken: state.data.token));
                }
              }
              if (state is OrderWithSaldoPanenOtpFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 1),
                      content: Text(state.message),
                    ),
                  );
              }
            },
          ),
          BlocListener(
              bloc: _addOrderCubit,
              listener: (context, state) {
                if (state is AddOrderSuccess) {
                  AppExt.popScreen(context);
                  AppExt.popUntilRoot(context);
                  BlocProvider.of<BottomNavCubit>(context).navItemTapped(2);
                  AppExt.pushScreen(
                      context,
                      PaymentDetailScreen(
                        orderData: state.data,
                        checkoutTemp: widget.checkoutTemp,
                        isFullWallet: true,
                      ));
                }
                if (state is AddOrderFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.grey[900],
                        duration: Duration(seconds: 1),
                        content: Text(state.message),
                      ),
                    );
                  debugPrint(state.message);
                }
              }),
          BlocListener(
            bloc: _fetchSelectedRecipentCubit,
            listener: (context, state) {
              if (state is FetchSelectedRecipentSuccess) {
                setState(() {
                  recipentId = state.recipent.id;
                });
              }
              if (state is FetchSelectedRecipentFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      margin: EdgeInsets.zero,
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                      content: Text(
                        "Terjadi Kesalahan",
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Verifikasi Pembayaran",
              style: AppTypo.subtitle2,
            ),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                AppExt.popScreen(context);
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Kode verifikasi (OTP) dikirim pada whatsapp anda",
                    style: AppTypo.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    length: 4,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    autoFocus: true,
                    onCompleted: (v) {
                      debugPrint("Completed $v");
                      setState(() {
                        disableButton = false;
                        confirmationCode = int.parse(v);
                      });
                    },
                    onChanged: (String value) {},
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<OrderWithSaldoPanenOtpBloc,
                      OrderWithSaldoPanenOtpState>(
                    builder: (context, state) {
                      return RoundedButton.contained(
                        label: "Lanjut",
                        isUpperCase: false,
                        disabled: disableButton,
                        isLoading: state is OrderWithSaldoPanenOtpLoading,
                        onPressed: () {
                          // AppExt.pushScreen(context, PaymentSuccessScreen(isFullWallet: true,));
                          _orderWithSaldoPanenOtpBloc.add(
                              OrderWithSaldoPanenOtpSubmitted(
                                  logId: logId,
                                  confirmationCode: confirmationCode));
                        },
                        color: Theme.of(context).primaryColor,
                      );
                    },
                  ),
                  // SizedBox(height: 20,),
                  // BlocBuilder<WithdrawWalletOtpBloc, WithdrawWalletOtpState>(
                  //   builder: (context, state) =>
                  //     state is WithdrawWalletOtpLoading
                  //         ? SizedBox.shrink()
                  //         : Center(
                  //             child: _start > 0
                  //                 ? Text(
                  //                     "Kirim Ulang dalam $_start detik",
                  //                     style: AppTypo.body2Accent,
                  //                     textAlign: TextAlign.center,
                  //                   )
                  //                 : InkWell(
                  //                     onTap: () {
                  //                       AppExt.hideKeyboard(context);
                  //                       _withdrawWalletOtpBloc.add(WithdrawWalletOtpResend(logId: widget.walletWithdrawData.logId));
                  //                       _start =60;
                  //                       _startTimer();
                  //                     },
                  //                     radius: 20,
                  //                     borderRadius: BorderRadius.circular(10),
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.symmetric(
                  //                           horizontal: 10.0),
                  //                       child: Text(
                  //                         "Kirim Ulang",
                  //                         style: AppTypo.button.copyWith(
                  //                             color: AppColor.success),
                  //                       ),
                  //                     ),
                  //                   ),
                  //           ),

                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
