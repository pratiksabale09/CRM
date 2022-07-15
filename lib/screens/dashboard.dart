import 'package:car_rental_mng_app/screens/tabs_screen.dart';
import 'package:car_rental_mng_app/widgets/circleiconbutton.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DashboardPage extends StatefulWidget {
  String routeName = '/dashboard';

  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Stack(children: <Widget>[
        Column(children: const <Widget>[
          Padding(
              padding: EdgeInsets.all(0),
              child: Text('You are on dashboard')),
        ]),
        Align(
            alignment: Alignment.bottomRight,
            child: PulsatingCircleIconButton(onTap: () {
              Navigator.of(context).pushReplacementNamed(TabsScreen().routeName,arguments: 3
                   );
            }))
      ]),
    );
  }
}
