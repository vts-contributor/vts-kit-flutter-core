import 'dart:io';

extension ContentTypex on ContentType {
  static final xWWWFormUrlencoded = new ContentType(
      'application', 'x-www-form-urlencoded',
      charset: 'utf-8');
}
