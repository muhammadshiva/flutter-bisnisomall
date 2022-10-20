import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:marketplace/data/models/new_models/order.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;

import 'wpp_detail_pesanan_item.dart';

class WppDetailPesananList extends StatelessWidget {
  const WppDetailPesananList({
    Key key,
    @required this.data,
  }) : super(key: key);

  final WppOrderDetailResponseData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < data.orders.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Pesanan ${i + 1}",
                style: AppTypo.subtitle1.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status",
                        style: AppTypo.caption,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(data.orders[i].status,
                          style: AppTypo.subtitle2
                              .copyWith(color: Theme.of(context).primaryColor)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // AppExt.pushScreen(context, TransaksiStatusPesananScreen(orderId: orderId));
                      context.beamToNamed('/wpp/trackingorder/${data.orders[i].id}');
                    },
                    child: Text("Lihat Status",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nama Supplier",
                        style: AppTypo.caption,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(data.orders[i].sellerName ?? '-',
                          style: AppTypo.caption
                              .copyWith(fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Alamat Supplier",
                        style: AppTypo.caption,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(data.orders[i].sellerAddress ?? '-',
                          style: AppTypo.caption
                              .copyWith(fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text("Detail Pengiriman",
                  style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600)),
              SizedBox(
                height: 8,
              ),
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
                      child: Text(data.orders[i].orderDate,
                          style: AppTypo.caption
                              .copyWith(fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
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
                      child: Text(data.orders[i].deliveryDate ?? '-',
                          style: AppTypo.caption
                              .copyWith(fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Kurir Pengiriman",
                        style: AppTypo.caption,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(data.orders[i].courier ?? '-',
                          style: AppTypo.caption
                              .copyWith(fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "No. Resi",
                        style: AppTypo.caption,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(data.orders[i].airwayBill ?? '-',
                          style: AppTypo.caption
                              .copyWith(fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text("Produk yang dibeli :",
                  style: AppTypo.caption.copyWith(fontWeight: FontWeight.w600)),
              SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var j = 0; j < data.orders[i].products.length; j++)
                    WppDetailPesananItem(
                      image: data.orders[i].products[j].cover,
                      itemName: data.orders[i].products[j].name,
                      qtyItem:
                          "${data.orders[i].products[j].quantity}x ${data.orders[i].products[j].price} ",
                    ),
                  Text(
                    "Catatan: ${data.orders[i].note ?? ""}",
                    style: AppTypo.caption.copyWith(color: Colors.grey),
                  ),
                   SizedBox(height: 10,)
                ],
              )
            ],
          ),
       
      ],
    );
  }
}
