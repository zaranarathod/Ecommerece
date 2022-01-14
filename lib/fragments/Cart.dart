import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/models/AcoountResponse.dart';
import 'package:lehengas_choli_online_shopping/models/ProductlistResponse.dart';
import 'package:lehengas_choli_online_shopping/services/apis.dart';
import 'package:lehengas_choli_online_shopping/services/secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'Placeorder.dart';
import 'Product_detail.dart';


class CartScreen extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  bool isanimation = false;
  var total = 0.0;

  @override
  void initState() {
    super.initState();
    getCartlists();
  }

  void getCartlists() async {
    constantcartDataResponse.forEach((element) {
      total = total +
          double.parse(element.productDiscountRate) *
              double.parse(element.pcount);
    });
  }

  incrementCounter(index) {
    if (int.parse(constantcartDataResponse[index].pcount) >= 10) {
      return;
    }
    setState(() {
      constantcartDataResponse[index].pcount =
          (int.parse(constantcartDataResponse[index].pcount) + 1).toString();
      counter(constantcartDataResponse[index]);
    });
  }

  decrementConter(index) {
    if (int.parse(constantcartDataResponse[index].pcount) <= 1) {
      return;
    }
    setState(() {
      constantcartDataResponse[index].pcount =
          (int.parse(constantcartDataResponse[index].pcount) - 1).toString();
      counter(constantcartDataResponse[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isanimation
          ? Center(
          child: Container(
              width: 150,
              height: 150,
              child: Lottie.asset("assets/json/Circularlodding.json")))
          : constantcartDataResponse.isEmpty
          ? Center(
        child: Container(
            margin:
            EdgeInsets.only(top: 80.0, left: 20.0),
            width: 300.0,
            height: 350.0,
            child: Column(children: [
              Lottie.asset(
                  "assets/json/emptyCart.json"),
              Text(
                "You have no Currently Product in Cart..",
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Poppins'),
              ),
            ])),
      ) : Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                margin:
                EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Products :",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.pink,
                          fontFamily: 'Poppins'),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery
                            .of(context)
                            .size
                            .height,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: constantcartDataResponse.length,
                        itemBuilder: (context, index) {
                          return CartItem(index);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                  ],
                ),
              ),
            ),
            constantcartDataResponse.isEmpty ? SizedBox() : FooterBtn1(),
          ],
        ),
      ),
    );
  }

  CartItem(index) {
    return InkWell(
      onTap: () {
        List<Products> abc = [];
        Products selectedProduct;

        Productlist.data.products.forEach((element) {
          if (constantcartDataResponse[index].pid == element.pid) {
            selectedProduct = element;
            return;
          }
        });

        Productlist.data.products
          ..forEach((element) {
            if (selectedProduct.productCategory ==
                element.productCategory) {
              if (element.productCode != selectedProduct.productCode) {
                abc.add(element);
              }
            }
          });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Product_detail(selectedProduct, abc)));
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.only(
              left: 5.0, top: 10.0, bottom: 10.0, right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image(
                          height: 107.0,
                          width: 75.0,
                          image: NetworkImage(
                              constantcartDataResponse[index].productImages),
                          fit: BoxFit.fill)),
                  Padding(padding: EdgeInsets.only(left: 7.0)),
                  Container(
                    width: 180.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          constantcartDataResponse[index].productCode,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Poppins',
                              color: Colors.black),
                        ),
                        Text(
                          constantcartDataResponse[index].productName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Poppins',
                              color: Colors.grey),
                        ),
                        Text(
                          constantcartDataResponse[index].ColorName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Poppins',
                              color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Text(
                              "\u20B9" +
                                  constantcartDataResponse[index]
                                      .productDiscountRate,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                  color: Colors.pink),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(
                              "\u20B9" +
                                  constantcartDataResponse[index].productPrice,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 25.0,
                    height: 72.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.pink),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          child: Container(
                            width: 25,
                            child: Column(children: [
                              Text(
                                "+",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                          ),
                          onTap: () {
                            incrementCounter(index);
                          },
                        ),
                        Divider(
                          height: 1,
                          color: Colors.pink,
                        ),
                        Column(children: [
                          Text(
                            constantcartDataResponse[index].pcount,
                            style: TextStyle(fontSize: 16),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 6.0)),
                        ]),
                        Divider(
                          height: 1,
                          color: Colors.pink,
                        ),
                        InkWell(
                          child: Container(
                            width: 25,
                            child: Column(children: [
                              Text(
                                "-",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                          ),
                          onTap: () {
                            setState(() {
                              decrementConter(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 5.0)),
                  InkWell(
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                          color: PrimaryColor,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Container(
                        width: 12,
                        height: 15,
                        padding: EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          "assets/images/garbage-can.svg",
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        removecartlist(constantcartDataResponse[index]);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  FooterBtn1() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ButtonBar(
            children: [
              Container(
                width: 160,
                height: 39,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.pink[50],
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '\u20B9$total',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              RaisedButton(
                  color: PrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onPressed: () {
                    if (constantcartDataResponse.isEmpty) {
                      return;
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Placeorder(constantcartDataResponse, false)));
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: 13.0, bottom: 12.0, left: 15.0)),
                        SvgPicture.asset("assets/images/buy-cart.svg",
                            color: Colors.white),
                        Padding(padding: EdgeInsets.only(left: 8.2)),
                        Text(
                          "Place Order",
                          style: TextStyle(
                              fontSize: 16.0, fontFamily: 'Poppins'),
                        ),
                        Padding(padding: EdgeInsets.only(left: 15.2)),
                      ],
                    ),
                  )),
            ],),
        ],
      ),
    );
  }

  removecartlist(Cart data) async {
    setState(() {
      isanimation = true;
    });
    var map = new Map<String, dynamic>();
    map["uuid"] = await getStringFromLocalStorage(DEVICEID);
    map["pid"] = data.pid.toString();
    map["color_id"] = data.Colorid.toString();
    map["deletecart"] = 1.toString();

    var cartlist = await getCartlist(map);
    setState(() {
      if (cartlist.data.isNotEmpty) {
        count = cartlist.data.length;
        constantcartDataResponse.clear();
        constantcartDataResponse.addAll(cartlist.data);
        if (constantcartDataResponse != null &&
            constantcartDataResponse.isNotEmpty) {
          constantcartDataResponse.forEach((element) {
            constantAppDataResponse.data.colorslist.forEach((element1) {
              if (element1.id == element.Colorid) {
                element.ColorName = element1.name;
              }
            });
          });
        }
        total = 0;
        constantcartDataResponse.forEach((element) {
          total = total +
              double.parse(element.productDiscountRate) *
                  double.parse(element.pcount);
        });
      } else {
        count = 0;
        constantcartDataResponse.clear();
        total = 0;
      }
      isanimation = false;
    });
  }

  counter(Cart data) async {
    var map = Map<String, dynamic>();
    map['uuid'] = await getStringFromLocalStorage(DEVICEID);
    map['pid'] = data.pid.toString();
    map["color_id"] = data.Colorid.toString();
    map['pcount'] = data.pcount.toString();
    map['updatecart'] = 1.toString();
    var cartlist = await getCartlist(map);
    setState(() {
      if (cartlist.data.isNotEmpty) {
        constantcartDataResponse.clear();
        constantcartDataResponse.addAll(cartlist.data);
        if (constantcartDataResponse != null &&
            constantcartDataResponse.isNotEmpty) {
          constantcartDataResponse.forEach((element) {
            constantAppDataResponse.data.colorslist.forEach((element1) {
              if (element1.id == element.Colorid) {
                element.ColorName = element1.name;
              }
            });
          });
        }
        total = 0;
        constantcartDataResponse.forEach((element) {
          total = total +
              double.parse(element.productDiscountRate) *
                  double.parse(element.pcount);
        });
      } else {
        constantcartDataResponse.clear();
        total = 0;
      }
    });
  }
}
