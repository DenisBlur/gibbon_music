import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/extensions/string.dart';
import 'package:gibbon_music/ui/widgets/ImageThumbnail.dart';
import 'package:gibbon_music/updated_ui/widgets/image_hoverd.dart';
import 'package:yam_api/landing/promotion.dart';

import '../../constants/ui_consts.dart';

class PromotionCard extends StatelessWidget {
  const PromotionCard({Key? key, required this.data}) : super(key: key);

  final Promotion data;

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: () {},
      builder: (p0, state) {
        double imageState = 1.0;
        if (state.isPressing) {
          imageState = 0.9;
        } else if (state.isHovering) {
          imageState = 0.98;
        } else {
          imageState = .95;
        }

        return SizedBox(
          width: AppConsts.wideCardWidth(context),
          height: AppConsts.wideCardHeight(context),
          child: Column(
            children: [
              ImageHovered(
                imageState: imageState,
                uri: data.image!,
                uriSize: 400,
                height: AppConsts.wideCardHeight(context)-16,
                width: AppConsts.wideCardWidth(context),
              ),

            ],
          ),
        );
      },
    );
  }
}
