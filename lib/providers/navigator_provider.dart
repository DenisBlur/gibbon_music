import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:stack/stack.dart' as s;
import 'ux_provider.dart';

class NavigatorProvider extends ChangeNotifier {
  NavigatorProvider();

  final navigatorKey = GlobalKey<NavigatorState>();
  final s.Stack<String> _navigationStack = s.Stack<String>();

  push(String path, BuildContext context, Widget widget) {
    navigatorKey.currentState!.push(FluentPageRoute(
      builder: (context) => widget,
    ));
    _navigationStack.push(path);
    uxCloseWidget(context);
  }

  pop(BuildContext context) {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
      _navigationStack.pop();
    }
    uxCloseWidget(context);
  }

  uxCloseWidget(BuildContext context) {
    if(context.read<UxProvider>().isOpenPlaylist) {
      context.read<UxProvider>().changePlaylistState();
    }
    notifyListeners();
  }

  bool get navigationCanBack => _navigationStack.isNotEmpty;
}
