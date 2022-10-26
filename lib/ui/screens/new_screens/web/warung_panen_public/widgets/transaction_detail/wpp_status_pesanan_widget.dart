import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:marketplace/data/models/new_models/order.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class WppStatusPesananWidget extends StatelessWidget {
  final WppOrderDetailResponseData infoOrder;

  const WppStatusPesananWidget({Key key, @required this.infoOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kode Transaksi",
                  style: AppTypo.caption,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(infoOrder.transactionCode,
                    style: AppTypo.subtitle2
                        .copyWith(color: Theme.of(context).primaryColor)),
              ],
            ),
            TextButton(
              onPressed: () {
                context.beamToNamed(
                    // '/wpp/invoicedetailorder/?dt=${AppExt.encryptMyData(jsonEncode(infoOrder))}'
                    '/wpp/invoicedetailorder/${infoOrder.id}'
                  );
              },
              child: Text("Lihat Invoice",
                  style: AppTypo.caption.copyWith(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama Penerima",
              style: AppTypo.caption,
            ),
            Text(infoOrder.recipientName,
                style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600))
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Alamat Pengiriman",
              style: AppTypo.caption,
            ),
            Text(infoOrder.recipientAddress ?? '-',
                style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
