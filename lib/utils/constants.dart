import 'package:flutter/material.dart';


final hintTextStyle = TextStyle(
  color: Colors.white54,
);

final labelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

final boxDecorationStyle = BoxDecoration(
  color: Color(0xFF1C73E8),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

Widget background = Container(
  height: double.infinity,
  width: double.infinity,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF73AEF5),
        Color(0xFF61A4F1),
        Color(0xFF478DE0),
        Color(0xFF398AE5),
      ],
      stops: [0.1, 0.4, 0.7, 0.9],
    ),
  ),
);

Widget buildLoading(String text) {
  return Scaffold(
    body: Stack(
      children: <Widget>[
        background,
        Align(
          alignment: FractionalOffset.center,
          child: Container(
            decoration: boxDecorationStyle,
            width: 300.0,
            height: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
