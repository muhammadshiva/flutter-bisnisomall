import 'package:flutter/material.dart';
import 'package:marketplace/utils/Colors.dart' as AppColor;
import 'package:marketplace/utils/typography.dart' as AppTypo;
class VoucherTopNotification extends StatelessWidget {
  const VoucherTopNotification({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
           color: AppColor.primary,
           borderRadius: BorderRadius.circular(5)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kamu bisa hemat Rp.30.000",style: AppTypo.body1Lato.copyWith(fontWeight: FontWeight.bold,color: Colors.white)),
                    Text("ada 2 promo terbaik untukmu",style: AppTypo.body1Lato.copyWith(color: Colors.white))
                  ],
                ),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Center(
                    child: Text("Pilih",style: AppTypo.body1.copyWith(color: Colors.white)),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              )
              ],
            ),
          ),
        ),
        Positioned(
            left: -8,
            child: Column(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
                SizedBox(height: 7,),
                Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
                SizedBox(height: 7,),
                Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
              ],
            )),
        Positioned(
            right: -8,
            child: Column(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
                SizedBox(height: 7,),
                Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
                SizedBox(height: 7,),
                Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
              ],
            )),
      ],
    );
  }
}
