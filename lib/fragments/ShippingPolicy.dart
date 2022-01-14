import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShippingPolicy extends StatefulWidget {
  @override
  _ShippingPolicyState createState() => _ShippingPolicyState();
}

class _ShippingPolicyState extends State<ShippingPolicy> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: constantAppDataResponse.data.shippingpolicylink,
      gestureRecognizers: Set()
        ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),
    );
  }
}
