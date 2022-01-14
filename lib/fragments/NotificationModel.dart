import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/services/apis.dart';
import 'package:lehengas_choli_online_shopping/services/secure_storage.dart';
import 'package:lottie/lottie.dart';

class CustomNotification extends StatefulWidget {
  @override
  _CustomNotificationState createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification> {
  var lstnotifiy = [];
  var newlstnotifiy = [];
  var earlierlstnotifiy = [];
  bool isprogress = true;

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  void getNotifications() async {
    var map = new Map<String, dynamic>();
    map["uuid"] = await getStringFromLocalStorage(DEVICEID);
    var noti = await getNotification(map);
    lstnotifiy = noti.data.notification;

    lstnotifiy.forEach((element) {
      if (element.earlier == "1") {
        earlierlstnotifiy.add(element);
      } else {
        newlstnotifiy.add(element);
      }
    });

    setState(() {
      isprogress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isprogress
            ? Center(
            child: Container(
                width: 100,
                height: 100,
                child: Lottie.asset("assets/json/splash_loader.json")))
            : Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              newlstnotifiy.isEmpty
                  ? SizedBox()
                  : Text(
                "New",
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 14,
                    fontFamily: 'Poppins'),
              ),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              newlstnotifiy.isEmpty
                  ? Container(
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Lottie.asset(
                        "assets/json/No-notification.json"),
                    Text(
                      "You have no Currently Notification..",
                      style: TextStyle(
                          fontSize: 15.0, fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              )
                  : ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: newlstnotifiy.length,
                  separatorBuilder: (context, index) =>
                      Divider(
                        color: Colors.black12,
                        height: 20.0,
                        thickness: 1.0,
                      ),
                  itemBuilder: (BuildContext context, int index) =>
                      NewNotiListItem(index)),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              newlstnotifiy.isEmpty
                  ? SizedBox()
                  : Text(
                "Earlier",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins'),
              ),
              newlstnotifiy.isEmpty
                  ? SizedBox()
                  : Padding(padding: EdgeInsets.only(bottom: 15.0)),
              newlstnotifiy.isEmpty
                  ? SizedBox()
                  : ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: earlierlstnotifiy.length,
                  separatorBuilder: (context, index) =>
                      Divider(
                        color: Colors.black12,
                        height: 20.0,
                        thickness: 1.0,
                      ),
                  itemBuilder: (BuildContext context, int index) =>
                      EarlierNotiListItem(index)),
            ],
          ),
        ),
      ),
    );
  }

  EarlierNotiListItem(index) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(earlierlstnotifiy[index].image),
        ),
        Padding(padding: EdgeInsets.only(left: 10.2)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                earlierlstnotifiy[index].title,
                style: TextStyle(
                    fontSize: 15, color: Colors.black, fontFamily: 'Poppins'),
              ),
              Text(
                earlierlstnotifiy[index].description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12, color: Colors.grey, fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  NewNotiListItem(index) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(newlstnotifiy[index].image),
        ),
        Padding(padding: EdgeInsets.only(left: 10.2)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newlstnotifiy[index].title,
                style: TextStyle(
                    fontSize: 15, color: Colors.black, fontFamily: 'Poppins'),
              ),
              Text(
                newlstnotifiy[index].description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12, color: Colors.grey, fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
