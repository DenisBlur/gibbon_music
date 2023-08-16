import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/enums/e_list_typer.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/router.dart';
import 'package:gibbon_music/updated_ui/utils/dynamic_data.dart';
import 'package:flutter/material.dart' as m;

import '../../constants/style_consts.dart';

class DynamicListWidget extends StatefulWidget {
  const DynamicListWidget(
      {Key? key, required this.listData, required this.title, this.listType = ListType.standart, this.canMore = true, this.onMore})
      : super(key: key);

  final List<dynamic> listData;
  final String title;
  final ListType? listType;
  final bool? canMore;
  final VoidCallback? onMore;

  @override
  State<DynamicListWidget> createState() => _DynamicListWidgetState();
}

class _DynamicListWidgetState extends State<DynamicListWidget> {
  final ScrollController controller = ScrollController();
  bool canNext = true;
  bool canBefore = true;
  double top = AppConsts.defaultCardHeight / 2 + 16;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.listData.isNotEmpty) {
      controller.addListener(() {
        updateArrows();
      });
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        updateArrows();
      });
      if (widget.listType == ListType.wide) {
        top = AppConsts.wideCardHeight / 2 + 16;
      }
    } else {
      setState(() {
        canBefore = false;
        canNext = false;
      });
    }
  }

  updateArrows() {
    var max = controller.position.maxScrollExtent;
    var min = controller.position.minScrollExtent;
    var offset = controller.offset;

    if (min != max) {
      setState(() {
        if (offset >= max) {
          canBefore = true;
          canNext = false;
        } else {
          canNext = true;
        }

        if (offset <= min) {
          canBefore = false;
          canNext = true;
        } else {
          canBefore = true;
        }
      });
    } else {
      setState(() {
        canBefore = false;
        canNext = false;
      });
    }
  }

  scroll(bool next) {
    var max = controller.position.maxScrollExtent;
    var min = controller.position.minScrollExtent;
    var offset = controller.offset;

    if (next) {
      var tempOffset = offset + 650;
      if (tempOffset >= max) tempOffset = max + 56;
      controller.animateTo(tempOffset, duration: AppConsts.fastAnimation, curve: AppConsts.defaultCurve);
    } else {
      var tempOffset = offset - 650;
      if (tempOffset <= min) tempOffset = min - 56;
      controller.animateTo(tempOffset, duration: AppConsts.fastAnimation, curve: AppConsts.defaultCurve);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: AppConsts.pageOffset,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: AppStyle.subTitle(context),
                  ),
                  AppConsts.fillSpacer,
                  if (widget.canMore! && widget.listData.isNotEmpty)
                    Button(
                      child: const Text("Смотреть всё"),
                      onPressed: () {
                        if (widget.onMore != null) {
                          widget.onMore!();
                        } else {
                          AppRouter().gotoMore(context: context, listData: widget.listData, title: widget.title);
                        }
                      },
                    )
                ],
              ),
            ),
            AppConsts.smallVSpacer,
            widget.listData.isNotEmpty
                ? SizedBox(
                    width: AppConsts.pageSize(context).width,
                    height: widget.listType == ListType.wide ? AppConsts.wideCardHeight : AppConsts.defaultCardHeight,
                    child: ListView.builder(
                      controller: controller,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: index == 0 ? AppConsts.pageOffset.horizontal / 2 : 0, right: AppConsts.pageOffset.horizontal / 2),
                          child: getDynamicData(widget.listData, index),
                        );
                      },
                      itemCount: widget.listData.length,
                    ),
                  )
                : const Center(
                    child: Text("Ничего нет :("),
                  ),
          ],
        ),
        if (Platform.isWindows)
          Padding(
            padding: EdgeInsets.only(top: top, left: 16, right: 16),
            child: Row(
              children: [
                canBefore
                    ? IconButton(
                        onPressed: () {
                          scroll(false);
                        },
                        icon: const Icon(
                          m.Icons.navigate_before_rounded,
                          size: 24,
                        ),
                        style: ButtonStyle(
                          backgroundColor: ButtonState.all(
                            const Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      )
                    : const SizedBox(),
                AppConsts.fillSpacer,
                canNext
                    ? IconButton(
                        onPressed: () {
                          scroll(true);
                        },
                        icon: const Icon(
                          m.Icons.navigate_next_rounded,
                          size: 24,
                        ),
                        style: ButtonStyle(
                          backgroundColor: ButtonState.all(
                            const Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
      ],
    );
  }
}
