import 'core.dart';

/// The translations for Vietnamese (`vi`).
class CoreLocalizationsVi extends CoreLocalizations {
  CoreLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get loginTxtUsername => 'Tên đăng nhập';

  @override
  String get loginTxtPassword => 'Mật khẩu';

  @override
  String get loginBtnLogin => 'Đăng nhập';

  @override
  String get loginWithFingerprint => 'Đăng nhập bằng vân tay';

  @override
  String get loginWithFaceId => 'Đăng nhập bằng Face ID';

  @override
  String get bioSecurityNotEnabled => 'Bảo mật sinh trắc học chưa được thiết lập, vui lòng bật';

  @override
  String get loginAltEmptyUserNamePassword => 'Tên đăng nhập và mật khẩu không được bỏ trống';

  @override
  String get loginAlrLoading => 'Đang xác thực';

  @override
  String get loadAccessControl => 'Đang xác thực quyền';

  @override
  String get socketException => 'Không có mạng vui lòng thử lại';

  @override
  String get timeoutException => 'Quá thời gian xử lý yêu cầu';

  @override
  String get authorizationException => 'Lỗi xác thực vui lòng đăng nhập lại';

  @override
  String get notFoundException => 'Không tìm thấy nội dung, vui lòng quay lại sau';

  @override
  String unsupportedLanguageException(Object argument) {
    return 'Ngôn ngữ $argument không được hỗ trợ';
  }

  @override
  String get commonException => 'Đã xảy ra lỗi';

  @override
  String get noSuchMethodException => 'Đã xảy ra lỗi trong quá trình lấy dữ liệu';

  @override
  String get notFoundPageInStreamChannel => 'Không tìm thấy trang trong kênh chuyển màn hình';

  @override
  String get emptyStreamChannel => 'Kênh chuyển màn hình không được bỏ trống';

  @override
  String get cancelRequestException => 'Thao tác đã dừng lại';
}
