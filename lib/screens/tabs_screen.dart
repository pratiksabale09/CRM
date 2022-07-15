import 'package:car_rental_mng_app/screens/accounts.dart';
import 'package:car_rental_mng_app/screens/dashboard.dart';
import 'package:car_rental_mng_app/screens/trips/tripsscreen.dart';
import 'package:car_rental_mng_app/screens/vehicles/vehicles_screen.dart';
import 'package:car_rental_mng_app/screens/slidingtripdrawer.dart';
import 'package:flutter/material.dart';

import 'organizations/organization_screen.dart';

// ignore: must_be_immutable
class TabsScreen extends StatefulWidget {
  String routeName = '/tabscreen';

  TabsScreen({Key? key}) : super(key: key);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  bool isDrawerOpen = false;
  // ignore: prefer_typing_uninitialized_variables
  var routeIndex;
  int selectedPageIndex = 0;
  bool isLoading = false;

  Future<bool> onBackPressed() async {
    return (await showDialog(
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

  final List<Map<String, dynamic>> _pages = [
    {
      'page': DashboardPage(),
      'title': 'Dashboard',
    },
    {
      'page': const Vehicles_Screen(),
      'title': 'Your Vehicles',
    },
    {
      'page': SlidingDrawer(isOpen: false),
      'title': 'Map',
    },
    {
      'page': const Trips(),
      'title': 'Trips',
    },
    {
      'page': const Org_Screen(),
      'title': 'Organizations',
    },
    {
      'page': const AccountsPage(),
      'title': 'Account',
    },
  ];

  void _selectPage(int index) {
    print(selectedPageIndex);
    print(index);
    print(routeIndex);
    setState(() {
      selectedPageIndex = index;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (routeIndex != 0) {
      routeIndex = ModalRoute.of(context)?.settings.arguments as dynamic;
    }
    //logic to set panel position open only if routed from dashboard new trip button
    if (routeIndex != null && routeIndex != 0) {
      print("HERE $routeIndex");
      selectedPageIndex = routeIndex;
      isDrawerOpen = true;
    }
    routeIndex = 0;
    (isDrawerOpen)
        ? (_pages[2]['page'] = SlidingDrawer(isOpen: true))
        : (_pages[2]['page'] = SlidingDrawer(isOpen: false));

    return WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(_pages[selectedPageIndex]['title'].toString()),
          ),
          body: _pages[selectedPageIndex]['page'],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey[900],
            selectedItemColor: Theme.of(context).primaryColor,
            currentIndex: selectedPageIndex,
            type: BottomNavigationBarType.shifting,
            items: const [
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.dashboard_rounded),
                // ignore: deprecated_member_use
                title: Text('Dashboard'),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.directions_car_rounded),
                // ignore: deprecated_member_use
                title: Text('Vehicles'),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.location_on_rounded),
                // ignore: deprecated_member_use
                title: Text('Map'),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.train_sharp),
                // ignore: deprecated_member_use
                title: Text('Trips'),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.add_business_outlined),
                // ignore: deprecated_member_use
                title: Text('Organizations'),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.person_rounded),
                // ignore: deprecated_member_use
                title: Text('Account'),
              ),
            ],
          ),
        ));
  }
}
