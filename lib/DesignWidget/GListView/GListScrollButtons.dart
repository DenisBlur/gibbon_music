import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mIcon;

class GListScrollButtons extends StatefulWidget {
  const GListScrollButtons({Key key, @required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  State<GListScrollButtons> createState() => _GListButtonsState();
}

class _GListButtonsState extends State<GListScrollButtons> {
  bool showForward = true;
  bool showBack = false;

  void toggleButtons(double currentOffset) {
    double maxOffset = widget.scrollController.positions.first.maxScrollExtent;
    setState(() {
      if (currentOffset >= maxOffset) {
        showForward = false;
      } else {
        showForward = true;
      }

      if (currentOffset <= 0) {
        showBack = false;
      } else {
        showBack = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 32,
        ),
        showBack
            ? IconButton(
                icon: const Icon(mIcon.Icons.arrow_back_rounded),
                onPressed: () {
                  toggleButtons(widget.scrollController.offset - 360);
                  widget.scrollController.animateTo(
                      widget.scrollController.offset - 360,
                      duration: const Duration(milliseconds: 650),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
              )
            : const SizedBox(),
        const Expanded(child: SizedBox()),
        showForward
            ? IconButton(
                icon: const Icon(mIcon.Icons.arrow_forward_rounded),
                onPressed: () {
                  toggleButtons(widget.scrollController.offset + 360);
                  widget.scrollController.animateTo(
                      widget.scrollController.offset + 360,
                      duration: const Duration(milliseconds: 650),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
              )
            : const SizedBox(),
        const SizedBox(
          width: 32,
        ),
      ],
    );
  }
}