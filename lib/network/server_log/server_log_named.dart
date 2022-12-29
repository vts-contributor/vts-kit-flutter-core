import 'package:flutter_core/network/server_log/server_log.dart';

//sample ServerLog
class PizzaLog extends AbstractServerLog {
  static PizzaLog? _instance;

  @override
  String host = 'http://domain:port';

  @override
  String path = 'log';

  @override
  HttpMethod sendMethod = HttpMethod.GET;

  @override
  StoredIn logStoredIn = StoredIn.HEADER;

  PizzaLog._();

  factory PizzaLog.instance() {
    if (_instance == null) {
      _instance = PizzaLog._();
    }
    return _instance as PizzaLog;
  }

  static Future<void> send({
    String? userId,
    String? content,
    String? description,
  }) =>
      PizzaLog.instance().sendLog({
        'user_'
            'id': userId,
        'content': content,
        'description': description,
      });
}