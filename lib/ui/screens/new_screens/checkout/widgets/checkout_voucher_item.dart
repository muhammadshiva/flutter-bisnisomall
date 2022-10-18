import 'package:flutter/material.dart';
import 'package:marketplace/ui/screens/new_screens/voucher/voucher_screen.dart';
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/constants.dart' as AppConst;
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class CheckoutVoucherItem extends StatefulWidget {
  const CheckoutVoucherItem({Key key}) : super(key: key);

  @override
  State<CheckoutVoucherItem> createState() => _CheckoutVoucherItemState();
}

class _CheckoutVoucherItemState extends State<CheckoutVoucherItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Voucher Panen',
          style: AppTypo.subtitle1.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.line, width: 1),
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: ListTile(
                enabled: true,
                onTap: () {
                  AppExt.pushScreen(context, VoucherScreen());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.5),
                ),
                title: Text(
                  "Pilih Voucher",
                  style: AppTypo.body2.copyWith(
                    fontWeight:
                        // _selectedCourierId == null
                        //     ? FontWeight.w500
                        //     :
                        FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: null,
                trailing: Icon(Icons.chevron_right))),
      ],
    );
  }
}
