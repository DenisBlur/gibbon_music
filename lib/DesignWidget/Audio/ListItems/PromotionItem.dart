import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:gibbon_telegram/API/MainMethod/GMethod.dart';
import 'package:gibbon_telegram/API/Models/HomePage/M_Promotion.dart';
import 'package:gibbon_telegram/API/Models/NewHomePage/MV_Promotion.dart';

class PromotionItem extends StatefulWidget {
  const PromotionItem({Key? key, required this.promotion}) : super(key: key);

  final MvPromotion promotion;

  @override
  State<PromotionItem> createState() => _PromotionItemState();
}

class _PromotionItemState extends State<PromotionItem> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: () {},
      builder: (p0, state) {
        return AnimatedContainer(
          margin: EdgeInsets.only(right: 16),
          padding: EdgeInsets.all(state.isHovering ? 8 : 0),
          width: 350,
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastLinearToSlowEaseIn,
          decoration: BoxDecoration(
            color: FluentTheme.of(context).cardColor,
            border: Border.all(
                color: FluentTheme.of(context)
                    .borderInputColor
                    .withOpacity(state.isHovering ? .2 : 0),
                width: .5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  width: 350,
                  fit: BoxFit.cover,
                  linkImage(widget.promotion.image.toString(), 800, 800),
                ),
              ),
              Container(
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                        colors: [
                          FluentTheme.of(context).micaBackgroundColor,
                          FluentTheme.of(context)
                              .micaBackgroundColor
                              .withOpacity(.1),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.promotion.heading.toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: FluentTheme.of(context).accentColor,
                        )),
                    Text(widget.promotion.title.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(widget.promotion.subTitle.toString()),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
