import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/API/MainMethod/GMethod.dart';
import 'package:gibbon_music/API/Models/NewHomePage/MV_Promotion.dart';
import 'package:mouse_parallax/mouse_parallax.dart';

class PromotionItem extends StatefulWidget {
  const PromotionItem({Key key, @required this.promotion}) : super(key: key);

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
        return Container(
          margin: const EdgeInsets.only(right: 16),
          width: 350,
          child: ParallaxStack(
            layers: [
              ParallaxLayer(
                yRotation: 0.25,
                xOffset: 10,
                xRotation: .25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    linkImage(widget.promotion.image, 800, 800),
                    width: 450,
                    height: 450,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ParallaxLayer(
                  yRotation: 0.25,
                  xOffset: 10,
                  xRotation: .25,
                  child: Container(
                    width: 450,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                            colors: [
                              FluentTheme.of(context).checkedColor,
                              FluentTheme.of(context)
                                  .checkedColor
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: FluentTheme.of(context).accentColor,
                            )),
                        Text(widget.promotion.title.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          widget.promotion.subTitle.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
