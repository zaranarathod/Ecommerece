import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class Policy extends StatefulWidget {

  @override
  _PolicyState createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: constantAppDataResponse.data.privacypolicylink,
      gestureRecognizers: Set()
        ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),
    );
  }
}
