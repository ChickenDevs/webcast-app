import 'dart:convert';

import 'package:Manager/utils/api/pause.dart';
import 'package:Manager/utils/api/start.dart';
import 'package:Manager/utils/api/status.dart';
import 'package:Manager/utils/api/stop.dart';
import 'package:Manager/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String statusStr = "";
  bool paused = false;

  void _pauseState() async {
    bool r = await pauseStatus();
    setState(() {
      paused = r;
    });
  }

  @override
  void initState() {
    super.initState();
    _pauseState();
  }

  void _sendPause() async {
    var r = await pause();

    if (r.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.pause_circle,
                color: Colors.orange,
              ),
              SizedBox(width: 20.0),
              Text("Paused!"),
            ],
          ),
        ),
      );
      setState(() {
        statusStr = "The stream has been paused!";
        paused = true;
      });
    }
  }

  void _sendResume() async {
    var r = await resume();

    if (r.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.play_circle,
                color: Colors.lightGreen,
              ),
              SizedBox(width: 20.0),
              Text("Resumed!"),
            ],
          ),
        ),
      );
      setState(() {
        statusStr = "The stream has been resumed!";
        paused = false;
      });
    }
  }

  void _sendStart() async {
    var r = await start();

    if (r.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check,
                color: Color(0xFF1CF611),
              ),
              SizedBox(width: 20.0),
              Text("Started Successfully"),
            ],
          ),
        ),
      );
      setState(() {
        statusStr = jsonDecode(r.body)['response'];
      });
    }
  }

  void _sendStop() async {
    var r = await stop();

    if (r.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check,
                color: Color(0xFF1CF611),
              ),
              SizedBox(width: 20.0),
              Text("Stopped Successfully"),
            ],
          ),
        ),
      );
      setState(() {
        statusStr = jsonDecode(r.body)['response'];
      });
    }
  }

  void _sendStatus() async {
    var r = await status();

    if (r.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check,
                color: Color(0xFF1CF611),
              ),
              SizedBox(width: 20.0),
              Text("Got Status Successfully"),
            ],
          ),
        ),
      );
      setState(() {
        statusStr = jsonDecode(r.body)['response'];
      });
    }
  }

  Widget _buildPauseBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
        onPressed: _sendPause,
        child: Text(
          'PAUSE',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildResumeBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
        onPressed: _sendResume,
        child: Text(
          'RESUME',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStartBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: _sendStart,
        child: Text(
          'START',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStopBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: _sendStop,
        child: Text(
          'STOP',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
        onPressed: _sendStatus,
        child: Text(
          'STATUS',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBox() {
    return Expanded(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Text(
          statusStr,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.0,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }

  void handleMenu(dynamic value) {
    Navigator.pushNamed(context, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webcast Manager'),
        actions: [
          PopupMenuButton(
            onSelected: handleMenu,
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem>[
                PopupMenuItem<String>(
                  value: "login",
                  child: Text("Logout"),
                ),
                // PopupMenuItem<String>(
                //   value: "stats",
                //   child: Text("Stats"),
                // ),
                // PopupMenuItem<String>(
                //   value: "settings",
                //   child: Text("Settings"),
                // ),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          background,
          Container(
            height: double.infinity,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 15.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  paused ? _buildResumeBtn() : _buildPauseBtn(),
                  _buildStartBtn(),
                  _buildStopBtn(),
                  _buildStatusBtn(),
                  _buildStatusBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
