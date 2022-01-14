import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lehengas_choli_online_shopping/activity/login.dart';
import 'package:lehengas_choli_online_shopping/common/check_connection_alert_dialog.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/services/apis.dart';
import 'package:lehengas_choli_online_shopping/services/secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'home.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Loadbgimage();
  }
}

class Loadbgimage extends StatefulWidget {
  @override
  _LoadbgimageState createState() => _LoadbgimageState();
}

class _LoadbgimageState extends State<Loadbgimage> {
  bool isOpenDialog = false;


  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setAppData();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setAppData();
    } else {
      if (isOpenDialog) {
        Navigator.pop(context);
      }
      connectionDialog(context, checkConnection);
      setState(() {
        isOpenDialog = true;
      });
    }
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 21, 00);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }


  showNotification() async {
    saveStringToLocalStorage(
        "NTITLE", constantAppDataResponse.data.notificationTitle);
    saveStringToLocalStorage(
        "NDESP", constantAppDataResponse.data.notificationText);


    tz.initializeTimeZones();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        await getStringFromLocalStorage("NTITLE"),
        await getStringFromLocalStorage("NDESP"),
        _nextInstanceOfTenAM(),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                "EcommerceDailyNotificationID",
                'DailyNotification',
                'DailyNotificationDescription'),
            iOS: IOSNotificationDetails()
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }


  setAppData() async {
    await Firebase.initializeApp();
    String ftoken = await FirebaseMessaging.instance.getToken();
    print(ftoken);
    saveStringToLocalStorage(FTOKEN, ftoken);
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      saveStringToLocalStorage(FTOKEN, newToken);
    });


    final appDataResponse = await getAppData();

    if (appDataResponse != null) {
      if (appDataResponse.success == true) {
        constantAppDataResponse = appDataResponse;
        showNotification();
        checkLogin();
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    }
  }

  checkLogin() async {
    if (Productlist != null) {
      Productlist.data.products.clear();
    }
    Productlist = await getproductlist(1);
    Productlist.data.products.forEach((element) {
      for (int i = 0; i < element.productColor.length; i++) {
        if (i == 0) {
          element.productColor[i].isSelected = true;
          return;
        }
      }
    });

    if (Productlist.data.totalPages >= 2) {
      for (int i = 2; i <= Productlist.data.totalPages; i++) {
        var temp = await getproductlist(i);

        temp.data.products.forEach((element) {
          for (int i = 0; i < element.productColor.length; i++) {
            if (i == 0) {
              element.productColor[i].isSelected = true;
            }
          }
        });

        Productlist.data.products.addAll(temp.data.products);
      }
    }

    String isFirstTime = await getStringFromLocalStorage(KEY_IS_FIRST_TIME);
    if (isFirstTime == "false") {
      saveStringToLocalStorage(KEY_IS_FIRST_TIME, "false");
      String islogin = await getStringFromLocalStorage(USER_ID);
      if (islogin != null) {
        var map = new Map<String, dynamic>();
        String deviceid = await getStringFromLocalStorage(DEVICEID);
        String ftoken = await getStringFromLocalStorage(FTOKEN);
        map["uuid"] = deviceid;
        map["f_token"] = ftoken;
        constantaccountDataResponse = await getUserData(map);

        if (constantaccountDataResponse != null) {
          if (constantaccountDataResponse.success == true) {
            user_id = await getStringFromLocalStorage(USER_ID);
            profile_pic = await getStringFromLocalStorage(PROFILE_PIC);
            email = await getStringFromLocalStorage(EMAIL_ID);
            fullname = await getStringFromLocalStorage(USER_FULL_NAME);
            constantcartDataResponse =
                constantaccountDataResponse.data.userdata.cart;

            if (constantcartDataResponse != null &&
                constantcartDataResponse.isNotEmpty) {
              constantcartDataResponse.forEach((element) {
                constantAppDataResponse.data.colorslist.forEach((element1) {
                  if (element1.id == element.Colorid) {
                    element.ColorName = element1.name;
                  }
                });
              });
            }


            constantorderResponse =
                constantaccountDataResponse.data.userdata.orderStatus.reversed
                    .toList();

            if (constantorderResponse != null &&
                constantorderResponse.isNotEmpty) {
              constantorderResponse.forEach((element) {
                constantAppDataResponse.data.colorslist.forEach((element1) {
                  element.product.forEach((element2) {
                    if (element2.Colorid == element1.id) {
                      element2.ColorName = element1.name;
                    }
                  });
                });
              });
            }

            constantWishlistDataResponse =
                constantaccountDataResponse.data.userdata.wishlist;

            if (constantWishlistDataResponse != null &&
                constantWishlistDataResponse.isNotEmpty) {
              constantWishlistDataResponse.forEach((element) {
                constantAppDataResponse.data.colorslist.forEach((element1) {
                  if (element1.id == element.Colorid) {
                    element.ColorName = element1.name;
                  }
                });
              });
            }
            constantAddressDataResponse =
                constantaccountDataResponse.data.userdata.addresses;
            if (constantaccountDataResponse != null) {
              count = constantaccountDataResponse.data.userdata.cart.length;
            }


            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage(0)),
                    (route) => false);
          } else {
            Fluttertoast.showToast(
                msg: "Something went wrong!!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 5);
        }
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => HomePage(0)), (
                route) => false);
      }
    } else {
      saveStringToLocalStorage(KEY_IS_FIRST_TIME, "false");
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/images/signin.png');
    Image image = Image(
        image: assetImage,
        fit: BoxFit.fill,
        width: MediaQuery
            .of(context)
            .size
            .width);
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(
          children: [
            image,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                      "assets/images/appLogoSplash.png", color: Colors.white,
                      fit: BoxFit.fill,
                      width: 300,
                      height: 300,)),
                Container(
                    width: 80, height: 80,
                    child: Lottie.asset('assets/json/splachlodding.json')),
              ],
            ),
          ],
        ));
  }

  Future onDidReceiveLocalNotification(int id, String title, String body,
      String payload) {

  }

  Future onSelectNotification(String payload) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => FirstScreen()),
            (route) => false);
  }
}
