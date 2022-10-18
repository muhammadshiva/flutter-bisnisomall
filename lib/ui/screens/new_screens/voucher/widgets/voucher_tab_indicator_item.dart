import 'package:flutter/material.dart';
import 'package:marketplace/utils/Colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;

class VoucherTabIndicatorItem extends StatefulWidget {
  const VoucherTabIndicatorItem({ Key key, this.onTap }) : super(key: key);

  final Function(int indexTabItem) onTap;

  @override
  State<VoucherTabIndicatorItem> createState() => _VoucherTabIndicatorItemState();
}

class _VoucherTabIndicatorItemState extends State<VoucherTabIndicatorItem> {

  // final List<String> tabItem = [
  //   'Kupon Saya','Kupon Toko','Belum Bisa Dipakai'
  // ];

  int indexTabItem = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  indexTabItem = 0;
                });
                widget.onTap(0);
              },
              child: Container(
                child: Center(
                  child: Text("Kupon Saya",style: AppTypo.body1Lato.copyWith(fontWeight: FontWeight.bold,color: indexTabItem == 0 ? AppColor.primary : Colors.black),),
                ),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: indexTabItem == 0 ? AppColor.primary : Colors.white,width: 2))
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  indexTabItem = 1;
                });
                widget.onTap(1);
              },
              child: Container(
                child: Center(
                  child: Text("Kupon Toko",style: AppTypo.body1Lato.copyWith(fontWeight: FontWeight.bold,color: indexTabItem == 1 ? AppColor.primary : Colors.black)),
                ),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: indexTabItem == 1 ? AppColor.primary : Colors.white,width: 2))
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  indexTabItem = 2;
                });
                widget.onTap(2);
              },
              child: Container(
                child: Center(
                  child: Text("Belum Bisa Dipakai",style: AppTypo.body1Lato.copyWith(fontWeight: FontWeight.bold,color: indexTabItem == 2 ? AppColor.primary : Colors.black)),
                ),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: indexTabItem == 2 ? AppColor.primary : Colors.white,width: 2))
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}