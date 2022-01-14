import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/models/AcoountResponse.dart';
import 'package:lehengas_choli_online_shopping/models/CartResponse.dart';
import 'package:lehengas_choli_online_shopping/models/FacebookResponse%20.dart';
import 'package:lehengas_choli_online_shopping/models/GetAppDataResponse.dart';
import 'package:lehengas_choli_online_shopping/models/GoogleLogInresponse.dart';
import 'package:lehengas_choli_online_shopping/models/NotificationResponse.dart';
import 'package:lehengas_choli_online_shopping/models/OrderResponse.dart';
import 'package:lehengas_choli_online_shopping/models/ProductlistResponse.dart';
import 'package:lehengas_choli_online_shopping/models/UserAddressResponse.dart';
import 'package:lehengas_choli_online_shopping/models/WishlistResponse.dart';

Future<GetAppDataResponse> getAppData() async {
  final String url = BASE_URL + "getappdata";
  final response = await http.get(Uri.parse(url));

  GetAppDataResponse appDataResponse;
  print(response.body);
  if (response.statusCode == 200) {
    appDataResponse = GetAppDataResponse.fromJson(jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(
        msg: "Something went wrong!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }
  return appDataResponse;
}

Future<GoogleLogInResponse> getGoogleData(Map<String, String> headers) async {
  final String url =
      "https://people.googleapis.com/v1/people/me?personFields=birthdays,phoneNumbers,names,genders&key=" +
          API_KEY;

  final r =
  await http.get(
      Uri.parse(url), headers: {"Authorization": headers["Authorization"]});

  GoogleLogInResponse googleLogInResponse;
  if (r.statusCode == 200) {
    googleLogInResponse = GoogleLogInResponse.fromJson(jsonDecode(r.body));
  } else {
    Fluttertoast.showToast(
        msg: "Something went wrong!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }
  return googleLogInResponse;
}

Future<FacebookResponse> getFacebookData(String token) async {
  final String url =
      "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,gender,birthday&access_token=" +
          token;

  final r = await http.get(Uri.parse(url));
  print(r.body);
  FacebookResponse facebookResponse;

  if (r.statusCode == 200) {
    facebookResponse = FacebookResponse.fromJson(jsonDecode(r.body));
  } else {
    Fluttertoast.showToast(
        msg: "Something went wrong!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }
  return facebookResponse;
}

Future<AccountResponse> getProfile(var map) async {
  print(map.toString());
  final String url = BASE_URL + "userregister";
  final response = await http.post(Uri.parse(url), body: map);

  print(response.body);

  AccountResponse createProfile;
  if (response.statusCode == 200) {
    createProfile = AccountResponse.fromJson(jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(
        msg: "Something went wrong!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }
  return createProfile;
}

Future<NotificationResponse> getNotification(var map) async {
  final String url = BASE_URL + "notification";
  final response = await http.post(Uri.parse(url), body: map);

  NotificationResponse createnotification;

  if (response.statusCode == 200) {
    createnotification =
        NotificationResponse.fromJson(jsonDecode(response.body));
  }
  return createnotification;
}

Future<AccountResponse> getUserData(var map) async {
  final String url = BASE_URL + "userdetail";
  final response = await http.post(Uri.parse(url), body: map);

  print(map);
  AccountResponse createUserData;
  print(response.body);

  if (response.statusCode == 200) {
    createUserData = AccountResponse.fromJson(jsonDecode(response.body));
  }
  return createUserData;
}


Future<ProductlistResponse> getproductlist(int id) async {
  final String url = BASE_URL + "productlist?page=$id";
  final response = await http.get(Uri.parse(url));

  ProductlistResponse createProduct;
  if (response.statusCode == 200) {
    createProduct = ProductlistResponse.fromJson(jsonDecode(response.body));
  }
  return createProduct;
}

Future<CartResponse> getCartlist(var map) async {
  print(map);
  final String url = BASE_URL + "cart";
  final response = await http.post(Uri.parse(url), body: map);
  CartResponse createcart;
  print(response.body);
  if (response.statusCode == 200) {
    createcart = CartResponse.fromJson(jsonDecode(response.body));
  }
  return createcart;
}

Future<WishlistResponse> getWishlist(var map) async {
  final String url = BASE_URL + "wishlist";
  final response = await http.post(Uri.parse(url), body: map);

  WishlistResponse createwishlist;
  print(response.body);
  if (response.statusCode == 200) {
    createwishlist = WishlistResponse.fromJson(jsonDecode(response.body));
  }
  return createwishlist;
}

Future<UserAddressResponse> getUserAddresslist(var map) async {
  final String url = BASE_URL + "useraddress";
  print(map);
  final response = await http.post(Uri.parse(url), body: map);

  UserAddressResponse createuseraddress;
  print(response.body);
  if (response.statusCode == 200) {
    createuseraddress = UserAddressResponse.fromJson(jsonDecode(response.body));
  }
  return createuseraddress;
}


Future<OrderResponse> order(var map) async {
  final String url = BASE_URL + "order";
  final response = await http.post(Uri.parse(url), body: map);

  OrderResponse createwishlist;
  print(map);
  print("data");
  print(response.body);
  if (response.statusCode == 200) {
    createwishlist = OrderResponse.fromJson(jsonDecode(response.body));
  }
  return createwishlist;
}
