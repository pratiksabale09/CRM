import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<bool> onBackPressed() async {
    return (
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('CANCEL'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("LEAVE"),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
            backgroundColor: Colors.grey[400],
            appBar: AppBar(
              title: const Text("Settings"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Container(
              margin: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  children: const <Widget>[
                     Padding(
                      padding: EdgeInsets.all(0),
                      child: Text('Settings Here'),
                    ),
                  ],
                ),
              ),
            ))));
  }
}
