import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/fragments/Placeorder.dart';
import 'package:lehengas_choli_online_shopping/models/ProductlistResponse.dart';

class CustomAppBar extends PreferredSize {
  final double height;
  final String title;
  final bool login;


  CustomAppBar({this.height = kToolbarHeight,
    @required this.title,
    @required this.login});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: preferredSize.height,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState.openDrawer();
                  },
                  child: SvgPicture.asset('assets/images/menu.svg',
                      color: Colors.black),
                ),
                Center(
                    child: Text(title,
                        style: TextStyle(color: Colors.black, fontSize: 30))),
                Visibility(visible: login ? count >= 1 ? true : false : false,
                  child: InkWell(onTap: () {
                    if (constantcartDataResponse.isEmpty) {
                      return;
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Placeorder(constantcartDataResponse, false)));
                  },
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: SvgPicture.asset('assets/images/cart.svg'),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Text(
                                count.toString(),
                                style: TextStyle(color: Colors.white,
                                    fontSize: 9),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(new Radius.circular(10.0)),
                                  color: Colors.pink),
                              padding: EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
                              margin: EdgeInsets.only(left: 8),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
