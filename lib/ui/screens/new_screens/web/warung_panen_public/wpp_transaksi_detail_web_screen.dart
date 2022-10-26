import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:marketplace/api/api.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/fetch_transaction_detail/fetch_transaction_detail_cubit.dart';
import 'package:marketplace/ui/screens/new_screens/web/warung_panen_public/widgets/transaction_detail/wpp_detail_pengiriman.dart';
import 'package:marketplace/ui/screens/new_screens/web/warung_panen_public/widgets/transaction_detail/wpp_detail_pesanan_list.dart';
import 'package:marketplace/ui/screens/new_screens/web/warung_panen_public/widgets/transaction_detail/wpp_ringkasan_pembayaran.dart';
import 'package:marketplace/ui/screens/new_screens/web/warung_panen_public/widgets/transaction_detail/wpp_status_pesanan_widget.dart';
import 'package:marketplace/ui/widgets/fetch_conditions.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;

class WppTransaksiDetailWebScreen extends StatefulWidget {
  const WppTransaksiDetailWebScreen({Key key, @required this.paymentId}) : super(key: key);

  final int paymentId;

  @override
  _WppTransaksiDetailWebScreenState createState() => _WppTransaksiDetailWebScreenState();
}

class _WppTransaksiDetailWebScreenState extends State<WppTransaksiDetailWebScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FetchTransactionDetailCubit>().fetchDetailWpp(paymentId: widget.paymentId);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints:
                BoxConstraints(maxWidth: !context.isPhone ? 450 : 1000),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Detail Pesanan",
              style: AppTypo.subtitle2,
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SafeArea(
            child: BlocBuilder<FetchTransactionDetailCubit,
                FetchTransactionDetailState>(
              builder: (context, state) {
                if (state is FetchTransactionDetailSuccess) {
                  final items = state.itemsNoAuth;
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WppStatusPesananWidget(infoOrder: items),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        WppDetailPesananList(
                          data: items,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        WppRingkasanPembayaran(
                          data: items,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // WppInvoicePesananUser(
                        //   data: items,
                        // ),
                        // Divider(
                        //   thickness: 1,
                        // ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // WppDetailPesananList(
                        //   data: items,
                        // ),
                        // Divider(
                        //   thickness: 1,
                        // ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // WppRingkasanPembayaran(
                        //   data: items,
                        // ),
                        // Divider(
                        //   thickness: 1,
                        // ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // WppDetailPengiriman(data: items)
                      ],
                    ),
                  );
                }
                if (state is FetchTransactionDetailFailure) {
                  return Center(
                    child: state.type == ErrorType.network
                        ? NoConnection(onButtonPressed: () {
                            context
                                .read<FetchTransactionDetailCubit>()
                                .fetchDetailWpp(paymentId: widget.paymentId);
                          })
                        : ErrorFetch(
                            message: state.message,
                            onButtonPressed: () {
                              context
                                .read<FetchTransactionDetailCubit>()
                                .fetchDetailWpp(paymentId: widget.paymentId);
                            },
                          ),
                  );
                }
                return Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
        ),
      ),
    );
  }
}
