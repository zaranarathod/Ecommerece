import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lehengas_choli_online_shopping/activity/GlobalText.dart';

connectionDialog(BuildContext context, [Function function]) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Oops you are not connected to internet!",
          maxLines: 2,
        ),
        actions: [
          FlatButton(
              onPressed: () {
                SystemNavigator.pop();
                // connectionDialog(context);
                // Navigator.pop(context);
              },
              child: Text("cancel")),
          FlatButton(
              onPressed: () {
                // Navigator.pop(context);
                // connectionDialog(context);
                function();
              },
              child: Text("Retry"))
        ],
      );
    },
  );
}

vpnDialog(BuildContext context, [Function function]) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: GlobalText(
          "Please turn off vpn!",
          maxLines: 2,
        ),
        actions: [
          FlatButton(
              onPressed: () {
                function();
              },
              child: GlobalText("Retry"))
        ],
      );
    },
  );
}

