import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lehengas_choli_online_shopping/common/appbar.dart';
import 'package:lehengas_choli_online_shopping/common/check_connection_alert_dialog.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/fragments/Account.dart';
import 'package:lehengas_choli_online_shopping/fragments/Cart.dart';
import 'package:lehengas_choli_online_shopping/fragments/abouUsScreen.dart';
import 'package:lehengas_choli_online_shopping/fragments/ReturnPolicy.dart';
import 'package:lehengas_choli_online_shopping/fragments/CreateyourStyle.dart';
import 'package:lehengas_choli_online_shopping/fragments/NotificationModel.dart';
import 'package:lehengas_choli_online_shopping/fragments/Wishlistdata.dart';
import 'package:lehengas_choli_online_shopping/fragments/ShippingPolicy.dart';
import 'package:lehengas_choli_online_shopping/fragments/order.dart';
import 'package:lehengas_choli_online_shopping/fragments/policy.dart';
import 'package:lehengas_choli_online_shopping/services/secure_storage.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  int goto;

  HomePage(this.goto);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> {


  int _selectedDrawerIndex = 0;
  bool isOpenDialog = false;
  String title = "Create Your Style";


  String message = "Hello " +
      constantAppDataResponse.data.companyname +
      " I need your help regarding purchasing of one of your product";

  bool islogin = false;

  @override
  void dispose() {
    super.dispose();
  }


  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getProfileImage();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      getProfileImage();
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

  getProfileImage() async {
    if (user_id == null) {
      setState(() {
        islogin = false;
      });
    } else {
      setState(() {
        islogin = true;
      });
    }
  }


  @override
  void initState() {
    if (widget.goto != 0) {
      Future.delayed(Duration.zero, () async {
        _onSelectItemDirect(widget.goto);
      });
    }
    checkConnection();
    super.initState();
  }


  _onSelectItem(int index) {
    Navigator.of(context).pop();
    setState(() => _selectedDrawerIndex = index);
    // close the drawer
  }

  _onSelectItemDirect(int index) {
    setState(() => _selectedDrawerIndex = index);
    // close the drawer
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Createyourstyle();
        break;
      case 1:
        return CartScreen();
        break;
      case 2:
        return CustomNotification();
        break;
      case 3:
        return Order();
        break;
      case 4:
        return Account();
        break;
      case 5:
        return Wishlistdata();
        break;
      case 6:
        return AboutusScreen();
        break;
      case 7:
        return Policy();
        break;
      case 8:
        return ShippingPolicy();
        break;
      case 9:
        return Return_Policy();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        title: title,
        login: islogin,
      ),
      drawer: Drawer(
        child: Container(
          color: PrimaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('assets/images/close.svg',
                          color: Colors.white),
                    ),
                  ),
                ),
                customFunction(),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Divider(
                    color: Colors.white,
                    height: 0.0,
                    thickness: 1.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              title = "Create Your Style";
                            });
                            _onSelectItem(0);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/home.svg",
                                  color: Colors.white),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: Opacity(
                            opacity: 0.2,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Divider(
                                color: Colors.white,
                                height: 0.0,
                                thickness: 1.0,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                title = "Cart";
                              });
                              _onSelectItem(1);
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/images/drawer_cart.svg",
                                    color: Colors.white),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width - 200,
                                  child: Text(
                                    "Cart",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: Opacity(
                            opacity: 0.2,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Divider(
                                color: Colors.white,
                                height: 0.0,
                                thickness: 1.0,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                title = "Notification";
                              });
                              _onSelectItem(2);
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/images/notification.svg",
                                    color: Colors.white),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                ),
                                Text(
                                  "Notification",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: Opacity(
                            opacity: 0.2,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Divider(
                                color: Colors.white,
                                height: 0.0,
                                thickness: 1.0,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                title = "Orders";
                              });
                              _onSelectItem(3);
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/order.svg",
                                    color: Colors.white),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                ),
                                Text(
                                  "Order",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: Opacity(
                            opacity: 0.2,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Divider(
                                color: Colors.white,
                                height: 0.0,
                                thickness: 1.0,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                title = "Account";
                              });
                              _onSelectItem(4);
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/account.svg",
                                    color: Colors.white),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                ),
                                Text(
                                  "Account",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: Opacity(
                            opacity: 0.2,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Divider(
                                color: Colors.white,
                                height: 0.0,
                                thickness: 1.0,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                title = "Wishlist";
                              });
                              _onSelectItem(5);
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/wishlist.svg",
                                    color: Colors.white),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                ),
                                Text(
                                  "Your Wishlist",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Divider(
                              color: Colors.white,
                              height: 0.0,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            FlutterOpenWhatsapp.sendSingleMessage(
                                constantAppDataResponse.data.whatsappnumber,
                                "I need  help  \n my user id : ${await getStringFromLocalStorage(
                                    DEVICEID)} \n  ");
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/whatsapp_small.svg", width: 25,
                                height: 25,
                                color: Colors.white,
                                fit: BoxFit.fill,),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              ),
                              Text(
                                "Live Chat",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Opacity(
                          opacity: 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Divider(
                              color: Colors.white,
                              height: 0.0,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            instagram(
                                userid: constantAppDataResponse.data.instagram);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/instagram.svg", width: 25,
                                height: 25,
                                color: Colors.white,
                                fit: BoxFit.fill,),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              ),
                              Text(
                                "Follows us on Insta",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Opacity(
                          opacity: 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Divider(
                              color: Colors.white,
                              height: 0.0,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              title = "About Us";
                            });
                            _onSelectItem(6);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/about.svg",
                                  color: Colors.white),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              ),
                              Text(
                                "About us",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Opacity(
                          opacity: 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Divider(
                              color: Colors.white,
                              height: 0.0,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            rateUs();
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/rateus.svg",
                                  color: Colors.white),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              ),
                              Text(
                                "Rate us",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Opacity(
                          opacity: 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Divider(
                              color: Colors.white,
                              height: 0.0,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            sendEmail();
                          },
                          child: Row(
                            children: [
                              InkWell(
                                child: SvgPicture.asset(
                                    "assets/images/contactus.svg",
                                    color: Colors.white),
                                onTap: () {
                                  sendEmail();
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              ),
                              Text(
                                "Contact us",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Opacity(
                          opacity: 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Divider(
                              color: Colors.white,
                              height: 0.0,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              title = "Privacy Policy";
                            });
                            _onSelectItem(7);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/policy.svg",
                                  color: Colors.white),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              ),
                              Text(
                                "Privacy Policy",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Opacity(
                          opacity: 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Divider(
                              color: Colors.white,
                              height: 0.0,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              title = "Shipping Policy";
                            });
                            _onSelectItem(8);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/policy.svg",
                                  color: Colors.white),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              ),
                              Text(
                                "Shipping Policy",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Opacity(
                          opacity: 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Divider(
                              color: Colors.white,
                              height: 0.0,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              title = "Return Policy";
                            });
                            _onSelectItem(9);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/policy.svg",
                                  color: Colors.white),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              ),
                              Text(
                                "Return Policy",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Opacity(
                          opacity: 0.2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Divider(
                              color: Colors.white,
                              height: 0.0,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            shareApp(title);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/share.svg",
                                  color: Colors.white),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              ),
                              Text(
                                "Share",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: Opacity(
                            opacity: 0.2,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Divider(
                                color: Colors.white,
                                height: 0.0,
                                thickness: 1.0,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: islogin ? true : false,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) {
                                    return Login();
                                  }), (Route<dynamic> route) => false);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              color: DarkPrimaryColor,
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/images/logout.svg",
                                      color: Colors.white),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  ),
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }

  Widget customFunction() {
    if (islogin) {
      return Row(
        children: [
          Container(
              width: 60.0,
              height: 58.0,
              margin: EdgeInsets.fromLTRB(10, 12, 0, 0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: profile_pic != null
                          ? NetworkImage(profile_pic)
                          : NetworkImage(
                          "http://lehengascholi.com/public/product/60068001c07a5_product.png")))),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fullname != null
                    ? Text(fullname,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white, fontSize: 15))
                    : SizedBox(),
                email != null
                    ? Text(email,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white, fontSize: 12))
                    : SizedBox()
              ],
            ),
          )
        ],
      );
    } else {
      return Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                    return Login();
                  }), (Route<dynamic> route) => false);
            },
            child: Container(
              height: 100,
              alignment: Alignment.centerLeft,
              child: Text(
                "Log In",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ));
    }
  }

  void rateUs() {
    RateMyApp _rateMyApp = RateMyApp(
        preferencesPrefix: 'rateapp',
        minDays: 0,
        minLaunches: 0,
        remindDays: 0,
        remindLaunches: 0);

    _rateMyApp.launchStore();
  }


  void instagram({@required userid}) async {
    var instaurl = 'https://instagram.com/_u/$userid/';
    if (await canLaunch(instaurl)) {
      await launch(
        instaurl,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $instaurl';
    }
  }

  void sendEmail() async {
    String message = "Hello " + constantAppDataResponse.data.companyname;
    final Email email = Email(
      body: message,
      subject: 'I need your help regarding purchasing of one of your product',
      recipients: [constantAppDataResponse.data.contactusemail],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  Future<void> shareApp(String title) async {
    await FlutterShare.share(
        title: 'Hyy Fashion Stars',
        text:
        'I found a app which has lot of trending products with affordable price.check out this app',
        linkUrl: constantAppDataResponse.data.shareUrl,
        chooserTitle: constantAppDataResponse.data.companyname);
  }
}
