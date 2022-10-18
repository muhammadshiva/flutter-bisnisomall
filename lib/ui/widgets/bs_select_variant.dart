import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:marketplace/data/models/models.dart';
import 'package:marketplace/ui/widgets/border_button.dart';
import 'package:marketplace/ui/widgets/filled_button.dart';
import 'package:marketplace/ui/widgets/variant_rounded_container.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/colors.dart' as AppColor;
import 'package:shimmer/shimmer.dart';

class BsSelectVariant {
  Future<void> showBsReview(BuildContext context,
      {String imageProduct,
      List<ProductVariant> listVariant,
      ProductVariant variantSelected,
      Function(int variantId, ProductVariant variant)
          onVariantSelected}) async {
    await showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: kIsWeb ? true : false,
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: context,
        builder: (BuildContext bc) {
          return BodyBsSelectVariant(
            listVariant: listVariant,
            variantSelected: variantSelected,
            onVariantSelected: onVariantSelected,
            imageProduct: imageProduct,
          );
        });
  }
}

class BodyBsSelectVariant extends StatefulWidget {
  const BodyBsSelectVariant(
      {Key key,
      this.listVariant,
      this.variantSelected,
      this.onVariantSelected,
      this.imageProduct})
      : super(key: key);

  final String imageProduct;
  final List<ProductVariant> listVariant;
  final ProductVariant variantSelected;
  final Function(int variantId, ProductVariant variant) onVariantSelected;

  @override
  State<BodyBsSelectVariant> createState() => _BodyBsSelectVariantState();
}

class _BodyBsSelectVariantState extends State<BodyBsSelectVariant> {
  int variantSelectedId = 0;

  ProductVariant productVariantSelected;

  @override
  void initState() {
    variantSelectedId = widget.variantSelected.id;
    productVariantSelected = widget.variantSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final bool isPhone = context.isPhone;

    return Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(22)),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Center(
            child: Container(
              width: _screenWidth * (15 / 100),
              height: 7,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
                borderRadius: BorderRadius.circular(7.5 / 2),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isPhone ? _screenWidth * (5 / 100) : 8),
            child: Text(
              "Pilih Varian",
              style: AppTypo.LatoBold.copyWith(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isPhone ? _screenWidth * (5 / 100) : 8),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    children: [
                      kIsWeb
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(
                                  widget.imageProduct ??
                                      'https://mercury.panenpanen.com/images/blank.png',
                                ),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                                  return Image.asset(
                                    AppImg.img_error,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  );
                                },
                                frameBuilder: (context, child, frame,
                                    wasSynchronouslyLoaded) {
                                  if (wasSynchronouslyLoaded) {
                                    return child;
                                  } else {
                                    return AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: frame != null
                                          ? child
                                          : Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            10)),
                                                color: Colors.grey[200],
                                              ),
                                            ),
                                    );
                                  }
                                },
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.imageProduct ??
                                  'https://mercury.panenpanen.com/images/blank.png',
                              memCacheHeight: Get.height > 350
                                  ? (Get.height * 0.25).toInt()
                                  : Get.height,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[200],
                                period: Duration(milliseconds: 1000),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      color: Colors.white),
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AppImg.img_error,
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                      SizedBox(
                        width: 28,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(productVariantSelected.variantName),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Rp " +
                                AppExt.toRupiah(productVariantSelected
                                            .variantDisc !=
                                        0
                                    ? productVariantSelected.variantFinalPrice
                                    : productVariantSelected.variantSellPrice),
                            style: AppTypo.LatoBold.copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Stok: ${productVariantSelected.variantStock}")
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Pilihan :",
                      style: AppTypo.LatoBold.copyWith(fontSize: 18)),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 50,
                    child: Wrap(
                      direction: Axis.horizontal,
                      runSpacing: 10,
                      alignment: WrapAlignment.start,
                      children: [
                        for (var i = 0; i < widget.listVariant.length; i++)
                          VariantRoundedContainer(
                            title: widget.listVariant[i].variantName,
                            isSelected:
                                variantSelectedId == widget.listVariant[i].id,
                            onTap: () {
                              setState(() {
                                variantSelectedId = widget.listVariant[i].id;
                                productVariantSelected = widget.listVariant[i];
                              });
                            },
                          )
                      ],
                    ),
                    // ListView.builder(
                    //   padding: EdgeInsets.symmetric(vertical: 7),
                    //   shrinkWrap: true,
                    //   scrollDirection: Axis.horizontal,
                    //   itemCount: widget.listVariant.length,
                    //   itemBuilder: (context, index) {
                    //     ProductVariant productVariant =
                    //         widget.listVariant[index];
                    //     return VariantRoundedContainer(
                    //       title: productVariant.variantName,
                    //       isSelected: variantSelectedId == productVariant.id,
                    //       onTap: () {
                    //         setState(() {
                    //           variantSelectedId = productVariant.id;
                    //           productVariantSelected = productVariant;
                    //         });
                    //       },
                    //     );
                    //   },
                    // ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: _screenWidth * (5 / 100)),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: BorderButton(
                      height: 45,
                      onPressed: () {},
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            EvaIcons.messageSquare,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Chat Penjual",
                            style: AppTypo.caption.copyWith(
                                color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => widget.onVariantSelected(
                          variantSelectedId, productVariantSelected),
                      height: 45,
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            EvaIcons.shoppingCart,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Beli",
                            style:
                                AppTypo.caption.copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
