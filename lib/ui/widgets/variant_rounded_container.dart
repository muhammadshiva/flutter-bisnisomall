import 'package:flutter/material.dart';
import 'package:marketplace/utils/extensions.dart' as AppExt;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/colors.dart' as AppColor;

class VariantRoundedContainer extends StatelessWidget {
  const VariantRoundedContainer({
    Key key,
    this.title,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                width: 1.5,
                color:
                    isSelected ? AppColor.primary.withOpacity(0.5) : AppColor.silverFlashSale),
            color: isSelected ? AppColor.bgVariantSelected : Colors.white),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                title,
                maxLines: 1,
                style: AppTypo.body2Lato.copyWith(
                    color: isSelected ? AppColor.primary : AppColor.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
