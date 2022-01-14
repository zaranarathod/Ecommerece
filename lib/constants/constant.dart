import 'package:flutter/material.dart';
import 'package:lehengas_choli_online_shopping/models/AcoountResponse.dart';
import 'package:lehengas_choli_online_shopping/models/GetAppDataResponse.dart';
import 'package:lehengas_choli_online_shopping/models/ProductlistResponse.dart';
import 'package:lehengas_choli_online_shopping/models/WishlistResponse.dart';

const String KEY_IS_FIRST_TIME = "isFirstTime";

const String API_KEY = "AIzaSyBoEepHzc4n-uo8iddWgM-yFsFET_v0g5U";

const Color PrimaryColor = Color(0XFFD12F7E);
const Color DarkPrimaryColor = Color(0XFFBC2A71);

const String BASE_URL = "https://lehengascholi.com/api/";

GetAppDataResponse constantAppDataResponse;

AccountResponse constantaccountDataResponse;

ProductlistResponse Productlist;

List<Cart> constantcartDataResponse = [];

List<WishListData> constantWishlistDataResponse = [];

List<Addresses> constantAddressDataResponse = [];

List<OrderStatus> constantorderResponse = [];


//String user_id = "";
const String USER_ID = "USER_ID";

//String email_id = "";
const String EMAIL_ID = "EMAIL_ID";

//String user_full_name = "";
const String USER_FULL_NAME = "USER_FULL_NAME";

//String phone_number = "123";
const String PHONE_NUMBER = "PHONE_NUMBER";

//String profile_pic = "";
const String PROFILE_PIC = "PROFILE_PIC";

//String first_name = "";
const String FIRST_NAME = "FIRST_NAME";

//String last_name = "";
const String LAST_NAME = "LAST_NAME";

//String gendar = "male";
const String GENDAR = "GENDAR";

//String birthday = "1-1-1998";
const String BIRTHDAY = "BIRTHDAY";

const String FTOKEN = "FTOKEN";

//String deviceid = "";
const String DEVICEID = "DEVICEID";

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

String profile_pic, user_id, fullname, email;
int count;


