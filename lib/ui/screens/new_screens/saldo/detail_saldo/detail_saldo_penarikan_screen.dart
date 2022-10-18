import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/data/blocs/new_cubit/wallets/fetch_wallet_detail/fetch_wallet_detail_cubit.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class DetailSaldoPenarikanScreen extends StatefulWidget {
  const DetailSaldoPenarikanScreen({Key key, this.logId}) : super(key: key);

  final int logId;

  @override
  State<DetailSaldoPenarikanScreen> createState() =>
      _DetailSaldoPenarikanScreenState();
}

class _DetailSaldoPenarikanScreenState
    extends State<DetailSaldoPenarikanScreen> {
  FetchWalletDetailCubit _fetchWalletDetailCubit;

  @override
  void initState() {
    _fetchWalletDetailCubit = FetchWalletDetailCubit()
      ..fetchWalletDetailWithdrawal(historyId: widget.logId);
    super.initState();
  }

  @override
  void dispose() {
    _fetchWalletDetailCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => _fetchWalletDetailCubit,
      child: Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Detail Transaksi",
            style: AppTypo.subtitle2,
          ),
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
        body: BlocBuilder(
          bloc: _fetchWalletDetailCubit,
          builder: (context, state) => state is FetchWalletDetailLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : state is FetchWalletDetailFailure
                  ? Center(
                      child: Text("Terjadi kesalahan!"),
                    )
                  : state is FetchWalletDetailSuccess
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: _screenWidth * (5 / 100),
                                vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //   height: 15,
                                // ),

                                Material(
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: _screenWidth,
                                    // padding: EdgeInsets.symmetric(
                                    //     horizontal: _screenWidth * (5/100), vertical: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Center(
                                          child: state.walletWithdrawal.status
                                                      .toLowerCase() ==
                                                  "pending"
                                              ? Icon(
                                                  Icons.access_time_outlined,
                                                  color: Colors.orange,
                                                  size: 40,
                                                )
                                              : Icon(
                                                  Icons.check_circle,
                                                  color: AppColor.primary,
                                                  size: 40,
                                                ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          state.walletWithdrawal.status,
                                          style: AppTypo.body2Lato.copyWith(
                                              color: AppColor.inactiveSwitch),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "- ${state.walletWithdrawal.amount}",
                                          style: AppTypo.subtitle1.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                Material(
                                  color: Colors.white,
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: _screenWidth * (5 / 100),
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rincian Transaksi",
                                          style: AppTypo.subtitle2.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Nama",
                                                  style: AppTypo.body2Lato
                                                      .copyWith(
                                                          color:
                                                              Color(0xFFABABAF),
                                                          fontSize: 14)),
                                              Text(
                                                  state.walletWithdrawal
                                                      .accountName,
                                                  style:
                                                      AppTypo.LatoBold.copyWith(
                                                    fontSize: 14,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Bank",
                                                  style: AppTypo.body2Lato
                                                      .copyWith(
                                                          color:
                                                              Color(0xFFABABAF),
                                                          fontSize: 14)),
                                              Text(
                                                  state.walletWithdrawal
                                                      .paymentMethod,
                                                  style:
                                                      AppTypo.LatoBold.copyWith(
                                                    fontSize: 14,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("No. Rekening",
                                                  style: AppTypo.body2Lato
                                                      .copyWith(
                                                          color:
                                                              Color(0xFFABABAF),
                                                          fontSize: 14)),
                                              Text(
                                                  state.walletWithdrawal
                                                      .accountNumber,
                                                  style:
                                                      AppTypo.LatoBold.copyWith(
                                                    fontSize: 14,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Total Penarikan",
                                                  style: AppTypo.body2Lato
                                                      .copyWith(
                                                          color:
                                                              Color(0xFFABABAF),
                                                          fontSize: 14)),
                                              Text(
                                                  "Rp " +
                                                      AppExt.toRupiah(
                                                        int.parse(state
                                                            .walletWithdrawal
                                                            .amount),
                                                      ),
                                                  style:
                                                      AppTypo.LatoBold.copyWith(
                                                    fontSize: 14,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Waktu Transaksi",
                                                  style: AppTypo.body2Lato
                                                      .copyWith(
                                                          color:
                                                              Color(0xFFABABAF),
                                                          fontSize: 14)),
                                              Text(state.walletWithdrawal.date,
                                                  style:
                                                      AppTypo.LatoBold.copyWith(
                                                    fontSize: 14,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
        ),
      ),
    );
  }
}
