import 'dart:io';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/Styles/ConstValue.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart' as m;

import '../../API/MainMethod/GMethod.dart';

class AAPMain extends StatelessWidget {
  const AAPMain({
    Key key,
    @required this.index,
    @required this.coverUri,
    @required this.title,
    @required this.subTitle,
    @required this.bottomTitle,
    this.onPressed,
    this.icon = m.Icons.filter_none,
  }) : super(key: key);

  final int index;
  final String coverUri;

  final String title;
  final String subTitle;
  final String bottomTitle;
  final IconData icon;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: onPressed,
      builder: (p0, state) {
        return AnimatedContainer(
            duration: slowAnimation,
            curve: Curves.fastLinearToSlowEaseIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: FluentTheme.of(context).cardColor.withOpacity(state.isHovering ? 1 : 0),
            ),
            margin: EdgeInsets.only(right: 16, left: index == 0 && Platform.isAndroid ? 16 : 0),
            width: 250,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    AnimatedScale(
                      scale: state.isHovering
                          ? state.isPressing
                              ? .8
                              : .95
                          : 1,
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: slowAnimation,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          width: 250,
                          image: coverUri != null ? linkImage(coverUri, 200) : imagePlaceholder,
                          placeholder: kTransparentImage,
                        ),
                      ),
                    ),
                    icon != m.Icons.filter_none
                        ? Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: FluentTheme.of(context).cardColor, borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              icon,
                              size: 18,
                            ),
                          )
                        : const SizedBox(),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: FluentTheme.of(context).cardColor.withOpacity(.8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                  subTitle,
                                  style: TextStyle(color: FluentTheme.of(context).borderInputColor, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                Text(
                                  bottomTitle,
                                  style: TextStyle(color: FluentTheme.of(context).borderInputColor, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )));
      },
    );
  }
}
