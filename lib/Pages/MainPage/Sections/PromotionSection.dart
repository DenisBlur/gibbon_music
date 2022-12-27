import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:gibbon_telegram/API/Models/NewHomePage/MV_Promotion.dart';

import '../../../API/Models/HomePage/M_Promotion.dart';
import '../../../DesignWidget/Audio/ListItems/PromotionItem.dart';

class PromotionSection extends StatefulWidget {
  const PromotionSection({Key? key, required this.promotions})
      : super(key: key);

  final List<MvPromotion> promotions;

  @override
  State<PromotionSection> createState() => _PromotionSectionState();
}

class _PromotionSectionState extends State<PromotionSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return FadeInRight(
            duration: Duration(milliseconds: 250),
            delay: Duration(milliseconds: 50 * index),
              child: PromotionItem(
            promotion: widget.promotions[index],
          ));
        },
        itemCount: widget.promotions.length,
      ),
    );
  }
}
