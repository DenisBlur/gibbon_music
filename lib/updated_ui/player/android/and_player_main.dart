import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/ui_consts.dart';

import '../windows/win_player_info.dart';

class AndPlayerMain extends StatefulWidget {
  const AndPlayerMain({Key? key, required this.maxHeight}) : super(key: key);

  final double maxHeight;

  @override
  State<AndPlayerMain> createState() => _AndPlayerMainState();
}

class _AndPlayerMainState extends State<AndPlayerMain> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late bool _isOpen;

  late double _currentPosition;
  late double _minPosition;
  late double _maxPosition;
  late double _endPosition;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: AppConsts.slowAnimation)
      ..addListener(() {
        if (_animationController.status == AnimationStatus.forward) {
          setState(() {
            _currentPosition = lerpDouble(_currentPosition, _endPosition, _animation.value)!.toDouble();
            print(_currentPosition);
          });
        }
      });
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: AppConsts.defaultCurve));
    _isOpen = false;
    _minPosition = AppConsts.playerHeight;
    _maxPosition = widget.maxHeight;
    _currentPosition = -(_maxPosition - _minPosition);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: AppConsts.defaultCurve,
      duration: AppConsts.slowAnimation,
      bottom: _currentPosition.clamp(-(_maxPosition - _minPosition), 0),
      child:GestureDetector(
        onVerticalDragUpdate: (details) {
          _updateHeight(details);
        },
        onVerticalDragEnd: (details) {
          _stopUpdateHeight(details);
        },
        child: AnimatedContainer(
            height: _maxPosition,
            duration: AppConsts.defaultAnimation,
            curve: AppConsts.defaultCurve,
            decoration: BoxDecoration(
                color: FluentTheme.of(context).cardColor,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 10, offset: const Offset(0, -4))]),
            child: Stack(
              children: [
                Text(_currentPosition.toString()),
                SizedBox(
                  height: _minPosition,
                  width: AppConsts.pageSize(context).width,
                  child: Column(
                    children: [
                      Slider(
                        value: 20,
                        onChanged: (value) {},
                        style: SliderThemeData(margin: EdgeInsets.zero),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _updateHeight(DragUpdateDetails details) {
    _animationController.reset();
    setState(() {
      _currentPosition -= details.delta.dy;
    });
  }

  _stopUpdateHeight(DragEndDetails details) {
    double velocity = details.velocity.pixelsPerSecond.dy;

    if (velocity < -1500) {
      _endPosition = 0;
      _animate();
      return;
    }

    if (velocity > 1500) {
      _endPosition = -(_maxPosition - _minPosition);
      _animate();
      return;
    }

    if (_currentPosition > _maxPosition / 2) {
      _endPosition = 0;
      _animate();
      return;
    }

    if (_currentPosition < _maxPosition / 2) {
      _endPosition = -(_maxPosition - _minPosition);
      _animate();
      return;
    }
  }

  _animate() {
    _animationController.reset();
    _animationController.forward();
  }
}