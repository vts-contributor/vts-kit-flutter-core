import 'core.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class CoreLocalizationsKm extends CoreLocalizations {
  CoreLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get loginTxtUsername => 'ឈ្មោះអ្នកប្រើ';

  @override
  String get loginTxtPassword => 'ពាក្យសម្ងាត់';

  @override
  String get loginBtnLogin => 'ចូល';

  @override
  String get loginWithFingerprint => 'ចូលប្រើដោយស្នាមម្រាមដៃ';

  @override
  String get loginWithFaceId => 'ចូលប្រើដោយ Face ID';

  @override
  String get bioSecurityNotEnabled => 'មិនទាន់បានរៀបចំសុវត្ថិភាពជីវមាត្រ សូមបើកមុន';

  @override
  String get loginAltEmptyUserNamePassword => 'ឈ្មោះអ្នកប្រើ និងពាក្យសម្ងាត់មិនអាចទុកចោល';

  @override
  String get loginAlrLoading => 'កំពុងផ្ទៀងផ្ទាត់';

  @override
  String get loadAccessControl => 'កំពុងផ្ទៀងផ្ទាត់សិទ្ធិ';

  @override
  String get socketException => 'មិនមានបណ្ដាញ សូមព្យាយាមម្តងទៀត';

  @override
  String get timeoutException => 'អស់ពេលរង់ចាំ';

  @override
  String get authorizationException => 'បរាជ័យក្នុងការផ្ទៀងផ្ទាត់ សូមចូលឡើងវិញ';

  @override
  String get notFoundException => 'មិនមានមាតិកា សូមពិនិត្យម្តងទៀតក្រោយ';

  @override
  String unsupportedLanguageException(Object argument) {
    return 'ភាសា $argument មិនត្រូវបានគាំទ្រ';
  }

  @override
  String get commonException => 'មានបញ្ហាខ្លះកើតឡើង';

  @override
  String get noSuchMethodException => 'មានបញ្ហាក្នុងការទាញយកទិន្នន័យ';

  @override
  String get notFoundPageInStreamChannel => 'រកមិនឃើញទំព័រនៅក្នុងឆានែលផ្លាស់ប្តូរទំព័រ';

  @override
  String get emptyStreamChannel => 'ឆានែលផ្លាស់ប្តូរទំព័រមិនអាចទុកចោល';

  @override
  String get cancelRequestException => 'សកម្មភាពត្រូវបានបោះបង់';

  @override
  String get biometricAuthLocalizedReason => 'អនុញ្ញាតឱ្យប្រព័ន្ធសម្រេចវិធីផ្ទៀងផ្ទាត់';

  @override
  String get biometricHint => 'បញ្ជាក់អត្តសញ្ញាណ';

  @override
  String get biometricNotRecognized => 'មិនអាចស្គាល់ សូមព្យាយាមម្តងទៀត';

  @override
  String get biometricRequiredTitle => 'តម្រូវឱ្យមានជីវមាត្រ';

  @override
  String get biometricSuccess => 'ជោគជ័យ';

  @override
  String get biometricOkButton => 'យល់ព្រម';

  @override
  String get biometricCancelButton => 'បោះបង់';

  @override
  String get biometricDeviceCredentialsRequiredTitle => 'តម្រូវឱ្យមានព័ត៌មានឧបករណ៍';

  @override
  String get biometricDeviceCredentialsSetupDescription => 'តម្រូវឱ្យមានព័ត៌មានឧបករណ៍';

  @override
  String get biometricGoToSettingsButton => 'ចូលទៅកាន់ការកំណត់';

  @override
  String get biometricGoToSettingsDescription => 'មិនទាន់បានកំណត់ជីវមាត្រនៅលើឧបករណ៍។ សូមចូលទៅ \'ការកំណត់ > សុវត្ថិភាព\' ដើម្បីបន្ថែមការផ្ទៀងផ្ទាត់ជីវមាត្រ';

  @override
  String get biometricIOSGoToSettingsDescription => 'មិនទាន់បានកំណត់ Touch ID ឬ Face ID នៅលើទូរស័ព្ទរបស់អ្នក។ សូមបើក Touch ID ឬ Face ID';

  @override
  String get biometricSignInTitle => 'តម្រូវការផ្ទៀងផ្ទាត់';

  @override
  String get biometricLockOut => 'ជីវមាត្រត្រូវបានដាក់ឱ្យអសកម្ម។ សូមបិទ និងបើកអេក្រង់ឡើងវិញដើម្បីធ្វើឱ្យវាប្រតិបត្តិ';

  @override
  String get biometricIOSLocalizedFallbackTitle => '';
}
