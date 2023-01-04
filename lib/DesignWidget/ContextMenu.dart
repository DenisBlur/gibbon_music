import 'dart:async';
import 'dart:ui';

// ignore: depend_on_referenced_packages
import 'package:animations/animations.dart';
import 'package:fluent_ui/fluent_ui.dart';

typedef ContextMenuBuilder = List<Widget> Function(BuildContext context);

void showContextMenu(
  Offset offset,
  BuildContext context,
  ContextMenuBuilder builder,
  verticalPadding,
  width,
) {
  showModal(
    context: context,
    configuration: const FadeScaleTransitionConfiguration(
      barrierColor: Colors.transparent,
    ),
    builder: (context) => ContextMenu(
      position: offset,
      builder: builder,
      verticalPadding: verticalPadding,
      width: width,
    ),
  );
}

class ContextMenuArea extends StatelessWidget {
  final Widget child;
  final ContextMenuBuilder builder;
  final double verticalPadding;
  final double width;

  const ContextMenuArea({
    Key key,
    @required this.child,
    @required this.builder,
    this.verticalPadding = 8,
    this.width = 320,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTapDown: (details) {
        showContextMenu(
          details.globalPosition,
          context,
          builder,
          verticalPadding,
          width,
        );
      },
      onTapDown: (details) {
        showContextMenu(
          details.globalPosition,
          context,
          builder,
          verticalPadding,
          width,
        );
      },
      child: child,
    );
  }
}

const double _kMinTileHeight = 24;

class ContextMenu extends StatefulWidget {
  final Offset position;
  final ContextMenuBuilder builder;
  final double verticalPadding;
  final double width;

  const ContextMenu({
    Key key,
    @required this.position,
    @required this.builder,
    this.verticalPadding = 8,
    this.width = 320,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContextMenuState createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  final Map<ValueKey, double> _heights = {};

  @override
  Widget build(BuildContext context) {
    final children = widget.builder(context);

    double height = 2 * widget.verticalPadding;

    for (var element in _heights.values) {
      height += element;
    }

    final heightsNotAvailable = children.length - _heights.length;
    height += heightsNotAvailable * _kMinTileHeight;

    if (height > MediaQuery.of(context).size.height) {
      height = MediaQuery.of(context).size.height;
    }

    double paddingLeft = widget.position.dx;
    double paddingTop = widget.position.dy;
    double paddingRight =
        MediaQuery.of(context).size.width - widget.position.dx - widget.width;
    if (paddingRight < 0) {
      paddingLeft += paddingRight;
      paddingRight = 0;
    }
    double paddingBottom =
        MediaQuery.of(context).size.height - widget.position.dy - height;
    if (paddingBottom < 0) {
      paddingTop += paddingBottom;
      paddingBottom = 0;
    }
    return AnimatedPadding(
      padding: EdgeInsets.fromLTRB(
        paddingLeft,
        paddingTop,
        paddingRight,
        paddingBottom,
      ),
      duration: _kShortDuration,
      child: SizedBox.shrink(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.25), offset: const Offset(0, 8), blurRadius: 10)
            ],
          ),
          margin: EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      width: .2,
                      color: FluentTheme.of(context).borderInputColor),
                  color: FluentTheme.of(context).cardColor.withOpacity(.8),
                ),
                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(vertical: widget.verticalPadding),
                  children: children
                      .map(
                        (e) => _GrowingWidget(
                          child: e,
                          onHeightChange: (height) {
                            setState(() {
                              _heights[ValueKey(e)] = height;
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const _kShortDuration = Duration(milliseconds: 75);

class _GrowingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<double> onHeightChange;

  const _GrowingWidget(
      {Key key, @required this.child, @required this.onHeightChange})
      : super(key: key);

  @override
  __GrowingWidgetState createState() => __GrowingWidgetState();
}

class __GrowingWidgetState extends State<_GrowingWidget> with AfterLayoutMixin {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      padding: const EdgeInsets.only(bottom: 4, top: 4, left: 8, right: 8),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: FluentTheme.of(context).borderInputColor, width: .5))),
      child: widget.child,
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    final newHeight = _key.currentContext.size.height + 1;
    widget.onHeightChange.call(newHeight);
  }
}

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then(
          (_) {
        if (mounted) afterFirstLayout(context);
      },
    );
  }

  FutureOr<void> afterFirstLayout(BuildContext context);
}
