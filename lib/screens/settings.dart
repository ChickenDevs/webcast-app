import 'dart:convert';

import 'package:Manager/utils/api/settings.dart';
import 'package:Manager/utils/constants.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  dynamic settings;

  String resolution = '1280x720';
  String streamPreset = 'faster';

  void _settings() async {
    var r = await getSettings();

    if (r.statusCode == 200) {
      setState(() {
        settings = jsonDecode(r.body);
        resolution = settings['resolution'];
        streamPreset = settings['streamPreset'];
      });
    }
    
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _settings();
  }

  @override
  Widget build(BuildContext context) {
    if (settings == null) return buildLoading("Getting Settings...");

    return Scaffold(
      appBar: AppBar(
        title: Text('Webcast Manager Settings'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            background,
            Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 15.0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Resolution:",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      Spacer(),
                      DropdownButton(
                        value: resolution,
                        onChanged: (String value) {
                          setState(() {
                            resolution = value;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: '1280x720',
                            child: Text("1280x720"),
                          ),
                          DropdownMenuItem(
                            value: '1920x1080',
                            child: Text("1920x1080"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Video Delay:",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 100.0,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Audio Delay:",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 100.0,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Volume Gain:",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 100.0,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Stream Preset:",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      Spacer(),
                      DropdownButton(
                        value: streamPreset,
                        onChanged: (String value) {
                          setState(() {
                            streamPreset = value;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'veryfast',
                            child: Text("veryfast"),
                          ),
                          DropdownMenuItem(
                            value: 'faster',
                            child: Text("faster"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
