import 'dart:math';

import 'package:fluent_ui/fluent_ui.dart';

Color getRandomWhiteColor(Random random) {
  int a = random.nextInt(200);
  return Color.fromARGB(a, 255, 255, 255);
}

class BobbleBean {
  Offset position;
  Offset origin;
  Color color;
  double speed;
  double radius;
}

class SnowFallBG extends StatefulWidget {
  const SnowFallBG({Key key}) : super(key: key);

  @override
  State<SnowFallBG> createState() => _SnowFallBGState();
}

class _SnowFallBGState extends State<SnowFallBG> with SingleTickerProviderStateMixin {
  final List<BobbleBean> _list = [];
  final Random _random = Random(DateTime.now().microsecondsSinceEpoch);
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    Future.delayed(Duration.zero, () {
      initData();
    });

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.repeat();
  }

  void initData() {
    for (int i = 0; i < 2000; i++) {
      BobbleBean bean = BobbleBean();
      bean.color = getRandomWhiteColor(_random);
      double x = _random.nextDouble() * MediaQuery.of(context).size.width;
      double y = _random.nextDouble() * MediaQuery.of(context).size.height;
      double z = _random.nextDouble() + 0.5;
      bean.speed = _random.nextDouble() + 0.01 / z;
      bean.position = Offset(x, y);
      bean.origin = Offset(x, 0);
      bean.radius = 2.0 / z;
      _list.add(bean);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: MediaQuery.of(context).size,
        painter: SnowCustomMyPainter(list: _list, random: _random));
  }
}

class SnowCustomMyPainter extends CustomPainter {
  List<BobbleBean> list;
  Random random;

  SnowCustomMyPainter({@required this.list, @required this.random});
  final Paint _paint = Paint()..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    for (var element in list) {
      double dx = random.nextDouble() * 2.0 - 1.0;
      double dy = element.speed;
      element.position += Offset(dx, dy);
      if (element.position.dy > size.height) {
        element.position = element.origin;
      }
    }

    for (var element in list) {
      _paint.color = element.color;
      canvas.drawCircle(element.position, element.radius, _paint);
    }
  }

  //Refresh control
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //Return false without refresh
    return true;
  }
}
