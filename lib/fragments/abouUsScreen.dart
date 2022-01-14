import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutusScreen extends StatefulWidget {
  @override
  _AboutusScreenState createState() => _AboutusScreenState();
}

class _AboutusScreenState extends State<AboutusScreen> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: constantAppDataResponse.data.aboutuslink,
      gestureRecognizers: Set()
        ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),
    );
  }
}
