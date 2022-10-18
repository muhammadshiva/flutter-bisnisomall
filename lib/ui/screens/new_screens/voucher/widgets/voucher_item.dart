import 'package:flutter/material.dart';
import 'package:marketplace/ui/screens/new_screens/voucher/voucher_detail_screen.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class VoucherItem extends StatelessWidget {
  const VoucherItem({
    Key key,
    @required this.name,
    this.isChosen = false,
    this.isExpired = false, this.circleColor, this.onlyShowVoucher = false,
  }) : super(key: key);

  final String name;
  final bool isChosen;
  final bool isExpired;
  final Color circleColor;
  final bool onlyShowVoucher;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColor.silverFlashSale)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          "images/img_logo_placeholder.jpg",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          name,
                          style: AppTypo.subtitle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: !isExpired ? Colors.black : Colors.grey),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 3,
                        child: !isExpired
                            ? Container(
                                width: 25,
                                height: 25,
                                decoration: isChosen
                                    ? null
                                    : BoxDecoration(
                                        border: Border.all(color: Color(0xFFBEBEBE)),
                                        shape: BoxShape.circle),
                                child: isChosen
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      )
                                    : SizedBox(),
                              )
                            : SizedBox(),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Text(
                          "Berakhir dalam 8 jam lagi",
                          style: AppTypo.caption.copyWith(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: 
                        onlyShowVoucher ?
                        SizedBox()
                        :
                        TextButton(
                          onPressed: () {
                            AppExt.pushScreen(context, VoucherDetailScreen());
                          },
                          child: Text("S&K",
                              style: AppTypo.caption.copyWith(
                                  color: !isExpired ? Colors.red : Colors.grey)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: -8,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: circleColor ?? Colors.white, 
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.silverFlashSale)),
            )),
            Positioned(
              bottom: 50,
            right: -8,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: circleColor ?? Colors.white, 
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.silverFlashSale)),
            )),
        ],
      ),
    );
  }
}
