import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_Promotion.dart';

import '../../../DesignWidget/Audio/ListItems/PromotionItem.dart';

class PromotionSection extends StatefulWidget {
  const PromotionSection({Key key, @required this.promotions})
      : super(key: key);

  final List<MvPromotion> promotions;

  @override
  State<PromotionSection> createState() => _PromotionSectionState();
}

class _PromotionSectionState extends State<PromotionSection> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 450,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return FadeInRight(
                duration: const Duration(milliseconds: 250),
                delay: Duration(milliseconds: 50 * index),
                child: PromotionItem(
                  promotion: widget.promotions[index],
                ));
          },
          itemCount: widget.promotions.length,
        ),
      ),
    );
  }
}
