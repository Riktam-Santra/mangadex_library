import 'src/models/common/server_exception.dart';

class MangadexServerException implements Exception {
  late ServerException info;
  static const Map<String, dynamic> DEF_VALUE = {
    'result': 'error',
    'errors': [
      {'id': 'string', 'status': 0, 'title': 'string', 'detail': 'string'}
    ]
  };

  MangadexServerException([Map<String, dynamic> error = DEF_VALUE]) {
    print(error.toString());
    info = ServerException.fromJson(error);
  }
}
