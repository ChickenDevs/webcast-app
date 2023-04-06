import 'package:http_auth/http_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

start() async {
  final prefs = await SharedPreferences.getInstance();

  var client = BasicAuthClient(prefs.getString('username'), prefs.getString('password'));
  var res = await client.get(Uri.parse("http://" + prefs.getString('ip') + ":5000/webcast/start"));
  return res;
}