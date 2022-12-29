import 'package:flutter_core/bases/exceptions.dart';
import 'package:flutter_core/plugins/configuration.dart';

class Core {
  static Core? _instance;

  final PluginConfiguration configuration;

  Core._(this.configuration);

  factory Core.createUniqueInstance(PluginConfiguration pluginConfiguration) {
    if (_instance == null) {
      final core = Core._(pluginConfiguration);
      _instance = core;
      return core;
    }
    throw NoMoreOneInstanceException(
        'Can not create more instance of $Core class..');
  }

  static Core get instance {
    final localInstance = _instance;
    if (localInstance == null) {
      throw NotInitializedException(
          'instance of $Core was not initialized in createUniqueInstance');
    }
    return localInstance;
  }
}
