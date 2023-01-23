import 'package:fluent_ui/fluent_ui.dart';
import 'package:stack/stack.dart' as s;

import '../updated_ui/widgets/overlay_container.dart';

class NavigatorProvider extends ChangeNotifier {
  NavigatorProvider();

  final s.Stack<String> _navigationStack = s.Stack<String>();
  bool _overlayCreated = false;

  push(String path, BuildContext context, Widget widget) {
    Navigator.push(
        context,
        FluentPageRoute(
          builder: (context) => widget,
        ));
    _navigationStack.push(path);
    notifyListeners();
  }

  pop(BuildContext context) {
    //что бы избежать ошибки используется GoRouter
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      _navigationStack.pop();
    }
    notifyListeners();
  }

  showOverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      opaque: false,
      maintainState: true,
      builder: (context) {
        return const Positioned(top: 0, left: 0, bottom: 0, right: 0, child: OverlayContainer());
      },
    );
    if (!_overlayCreated) {
      overlayState?.insert(overlayEntry);
      _overlayCreated = true;
    }
  }

  bool get navigationCanBack => _navigationStack.isNotEmpty;
}
