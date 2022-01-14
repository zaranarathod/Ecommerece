import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lehengas_choli_online_shopping/common/check_connection_alert_dialog.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/models/FacebookResponse%20.dart';
import 'package:lehengas_choli_online_shopping/models/GoogleLogInresponse.dart';
import 'package:lehengas_choli_online_shopping/services/apis.dart';
import 'package:lehengas_choli_online_shopping/services/secure_storage.dart';
import 'package:lottie/lottie.dart';
import '../constants/constant.dart';
import '../services/apis.dart';
import '../services/secure_storage.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _loginstate createState() => _loginstate();
}

// ignore: camel_case_types
class _loginstate extends State<Login> {
  bool isOpenDialog = false;
  bool shimmer = false;


  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'profile',
    'https://www.googleapis.com/auth/user.phonenumbers.read',
    'https://www.googleapis.com/auth/userinfo.profile',
    'https://www.googleapis.com/auth/user.addresses.read',
    'https://www.googleapis.com/auth/user.birthday.read',
    'https://www.googleapis.com/auth/user.gender.read',
  ]);
  FirebaseAuth _auth;
  bool isUserSignedIn = false;


  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      checkLoginStatus();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      checkLoginStatus();
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

  checkLoginStatus() async {
    removeStringFromLocalStorage(DEVICEID);
    removeStringFromLocalStorage(USER_ID);
    removeStringFromLocalStorage(EMAIL_ID);
    removeStringFromLocalStorage(USER_FULL_NAME);
    removeStringFromLocalStorage(PHONE_NUMBER);
    removeStringFromLocalStorage(PROFILE_PIC);
    removeStringFromLocalStorage(FIRST_NAME);
    removeStringFromLocalStorage(LAST_NAME);
    removeStringFromLocalStorage(GENDAR);
    removeStringFromLocalStorage(BIRTHDAY);
    constantaccountDataResponse = null;
    profile_pic = null;
    user_id = null;
    fullname = null;
    email = null;
    count = null;

    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();
    if (!userSignedIn) {
      final AccessToken accessToken = await FacebookAuth.instance.accessToken;
      if (accessToken != null) {
        await FacebookAuth.instance.logOut();
        userSignedIn = false;
      } else {
        userSignedIn = false;
      }
    }
    setState(() {
      isUserSignedIn = userSignedIn;
    });
  }

  Future<User> _handleSignIn() async {
    // hold the instance of the authenticated user
    User user;
    // flag to check whether we're signed in already
    bool userSignedIn = await _googleSignIn.isSignedIn();
    setState(() {
      isUserSignedIn = userSignedIn;
    });
    if (userSignedIn) {
      // if so, return the current user
      user = _auth.currentUser;
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;


      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      if (googleUser.id != null) {
        saveStringToLocalStorage(USER_ID, googleUser.id);
      }

      if (googleUser.email != null) {
        saveStringToLocalStorage(EMAIL_ID, googleUser.email);
      }

      user = (await _auth.signInWithCredential(credential)).user;

      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });
    }
    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    User user;
    if (isUserSignedIn) {
      await _googleSignIn.signOut();
      isUserSignedIn = false;
      onGoogleSignIn(context);
    } else {
      user = await _handleSignIn();

      if (user.uid != null) {
        saveStringToLocalStorage(DEVICEID, user.uid);
      }

      if (user.displayName != null) {
        saveStringToLocalStorage(USER_FULL_NAME, user.displayName);
      }

      if (user.phoneNumber != null) {
        saveStringToLocalStorage(PHONE_NUMBER, user.phoneNumber);
      }

      if (user.photoURL != null) {
        saveStringToLocalStorage(PROFILE_PIC, user.photoURL);
      }

      setState(() {
        shimmer = true;
      });

      final headers = await _googleSignIn.currentUser.authHeaders;
      GoogleLogInResponse data = await getGoogleData(headers);

      if (data == null) {
        Fluttertoast.showToast(
            msg: "Something went wrong!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      } else {
        if (data.names != null) {
          saveStringToLocalStorage(FIRST_NAME, data.names.first.givenName);
          saveStringToLocalStorage(LAST_NAME, data.names.first.familyName);
        }

        if (data.genders != null) {
          saveStringToLocalStorage(GENDAR, data.genders.first.formattedValue);
        }


        print(data.birthdays[0].date.toString());
        if (data.birthdays != null) {
          String birthday;

          birthday = data.birthdays.first.date.month
              .toString()
              .length == 1 ?
          data.birthdays.first.date.year.toString() + "/" +
              "0${data.birthdays.first.date.month}" + "/" +
              data.birthdays.first.date.day.toString() :
          data.birthdays.first.date.year.toString() + "/" +
              data.birthdays.first.date.month.toString() + "/" +
              data.birthdays.first.date.day.toString();
          saveStringToLocalStorage(BIRTHDAY, birthday);
        }

        if (data.phoneNumbers != null) {
          saveStringToLocalStorage(PHONE_NUMBER, data.phoneNumbers.first.value);
        }
        callCreateProfile(0);
      }
    }
  }

  void onFacebookClick() async {
    _auth = FirebaseAuth.instance;
    await FacebookAuth.instance.logOut();

    try {
      LoginResult resutl = await FacebookAuth.instance.login(permissions: [
        'email',
        'public_profile',
        'user_birthday',
        'user_gender'
      ],);
      AccessToken accessToken = resutl.accessToken;
      final AuthCredential credential = FacebookAuthProvider.credential(
          accessToken.token);
      final result = await _auth.signInWithCredential(credential);

      if (accessToken.userId != null) {
        saveStringToLocalStorage(USER_ID, accessToken.userId);
      }

      if (result.user.uid != null) {
        saveStringToLocalStorage(DEVICEID, result.user.uid);
      }

      if (result.user.displayName != null) {
        saveStringToLocalStorage(USER_FULL_NAME, result.user.displayName);
      }

      if (result.user.phoneNumber != null) {
        saveStringToLocalStorage(PHONE_NUMBER, result.user.phoneNumber);
      }

      if (result.user.photoURL != null) {
        saveStringToLocalStorage(PROFILE_PIC, result.user.photoURL);
      }

      setState(() {
        shimmer = true;
      });

      FacebookResponse data = await getFacebookData(accessToken.token);

      if (data == null) {
        Fluttertoast.showToast(
            msg: "Something went wrong!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      } else {
        if (data.firstName != null) {
          saveStringToLocalStorage(FIRST_NAME, data.firstName);
        }

        if (data.lastName != null) {
          saveStringToLocalStorage(LAST_NAME, data.lastName);
        }

        if (data.email != null) {
          saveStringToLocalStorage(EMAIL_ID, data.email);
        }

        if (data.gender != null) {
          saveStringToLocalStorage(GENDAR, data.gender);
        }

        if (data.birthday != null) {
          saveStringToLocalStorage(BIRTHDAY, data.birthday);
        }
        callCreateProfile(1);
      }
    } on FacebookAuthErrorCode catch (e) {
      switch (e.toString()) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          Fluttertoast.showToast(
              msg: "You canclelled operation",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
          break;
        case FacebookAuthErrorCode.FAILED:
          Fluttertoast.showToast(
              msg: "Something went wrong!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1);
          break;
      }
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
    return SafeArea(
      child: WillPopScope(
          onWillPop: () => Future.value(false),
          child: Stack(
            children: [
              image,
              Container(
                margin: EdgeInsets.only(top: 62, left: 35),
                child: Text("Welcome Back",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      decoration: TextDecoration.none,
                    )),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                          )),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 20, left: 39),
                                  child: Text("Sign In",
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        decoration: TextDecoration.none,
                                      ))),
                              shimmer
                                  ? Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 50),
                                  width: 150,
                                  height: 150,
                                  child: Lottie.asset(
                                      'assets/json/splash_loader.json'),
                                ),
                              )
                                  : Container(
                                child: Column(
                                  children: [
                                    constantAppDataResponse.data.login.length ==
                                        2
                                        ? _signInButton()
                                        : constantAppDataResponse.data
                                        .login[0] == "1"
                                        ? _signInButton()
                                        : SizedBox(),
                                    constantAppDataResponse.data.login.length ==
                                        2
                                        ? _facebookButton()
                                        : constantAppDataResponse.data
                                        .login[0] == "0"
                                        ? _facebookButton()
                                        : SizedBox(),
                                    _skipButton()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      )))
            ],
          )),
    );
  }

  Widget _signInButton() {
    return Center(
        child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Visibility(
              visible: shimmer ? false : true,
              child: OutlineButton(
                splashColor: PrimaryColor,
                onPressed: () {
                  onGoogleSignIn(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)
                ),
                highlightElevation: 0,
                borderSide: BorderSide(color: PrimaryColor),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          image: AssetImage("assets/images/google_logo.png"),
                          height: 35.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Google   ',
                          style: TextStyle(
                            fontSize: 20,
                            color: PrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget _facebookButton() {
    return Center(
        child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Visibility(
              visible: shimmer ? false : true,
              child: OutlineButton(
                splashColor: PrimaryColor,
                onPressed: () {
                  onFacebookClick();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                highlightElevation: 0,
                borderSide: BorderSide(color: PrimaryColor),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          image: AssetImage("assets/images/facebook-logo.png"),
                          height: 35.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Facebook',
                          style: TextStyle(
                            fontSize: 20,
                            color: PrimaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget _skipButton() {
    return Center(
        child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Visibility(
              visible: shimmer ? false : true,
              child: OutlineButton(
                splashColor: PrimaryColor,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(0)),
                          (route) => false);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                highlightElevation: 0,
                borderSide: BorderSide(color: PrimaryColor),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        child: Image(
                            image: AssetImage("assets/images/skip.png"),
                            height: 35.0),
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70, right: 100),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 20,
                            color: PrimaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }

  void callCreateProfile(int i) async {
    var map = new Map<String, dynamic>();

    String user_full_name = await getStringFromLocalStorage(USER_FULL_NAME);

    if (user_full_name != null) {
      map['fullname'] = user_full_name;
    }

    String first_name = await getStringFromLocalStorage(FIRST_NAME);
    if (first_name != null) {
      map['firstname'] = first_name;
    }

    String last_name = await getStringFromLocalStorage(LAST_NAME);
    if (last_name != null) {
      map['lastname'] = last_name;
    }

    String phone_number = await getStringFromLocalStorage(PHONE_NUMBER);
    if (phone_number != null) {
      map['phone'] = phone_number;
    }

    String birthday = await getStringFromLocalStorage(BIRTHDAY);
    if (birthday != null) {
      map['dob'] = birthday;
    }

    String user_id2 = await getStringFromLocalStorage(USER_ID);
    if (user_id2 != null) {
      if (i == 0) {
        map['google_id'] = user_id2;
      } else {
        map['facebook_id'] = user_id2;
      }
    }

    String email_id = await getStringFromLocalStorage(EMAIL_ID);
    if (email_id != null) {
      map['email'] = email_id;
    }

    String gendar = await getStringFromLocalStorage(GENDAR);
    if (gendar != null) {
      map['gender'] = gendar;
    }

    String deviceid = await getStringFromLocalStorage(DEVICEID);
    if (deviceid != null) {
      map['uuid'] = deviceid;
    }

    String ftoken = await getStringFromLocalStorage(FTOKEN);
    if (ftoken != null) {
      map['f_token'] = ftoken;
    }

    final createProfileResponse = await getProfile(map);

    if (createProfileResponse.success == true) {
      setState(() {
        shimmer = false;
      });
      constantaccountDataResponse = createProfileResponse;
      if (constantaccountDataResponse != null) {
        if (constantaccountDataResponse.success == true) {
          user_id = await getStringFromLocalStorage(USER_ID);
          profile_pic = await getStringFromLocalStorage(PROFILE_PIC);
          email = await getStringFromLocalStorage(EMAIL_ID);
          fullname = await getStringFromLocalStorage(USER_FULL_NAME);
          count = constantaccountDataResponse.data.userdata.cart.length;

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
            timeInSecForIosWeb: 1);
      }
    } else {
      setState(() {
        shimmer = false;
      });
      Fluttertoast.showToast(
          msg: "Something went wrong!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }
}
