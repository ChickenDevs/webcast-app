import 'package:http/http.dart';
import 'package:Manager/utils/api/login.dart';
import 'package:Manager/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ip = TextEditingController();
  final user = TextEditingController();
  final pass = TextEditingController();

  bool _loading = false;

  void sendLogin() async {
    var addr = ip.text.isEmpty ? '192.168.108.30' : ip.text;
    var username = user.text.isEmpty ? 'webcast' : user.text;
    var password = pass.text;
    var r = await login(addr, username, password).timeout(
        Duration(seconds: 3),
        onTimeout: () {
          return Response('No server found', 500);
        }
    );

    if (r.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('ip', addr);
      await prefs.setString('username', username);
      await prefs.setString('password', password);
    }
    else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Color(0xFFF61C11),
              ),
              SizedBox(width: 20.0),
              Text("Login Failed"),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildIPTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'IP',
          style: labelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: ip,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(Icons.dns, color: Colors.white),
              hintText: '192.168.108.30',
              hintStyle: hintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: labelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: user,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'webcast',
              hintStyle: hintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: labelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.centerLeft,
            decoration: boxDecorationStyle,
            height: 60.0,
            child: TextField(
              controller: pass,
              obscureText: true,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: 'Enter your Password',
                  hintStyle: hintTextStyle),
            ))
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () async => {
          setState(() {
            _loading = true;
          }),
          sendLogin(),
        },
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ip.dispose();
    user.dispose();
    pass.dispose();
    super.dispose();
  }

  void tryLogin() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      ip.text = prefs.getString('ip');
      user.text = prefs.getString('username');
      pass.text = prefs.getString('password');
      sendLogin();
    } on Error {}
  }

  @override
  void initState() {
    super.initState();
    if (!Navigator.canPop(context)) tryLogin();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return buildLoading('Logging in...');

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            background,
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 100.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      _buildIPTF(),
                      SizedBox(height: 20.0),
                      _buildUsernameTF(),
                      SizedBox(height: 20.0),
                      _buildPasswordTF(),
                      _buildLoginBtn(),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
