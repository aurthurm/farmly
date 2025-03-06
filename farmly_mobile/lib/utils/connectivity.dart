import 'package:http/http.dart' as http;
import '../constants/constants.dart';

Future<bool> getConnectivityStatus() async {
  bool _isOnline = false;
  try {
    final response = await http.get(Uri.parse('$BACKEND_URL/health')).timeout(
      Duration(seconds: 5),
    );
    _isOnline = response.statusCode == 200;
  } catch (e) {
    _isOnline = false;
  }
  return _isOnline;
}