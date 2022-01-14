import 'dart:async';
import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import './activity/splash.dart';
import 'common/check_connection_alert_dialog.dart';

final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  StreamSubscription connectivitySubscription;
  bool isOpenDialog = false;

  @override
  void initState() {
    super.initState();
    callInternet();
  }

  void callInternet() async {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((
        ConnectivityResult connectivityResult) async {
      if (connectivityResult == ConnectivityResult.none) {
        if (isOpenDialog) {
          Navigator.pop(nav.currentContext);
        }
        connectionDialog(nav.currentContext, checkInternet);
        setState(() {
          isOpenDialog = true;
        });
      } else {
        if (await CheckVpnConnection.isVpnActive()) {
          if (isOpenDialog) {
            Navigator.pop(nav.currentContext);
          }
          vpnDialog(nav.currentContext, checkVpn);
          setState(() {
            isOpenDialog = true;
          });
        }
      }
    });
  }

  checkVpn() async {
    if (await CheckVpnConnection.isVpnActive()) {
      if (isOpenDialog) {
        Navigator.pop(nav.currentContext);
      }
      vpnDialog(nav.currentContext, checkVpn);
      setState(() {
        isOpenDialog = true;
      });
    } else {
      if (isOpenDialog) {
        Navigator.pop(nav.currentContext);
      }
      setState(() {
        isOpenDialog = false;
      });
    }
  }

  checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      if (isOpenDialog) {
        Navigator.pop(nav.currentContext);
      }
      connectionDialog(nav.currentContext, checkInternet);
      setState(() {
        isOpenDialog = true;
      });
    } else {
      checkVpn();
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: nav,
      debugShowCheckedModeBanner: false,
      title: "Sarees, Lehengas choli online shopping",
      theme: ThemeData(
          primaryColor: PrimaryColor,
          accentColor: PrimaryColor,
          fontFamily: "Raleway-Regular"),
      home: FirstScreen(),
    );
  }
}
