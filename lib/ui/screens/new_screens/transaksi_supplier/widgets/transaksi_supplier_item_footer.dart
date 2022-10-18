import 'package:flutter/material.dart';
import 'package:marketplace/data/blocs/new_cubit/transaction/transaksi_upload_review_photo/transaksi_upload_review_photo_cubit.dart';
import 'package:marketplace/data/models/new_models/order.dart';
import 'package:marketplace/ui/screens/nav/new/transaksi/widgets/bs_transaksi_review.dart';
import 'package:marketplace/ui/widgets/filled_button.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:flutter_bloc/flutter_bloc.dart';

class TransaksiSupplierItemFooter extends StatelessWidget {
  const TransaksiSupplierItemFooter({
    Key key,
    @required this.item,
  }) : super(key: key);

  final OrderResponseData item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Harga", style: AppTypo.caption),
              Text(
                "${item.totalPrice}",
                style: AppTypo.caption
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        /*child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("560 232 7752", style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600)),
              Text("a/n PT.ADMA Digital Solusi", style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),*/
        _action(context, item),
      ],
    );
  }

  Widget _action(BuildContext context, OrderResponseData item){
    final status = item.status;
    if (status == "Menunggu Pembayaran"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("560 232 7752", style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600)),
          Text("a/n PT.ADMA Digital Solusi", style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600)),
        ],
      );
    } else if (status == "Selesai"){
      return FilledButton(
        onPressed: () {
          context
              .read<TransaksiUploadReviewPhotoCubit>()
              .initialization(1);
          BsTransaksiReview().showBsReview(context);
        },
        color: Theme.of(context).primaryColor,
        child: Text(
          "Beri Ulasan",
          style:
          AppTypo.caption.copyWith(color: Colors.white),
        ),
      );
    } else if (status == "Tiba di Tujuan"){
      return FilledButton(
        onPressed: () {},
        color: Theme.of(context).primaryColor,
        child: Text(
          "Pesanan Sampai",
          style:
          AppTypo.caption.copyWith(color: Colors.white),
        ),
      );
    } else {
      return FilledButton(
        onPressed: () {},
        color: AppColor.success,
        child: Text(
          "Lacak",
          style:
          AppTypo.caption.copyWith(color: Colors.white),
        ),
      );
    }
  }
}