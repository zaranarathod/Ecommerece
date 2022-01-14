import 'package:flutter/material.dart';

class GlobalText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color color;
  final double fontSize, paddingTop, paddingBottom, paddingRight, paddingLeft;
  final int maxLines;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;

  GlobalText(this.text,
      {this.fontSize,
        this.fontWeight,
        this.textAlign,
        this.color = Colors.black,
        this.paddingTop = 0.0,
        this.paddingLeft = 0.0,
        this.paddingRight = 0.0,
        this.paddingBottom = 0.0,
        this.maxLines = 1,
        this.textDecoration});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: paddingTop,
          bottom: paddingBottom,
          right: paddingRight,
          left: paddingLeft),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: "Raleway-Regular",
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: textDecoration,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
