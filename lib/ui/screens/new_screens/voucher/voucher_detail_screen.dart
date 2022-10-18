import 'package:flutter/material.dart';
import 'package:marketplace/ui/screens/new_screens/voucher/widgets/voucher_item.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class VoucherDetailScreen extends StatelessWidget {
  const VoucherDetailScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  textTheme: TextTheme(headline6: AppTypo.subtitle2),
                  iconTheme: IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  forceElevated: false,
                  pinned: true,
                  shadowColor: Colors.black54,
                  floating: true,
                  title: Text("Syarat & Ketentuan"),
                  brightness: Brightness.dark,
                ),
              ];
            }, 
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                color: AppColor.primary,
                child: VoucherItem(name: "Gratis ongkir min. belanja Rp.50000",circleColor: AppColor.primary,),
              )
            ],
          )
        )
      ),
    );
  }
}