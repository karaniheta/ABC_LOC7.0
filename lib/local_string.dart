

import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Hello': 'Hello',
          'How can we assist you today?':'how can we assist you today'
        }
      };
}
