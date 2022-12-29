import 'abstract.dart';

class User extends AbstractModel {
  String id;
  String? code;
  String? name;
  int? status;

  User(this.id, this.code, this.name, this.status);

  static User fromJson(Map<String, dynamic>? json) {
    json = json?['profile'];
    String id = json?['staffId'] ?? '';
    String code = json?['staffCode'];
    String name = json?['staffName'];
    int status = json?['status'];
    return User(id, code, name, status);
  }

  @override
  String toString() {
    return '{ \r\n'
        'staffId = $id \r\n'
        'staffCode = $code \r\n'
        'staffName = $name \r\n'
        'status = $status \r\n'
        '}';
  }
}
