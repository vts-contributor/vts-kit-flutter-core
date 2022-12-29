import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screen_type.dart';

mixin AdaptivePage {
  @protected
  @nonVirtual
  Widget adaptiveBody(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final deviceSize = MediaQuery.of(context).size;
      final Size pageSize = Size(constraint.maxWidth, constraint.maxHeight);
      ScreenType screenType = getScreenType(deviceSize);
      switch (screenType) {
        case ScreenType.LANDSCAPE:
          return landscapeBody(context, pageSize);
        case ScreenType.TABLET_LANDSCAPE:
          return tabletLandscapeBody(context, pageSize);
        case ScreenType.WEB_FULL:
          return webBody(context, pageSize);
        case ScreenType.TABLET_PORTRAIT:
          return tabletPortraitBody(context, pageSize);
        default:
          return portraitBody(context, pageSize);
      }
    });
  }

  Widget portraitBody(BuildContext context, Size size);

  Widget landscapeBody(BuildContext context, Size size);

  Widget tabletPortraitBody(BuildContext context, Size size) =>
      portraitBody(context, size);

  Widget tabletLandscapeBody(BuildContext context, Size size) =>
      landscapeBody(context, size);

  Widget webBody(BuildContext context, Size size) =>
      tabletLandscapeBody(context, size);
}
