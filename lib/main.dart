import 'dart:async';
import 'package:car_rental_mng_app/providers/auth_provider.dart';
import 'package:car_rental_mng_app/providers/orgprovider.dart';
import 'package:car_rental_mng_app/providers/tripsprovider.dart';
import 'package:car_rental_mng_app/providers/vehicleprovider.dart';
import 'package:car_rental_mng_app/screens/dashboard.dart';
import 'package:car_rental_mng_app/screens/organizations/organization_screen.dart';
import 'package:car_rental_mng_app/screens/settings.dart';
import 'package:car_rental_mng_app/screens/tabs_screen.dart';
import 'package:car_rental_mng_app/screens/vehicles/addvehicles.dart';
import 'package:car_rental_mng_app/screens/vehicles/vehicles_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_mng_app/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthProvider()),
          ProxyProvider<AuthProvider, OrgProvider>(update: (context, auth, x) {
            return OrgProvider(auth);
          }),
          ProxyProvider<AuthProvider, TripsProvider>(update: (context, auth, x) {
            return TripsProvider(auth);
          }),
          ProxyProvider<AuthProvider, VehicleProvider>(
              update: (context, auth, x) {
            return VehicleProvider(auth);
          }),
        ],
        //the materialApp is made the consumer of AuthProvider so as to maintain user authentication throughout the app
        child: Consumer<AuthProvider>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'Splash Screen',
                  theme: ThemeData(
                    primaryColor: Colors.blue[800],
                  ),
                  home: auth.isAuth
                      ? TabsScreen()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (ctx, authResultSnapshot) =>
                              const SplashScreen(),
                        ),
                  routes: {
                    DashboardPage().routeName : (context) => DashboardPage(),
                    TabsScreen().routeName : (context) => TabsScreen(),
                    '/addvehicles': (context) => const AddVehiclePage(),
                    '/organizations': (context) => const Org_Screen(),
                    '/vehicles': (context) => const Vehicles_Screen(),
                    '/settings': (context) => const SettingsPage(),
                  },
                )));
  }
}

//splash screen class to provide "cosmica gps logo" on splash screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();  
    Timer(const Duration(seconds: 2), (){
      Navigator.pushReplacement(context,  
            MaterialPageRoute(builder:  
                (context) => const AuthCard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey[800],
        child: Padding(
          padding: const EdgeInsets.all(80),
          child: Image.asset(
            'lib/icons/logo.png',
            fit: BoxFit.scaleDown,
            height: 3,
            width: 3,
          ),
        ));
  }
}
