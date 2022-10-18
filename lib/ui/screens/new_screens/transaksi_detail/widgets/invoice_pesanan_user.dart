import 'package:flutter/material.dart';
import 'package:marketplace/data/models/new_models/order.dart';
import 'package:marketplace/ui/screens/new_screens/invoice/invoice_screen.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class InvoicePesananUser extends StatelessWidget {
  const InvoicePesananUser({
    Key key,
    @required this.data,
  }) : super(key: key);

  final OrderDetailResponseData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  data.transactionCode,
                  style: AppTypo.caption.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    AppExt.pushScreen(context, InvoiceScreen(data: data));
                  },
                  child: Text("Lihat Invoice",
                      style: AppTypo.caption.copyWith(
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline,
                      )),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nama Pemesanan",
                  style: AppTypo.caption,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(data.recipientName,
                    style: AppTypo.caption.copyWith(
                        fontWeight: FontWeight.w600
                    )),
              ),
            )
          ],
        ),
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tanggal Pemesanan",
                  style: AppTypo.caption,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(data.orderDate,
                    style: AppTypo.caption.copyWith(
                        fontWeight: FontWeight.w600
                    )),
              ),
            )
          ],
        ),
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tanggal Pengiriman",
                  style: AppTypo.caption,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(data.deliveryDate ?? "-",
                    style: AppTypo.caption.copyWith(
                        fontWeight: FontWeight.w600
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}