import 'core.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class CoreLocalizationsMy extends CoreLocalizations {
  CoreLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get loginTxtUsername => 'အသုံးပြုသူအမည်';

  @override
  String get loginTxtPassword => 'စကားဝှက်';

  @override
  String get loginBtnLogin => 'အကောင့်ဝင်ရန်';

  @override
  String get loginWithFingerprint => 'လက်ဗွေဖြင့် အကောင့်ဝင်ရန်';

  @override
  String get loginWithFaceId => 'Face ID ဖြင့် အကောင့်ဝင်ရန်';

  @override
  String get bioSecurityNotEnabled => 'ဇီဝအချက်အလက်ဖြင့် အတည်ပြုခြင်းကို မသတ်မှတ်ရသေးပါ။ ဖွင့်ပေးပါ။';

  @override
  String get loginAltEmptyUserNamePassword => 'အသုံးပြုသူအမည်နှင့် စကားဝှက်ကို မဖြည့်ဘဲ မထားရပါ။';

  @override
  String get loginAlrLoading => 'အတည်ပြုနေသည်';

  @override
  String get loadAccessControl => 'အသုံးပြုခွင့်ကို စစ်ဆေးနေသည်';

  @override
  String get socketException => 'အင်တာနက်ချိတ်ဆက်မှု မရှိပါ။ ထပ်မံကြိုးစားပေးပါ။';

  @override
  String get timeoutException => 'တောင်းဆိုမှုကို ဆောင်ရွက်ရန် သတ်မှတ်ချိန် ကျော်လွန်သွားသည်။';

  @override
  String get authorizationException => 'အတည်ပြုခြင်း မအောင်မြင်ပါ။ အကောင့်ပြန်ဝင်ပေးပါ။';

  @override
  String get notFoundException => 'အကြောင်းအရာကို မတွေ့ပါ။ နောက်မှ ပြန်လည်ကြိုးစားပေးပါ။';

  @override
  String unsupportedLanguageException(Object argument) {
    return 'ဘာသာစကား $argument ကို မပံ့ပိုးပါ။';
  }

  @override
  String get commonException => 'အမှားတစ်ခု ဖြစ်ပွားခဲ့သည်။';

  @override
  String get noSuchMethodException => 'ဒေတာရယူစဉ် အမှားတစ်ခု ဖြစ်ပွားခဲ့သည်။';

  @override
  String get notFoundPageInStreamChannel => 'မျက်နှာပြင်ပြောင်းလဲမှု ချန်နယ်တွင် စာမျက်နှာကို မတွေ့ပါ။';

  @override
  String get emptyStreamChannel => 'မျက်နှာပြင်ပြောင်းလဲမှု ချန်နယ်ကို အလွတ်မထားရပါ။';

  @override
  String get cancelRequestException => 'လုပ်ဆောင်မှုကို ရပ်တန့်လိုက်ပြီ။';

  @override
  String get biometricAuthLocalizedReason => 'အတည်ပြုနည်းလမ်းကို စက်လည်ပတ်စနစ်က ဆုံးဖြတ်ရန်';

  @override
  String get biometricHint => 'အထောက်အထားကို အတည်ပြုရန်';

  @override
  String get biometricNotRecognized => 'မှတ်မိခြင်း မရှိပါ။ ထပ်မံကြိုးစားပေးပါ။';

  @override
  String get biometricRequiredTitle => 'ဇီဝအချက်အလက်ဖြင့် အတည်ပြုရန် လိုအပ်သည်';

  @override
  String get biometricSuccess => 'အောင်မြင်သည်';

  @override
  String get biometricOkButton => 'သဘောတူရန်';

  @override
  String get biometricCancelButton => 'ပယ်ဖျက်ရန်';

  @override
  String get biometricDeviceCredentialsRequiredTitle => 'စက်၏ အထောက်အထားဖြင့် အတည်ပြုရန် လိုအပ်သည်';

  @override
  String get biometricDeviceCredentialsSetupDescription => 'စက်၏ အထောက်အထားဖြင့် အတည်ပြုရန် လိုအပ်သည်';

  @override
  String get biometricGoToSettingsButton => 'ဆက်တင်သို့ သွားရန်';

  @override
  String get biometricGoToSettingsDescription => 'ဤစက်တွင် ဇီဝအချက်အလက်ဖြင့် အတည်ပြုခြင်းကို မသတ်မှတ်ရသေးပါ။ သတ်မှတ်ရန် \'ဆက်တင် > လုံခြုံရေး\' သို့ သွားပါ။';

  @override
  String get biometricIOSGoToSettingsDescription => 'ဤစက်တွင် ဇီဝအချက်အလက်ဖြင့် အတည်ပြုခြင်းကို မသတ်မှတ်ရသေးပါ။ ဖုန်းတွင် Touch ID သို့မဟုတ် Face ID ကို ဖွင့်ပေးပါ။';

  @override
  String get biometricSignInTitle => 'အတည်ပြုရန် လိုအပ်သည်';

  @override
  String get biometricLockOut => 'ဇီဝအချက်အလက်ဖြင့် အတည်ပြုခြင်းကို ပိတ်ထားသည်။ ပြန်ဖွင့်ရန် မျက်နှာပြင်ကို လော့ခ်ချပြီး ပြန်ဖွင့်ပေးပါ။';

  @override
  String get biometricIOSLocalizedFallbackTitle => '';
}
