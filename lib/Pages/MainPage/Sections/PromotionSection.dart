import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_Promotion.dart';
import 'package:gibbon_music/DesignWidget/GListView/GInfinityListView.dart';
import 'package:gibbon_music/DesignWidget/ListItems/PromotionItem.dart';

class PromotionSection extends StatelessWidget {
  const PromotionSection({Key key, @required this.promotions}) : super(key: key);

  final List<MvPromotion> promotions;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: Platform.isWindows ? 450 : 250,
        child: GListView(
          scrollButtons: Platform.isWindows,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return FadeIn(
                duration: const Duration(milliseconds: 250),
                delay: Duration(milliseconds: 50 * index),
                child: PromotionItem(
                  promotion: promotions[index], index: index,
                ));
          },
          itemCount: promotions.length,
        ),
      ),
    );
  }
}