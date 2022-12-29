import 'package:flutter/material.dart';

const int TABLET_WIDTH = 769;
const int WEB_WIDTH = 1900;
enum ScreenType {
  PORTRAIT,
  TABLET_PORTRAIT,
  LANDSCAPE,
  TABLET_LANDSCAPE,
  WEB_FULL
}

ScreenType getScreenType(Size size) {
  ScreenType screenType;
  if (size.width > size.height) {
    if (size.width > WEB_WIDTH) {
      screenType = ScreenType.WEB_FULL;
    } else if (size.width > TABLET_WIDTH) {
      screenType = ScreenType.TABLET_LANDSCAPE;
    } else {
      screenType = ScreenType.LANDSCAPE;
    }
  } else {
    if (size.width < TABLET_WIDTH) {
      screenType = ScreenType.PORTRAIT;
    } else {
      screenType = ScreenType.TABLET_PORTRAIT;
    }
  }
  return screenType;
}
