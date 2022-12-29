import 'screen.dart';

mixin RouteTranslate{
  PluginScreen? onTranslateCodeToScreen(final String code, {dynamic args});
}

class PluginRouteTranslator {
  static RouteTranslate? _translate;

  static void registerTranslator(RouteTranslate operator) {
    _translate = operator;
  }

  static void unregisterTranslator() {
    _translate = null;
  }

  static PluginScreen? screenFromCode(String code, {dynamic args}) {
    return _translate?.onTranslateCodeToScreen(code, args: args);
  }

  static String? routeFromCode(String code) {
    final screen = screenFromCode(code);
    return screen?.route;
  }

}
