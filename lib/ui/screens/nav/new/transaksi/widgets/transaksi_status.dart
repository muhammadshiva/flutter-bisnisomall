import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:marketplace/data/models/new_models/ticker.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class TransaksiStatus extends StatelessWidget {
  const TransaksiStatus(
      {Key key,
      @required this.label,
      @required this.kode,
      @required this.nama,
      @required this.orderDate,
      this.isPembayaran = false})
      : super(key: key);

  final bool isPembayaran;
  final String label;
  final String kode;
  final String nama;
  final DateTime orderDate;

  @override
  Widget build(BuildContext context) {
    debugPrint("Status Kode: " + this.kode);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: _statusColor(context, label),
          ),
          width: 5,
          height: 50,
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 10,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypo.caption.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  kode,
                  style: AppTypo.caption.copyWith(color: Colors.grey),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  nama ?? '',
                  style: AppTypo.caption.copyWith(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isPembayaran,
          child: Container(
            margin: EdgeInsets.only(right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Batas Transfer',
                  style: AppTypo.caption.copyWith(color: AppColor.grey),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 9, right: 9, top: 3, bottom: 3),
                  decoration: BoxDecoration(
                      color: AppColor.bgBadgeLightGreen,
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        EvaIcons.clockOutline,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      StreamBuilder<int>(
                        stream: Ticker().tick(ticks: _duration(orderDate)),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final duration = snapshot.data;
                            final hoursStr = ((duration / 3600) % 60)
                                .floor()
                                .toString()
                                .padLeft(2, '0');
                            final minutesStr = ((duration / 60) % 60)
                                .floor()
                                .toString()
                                .padLeft(2, '0');
                            final secondsStr = (duration % 60)
                                .floor()
                                .toString()
                                .padLeft(2, '0');
                            return Text(
                              "$hoursStr:$minutesStr:$secondsStr",
                              style: AppTypo.caption.copyWith(
                                  color: Theme.of(context).primaryColor),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  int _duration(DateTime orderDate) {
    final expired = orderDate.add(const Duration(days: 1));
    final now = DateTime.now();
    final diff = expired.difference(now);
    return diff.inSeconds;
  }

  Color _statusColor(BuildContext context, String status) {
    if (status == "Dibatalkan" || status == "Tidak Berhasil") {
      return Colors.red;
    }
    if (status == "Selesai" || status == "Sampai Tujuan") {
      return AppColor.primary;
    }
    return Colors.orange;
  }
}
