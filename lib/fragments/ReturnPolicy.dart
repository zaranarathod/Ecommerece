import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Return_Policy extends StatefulWidget {
  @override
  _Return_PolicyState createState() => _Return_PolicyState();
}

class _Return_PolicyState extends State<Return_Policy> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: constantAppDataResponse.data.returnpolicylink,
      gestureRecognizers: Set()
        ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),
    );
  }
}
