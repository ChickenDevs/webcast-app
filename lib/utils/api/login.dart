import 'package:http_auth/http_auth.dart';

login(ip, username, password) async {
  var client = BasicAuthClient(username, password);
  var res = client.get(Uri.parse("http://" + ip + ":5000/auth"));
  return res;
}
