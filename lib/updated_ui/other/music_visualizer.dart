import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';

class MiniMusicVisualizer extends StatelessWidget {
  const MiniMusicVisualizer({
    Key? key,
    required this.color,
    required this.width,
    required this.height,
    this.active = false, this.count = 3,
  }) : super(key: key);

  final Color color;
  final double width;
  final double height;
  final int? count;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final List<int> duration = [900, 800, 700, 600, 500];
    List<Color> colorList = [
      FluentTheme.of(context).accentColor.light,
      FluentTheme.of(context).accentColor.normal,
      FluentTheme.of(context).accentColor.dark,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List<Widget>.generate(
        count!.toInt(),
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: VisualComponent(
            active: active,
            curve: Curves.bounceOut,
            duration: duration[index % 5],
            color: colorList[index],
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}

class VisualComponent extends StatefulWidget {
  const VisualComponent({
    Key? key,
    required this.duration,
    required this.color,
    required this.curve,
    required this.width,
    required this.height,
    this.active = false,
  }) : super(key: key);

  final int duration;
  final Color color;
  final Curve curve;
  final double width;
  final double height;
  final bool active;

  @override
  _VisualComponentState createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  late double width;
  late double height;

  _ambiguate<T>(value) => value;

  @override
  void initState() {
    super.initState();
    width = widget.width;
    height = widget.height;
    animate();
  }

  void animate() {
    animationController = AnimationController(duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation = CurvedAnimation(parent: animationController, curve: widget.curve);
    animation = Tween<double>(begin: 8, end: height).animate(curvedAnimation)
      ..addListener(() {
        update();
      });
    animationController.repeat(reverse: true);
  }

  void update() {
    _ambiguate(WidgetsBinding.instance).addPostFrameCallback((timeStamp) {
      if (mounted && widget.active) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: animation.value,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animation.removeListener(() {});
    animation.removeStatusListener((status) {});
    animationController.stop();
    animationController.reset();
    animationController.dispose();
    super.dispose();
  }
}
