# url_launcher

[![pub package](https://img.shields.io/pub/v/url_launcher.svg)](https://pub.dartlang.org/packages/url_launcher)

A Flutter plugin for launching a URL in the mobile platform. Supports iOS, Android, web, Windows,
macOS, and Linux.

## Usage

To use this plugin, add `url_launcher` as
a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

### Example

``` dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Scaffold(
    body: Center(
      child: RaisedButton(
        onPressed: _launchURL,
        child: Text('Show Flutter homepage'),
      ),
    ),
  ));
}

_launchURL() async {
  const url = 'https://flutter.dev';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

```

## Supported URL schemes

The [`launch`](https://www.dartdocs.org/documentation/url_launcher/latest/url_launcher/launch.html)
method takes a string argument containing a URL. This URL can be formatted using a number of
different URL schemes. The supported URL schemes depend on the underlying platform and installed
apps.

Common schemes supported by both iOS and Android:

| Scheme | Action |
|---|---|
| `http:<URL>` , `https:<URL>`, e.g. `http://flutter.dev` | Open URL in the default browser |
| `mailto:<email address>?subject=<subject>&body=<body>`, e.g. `mailto:smith@example.org?subject=News&body=New%20plugin` | Create email to <email address> in the default email app |
| `tel:<phone number>`, e.g. `tel:+1 555 010 999` | Make a phone call to <phone number> using the default phone app |
| `sms:<phone number>`, e.g. `sms:5550101234` | Send an SMS message to <phone number> using the default messaging app |

More details can be found here
for [iOS](https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html)
and [Android](https://developer.android.com/guide/components/intents-common.html)

### Encoding URLs

URLs must be properly encoded, especially when including spaces or other special characters. This
can be done using the [`Uri` class](https://api.dart.dev/stable/2.7.1/dart-core/Uri-class.html):

```dart
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';

final Uri _emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'smith@example.com',
  queryParameters: {
    'subject': 'Example Subject & Symbols are allowed!'
  }
);

// ...

// mailto:smith@example.com?subject=Example+Subject+%26+Symbols+are+allowed%21
launch(_emailLaunchUri.toString());
```

## Handling missing URL receivers

A particular mobile device may not be able to receive all supported URL schemes. For example, a
tablet may not have a cellular radio and thus no support for launching a URL using the `sms` scheme,
or a device may not have an email app and thus no support for launching a URL using the `email`
scheme.

We recommend checking which URL schemes are supported using the
[`canLaunch`](https://www.dartdocs.org/documentation/url_launcher/latest/url_launcher/canLaunch.html)
method prior to calling `launch`. If the `canLaunch` method returns false, as a best practice we
suggest adjusting the application UI so that the unsupported URL is never triggered; for example, if
the `email` scheme is not supported, a UI button that would have sent email can be changed to
redirect the user to a web page using a URL following the `http` scheme.

## Browser vs In-app Handling

By default, Android opens up a browser when handling URLs. You can pass
`forceWebView: true` parameter to tell the plugin to open a WebView instead. If you do this for a
URL of a page containing JavaScript, make sure to pass in
`enableJavaScript: true`, or else the launch method will not work properly. On iOS, the default
behavior is to open all web URLs within the app. Everything else is redirected to the app handler.
