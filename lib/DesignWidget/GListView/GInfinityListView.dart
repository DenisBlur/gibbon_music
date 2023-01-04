import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/DesignWidget/GListView/GListScrollButtons.dart';

class GListView extends StatefulWidget {
  const GListView(
      {Key key,
      @required this.itemBuilder,
      @required this.itemCount,
      this.scrollDirection = Axis.vertical,
      this.scrollButtons = false})
      : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final Axis scrollDirection;
  final int itemCount;
  final bool scrollButtons;

  @override
  State<GListView> createState() => _GListViewState();
}

class _GListViewState extends State<GListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          scrollDirection: widget.scrollDirection,
          itemBuilder: widget.itemBuilder,
          itemCount: widget.itemCount,
        ),
        widget.scrollButtons
            ? Center(
                child: GListScrollButtons(
                  scrollController: _scrollController,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
