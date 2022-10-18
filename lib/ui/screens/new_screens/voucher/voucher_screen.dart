import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marketplace/ui/screens/new_screens/voucher/widgets/voucher_tab_indicator_item.dart';
import 'package:marketplace/ui/screens/new_screens/voucher/widgets/voucher_top_notification_item.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/ui/widgets/filled_button.dart';
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'widgets/voucher_item.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({Key key}) : super(key: key);

  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  
  final scrollController = ScrollController();
  final itemKey = GlobalKey();

  @override
    void dispose() {
      scrollController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
                title: Text("Voucher"),
                brightness: Brightness.dark,
              ),
            ];
          },
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  height: MediaQuery.of(context).size.height,
                  top: 0,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Pilih promo",style: AppTypo.body1Lato.copyWith(fontWeight: FontWeight.bold),),
                        SizedBox(height: 3),
                        Text("Kamu bisa gubungkan promo biar makin hemat",style: AppTypo.body2Lato),
                        SizedBox(
                          height: 20,
                        ),
                        VoucherTopNotification(),
                        StickyHeader(
                            header: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Divider(
                                      thickness: 10,
                                      height: 26,
                                      color: AppColor.silverFlashSale,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  VoucherTabIndicatorItem(
                                    onTap: (int indexTab){
                                     scrollController.position.ensureVisible(itemKey.currentContext.findRenderObject(),duration: Duration(seconds: 1),alignment: .5,curve: Curves.easeInOutCubic);
                                  },),
                                ],
                              ),
                            ),
                            content: ListView(
                              shrinkWrap: true,
                              controller: scrollController,
                              children: [
                                // EditText(
                                //   hintText: 'Masukkan kode',
                                //   inputType: InputType.search,
                                // ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Kupon Saya",style: AppTypo.body1Lato.copyWith(fontWeight: FontWeight.bold,fontSize: 18),),
                                    Text("Hanya bisa pilih 1",style: AppTypo.caption.copyWith(color: AppColor.grey),)
                                  ],
                                ),
                                SizedBox(height: 12,),
                                ListView.separated(
                                  key: itemKey,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 10,
                                  ),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return VoucherItem(
                                      name:
                                          "Gratis Ongkir Min. Belanja Rp 50 RB",
                                    );
                                  },
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Kupon Toko",style: AppTypo.body1Lato.copyWith(fontWeight: FontWeight.bold,fontSize: 18),),
                                    Text("Hanya bisa pilih 1",style: AppTypo.caption.copyWith(color: AppColor.grey))
                                  ],
                                ),
                                SizedBox(height: 12,),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 10,
                                  ),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return VoucherItem(
                                      name:
                                          "Gratis Ongkir Min. Belanja Rp 50 RB",
                                    );
                                  },
                                ),
                                 SizedBox(height: 12,),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Promo yang belum bisa dipakai",style: AppTypo.body1Lato.copyWith(fontWeight: FontWeight.bold,fontSize: 18)),
                                  ],
                                ),
                                SizedBox(height: 12,),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 10,
                                  ),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return VoucherItem(
                                      name:
                                          "Gratis Ongkir Min. Belanja Rp 50 RB",
                                    );
                                  },
                                )
                              ],
                            )),
                            SizedBox(height: 120,)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * (5/100),vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                            boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF21232C)
                                              .withOpacity(0.05),
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                          offset: Offset(0, -4),
                                        ),
                                      ]),
                    
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kamu lebih hemat",
                              style: AppTypo.caption
                                  .copyWith(color: Colors.grey),
                            ),
                            Text(
                              "Rp.15.000,-",
                              style: AppTypo.subtitle2
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        FilledButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            "Pakai Voucher",
                            style: AppTypo.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
