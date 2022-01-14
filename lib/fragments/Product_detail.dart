import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lehengas_choli_online_shopping/activity/login.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/fragments/Placeorder.dart';
import 'package:lehengas_choli_online_shopping/models/AcoountResponse.dart';
import 'package:lehengas_choli_online_shopping/models/ProductlistResponse.dart';
import 'package:lehengas_choli_online_shopping/services/apis.dart';
import 'package:lehengas_choli_online_shopping/services/secure_storage.dart';
import 'package:lottie/lottie.dart';

class Customer {
  String name;
  String value;

  Customer(this.name, this.value);

  String getName() {
    return '${this.name}';
  }

  String getValue() {
    return '${this.value}';
  }
}

class Product_detail extends StatefulWidget {
  List<Products> multiproduct = [];

  Products singleproducts;

  Product_detail(this.singleproducts, this.multiproduct);

  @override
  _Product_detailState createState() => _Product_detailState();
}

class _Product_detailState extends State<Product_detail> {
  String uuid = "";
  var addlist = [];
  bool isheart = false;
  bool incart = false;
  int selectesindex = 0;
  bool login = false;
  bool isanimation = false;
  int colorid = 1;
  SwiperController _swiperController = SwiperController();

  @override
  void initState() {
    widget.singleproducts.productColor.forEach((element) {
      if (element.isSelected) {
        colorid = element.id;
        return;
      }
    });
    getDate();
    super.initState();
  }

  getDate() async {
    addlist.clear();
    widget.singleproducts.additionalInfo.forEach((element) {
      element.forEach((k, v) => addlist.add(Customer(k, v)));
    });
    constantWishlistDataResponse.forEach((element) {
      if (widget.singleproducts.pid == element.pid) {
        setState(() {
          isheart = true;
        });
        return;
      } else {
        setState(() {
          isheart = false;
        });
      }
    });
    constantcartDataResponse.forEach((element) {
      if (widget.singleproducts.pid == element.pid) {
        setState(() {
          incart = true;
        });
        return;
      } else {
        setState(() {
          incart = false;
        });
      }
    });
    uuid = await getStringFromLocalStorage(DEVICEID);
  }

  Future<void> shareApp() async {
    await FlutterShare.share(
        title: 'Hyy Fashion Stars',
        text:
        'I found a app which has lot of trending products with affordable price.check out this app',
        linkUrl: constantAppDataResponse.data.shareUrl,
        chooserTitle: constantAppDataResponse.data.companyname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          constantAppDataResponse.data.companyname,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: isanimation
          ? Center(
          child: Container(
              width: 150,
              height: 150,
              child: Lottie.asset("assets/json/Circularlodding.json")))
          : Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 262,
                            width: 60,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: widget
                                  .singleproducts.productImages.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: Container(
                                    padding:
                                    EdgeInsets.only(bottom: 11.0),
                                    child: Container(
                                      width: 51,
                                      height: 70,
                                      decoration: index == selectesindex
                                          ? BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(
                                            8.0),
                                        border: Border.all(
                                            color: Colors.pink,
                                            width: 1.0),
                                      )
                                          : BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(
                                            8.0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        child: Image.network(
                                            widget.singleproducts
                                                .productImages[index],
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectesindex = index;
                                      _swiperController.move(
                                          selectesindex,
                                          animation: true);
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: 14.0)),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 100,
                        child: Center(
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 180,
                            height: 298,
                            child: Swiper(
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image(
                                      image: NetworkImage(
                                        widget.singleproducts
                                            .productImages[index],
                                      ),
                                      fit: BoxFit.fill,
                                    ));
                              },
                              itemHeight: 298,
                              controller: _swiperController,
                              itemWidth:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width - 100,
                              itemCount:
                              widget.singleproducts.productImages.length,
                              layout: SwiperLayout.DEFAULT,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.singleproducts.productCode,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins'),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              shareApp();
                            },
                            child: SvgPicture.asset(
                                "assets/images/share.svg",
                                color: Colors.pink),
                          ),
                          Padding(padding: EdgeInsets.only(right: 20.0)),
                          GestureDetector(
                            child: isheart
                                ? SvgPicture.asset(
                              "assets/images/heart (11).svg",
                              color: Colors.pink,
                            )
                                : SvgPicture.asset(
                              "assets/images/heart (10).svg",
                              color: Colors.pink,
                            ),
                            onTap: () {
                              setState(() {
                                isheart = !isheart;
                              });
                              if (uuid == null) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                        (route) => false);
                              } else {
                                isheart
                                    ? wishlistadd(widget
                                    .singleproducts.pid
                                    .toString())
                                    : wishlistRemove(widget
                                    .singleproducts.pid
                                    .toString());
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 5.0)),
                  Text(
                    widget.singleproducts.productName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins'),
                  ),
                  Padding(padding: EdgeInsets.only(top: 12.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          widget.singleproducts.discountEnable == "1" ? Text(
                            "\u20B9" +
                                widget.singleproducts.productDiscountRate,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.pink,
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins'),
                          ) : Text(
                            "\u20B9" +
                                widget.singleproducts.productPrice,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.pink,
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins'),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10.0)),
                          widget.singleproducts.discountEnable == "1" ? Text(
                            "\u20B9" + widget.singleproducts.productPrice,
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 15.0,
                                fontFamily: 'Poppins'),
                          ) : SizedBox(),
                        ],
                      ),
                      Row(
                        children: [
                          widget.singleproducts.discountEnable == "1" ? Text(
                            widget.singleproducts.productDiscount +
                                "% off",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins'),
                          ) : SizedBox()
                        ],
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 12.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset("assets/images/quality.svg",
                              color: Colors.pink),
                          Padding(padding: EdgeInsets.only(top: 4.0)),
                          Text(
                            "Best",
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins'),
                          ),
                          Text(
                            "Quality",
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                              "assets/images/delivery-truck (1).svg",
                              color: Colors.pink),
                          Padding(padding: EdgeInsets.only(top: 4.0)),
                          Text(
                            "Express",
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                          Text(
                            "Delivery",
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                              "assets/images/free-delivery.svg",
                              color: Colors.pink),
                          Padding(padding: EdgeInsets.only(top: 4.0)),
                          Text(
                            "Free",
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                          Text(
                            "Shipping",
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset("assets/images/location.svg",
                              color: Colors.pink),
                          Padding(padding: EdgeInsets.only(top: 4.0)),
                          Text(
                            "Free",
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                          Text(
                            "Shipping",
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 12.0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Colors :",
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: 14.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins'),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        height: 30.0,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          children: widget.singleproducts.productColor.map((
                              ProductColor colorlist) {
                            return InkWell(
                                onTap: () async {
                                  setState(() {
                                    colorid = colorlist.id;
                                    widget.singleproducts.productColor.forEach((
                                        element) {
                                      element.isSelected = false;
                                    });
                                    colorlist.isSelected = true;
                                  });
                                },
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(left: 4.0, right: 4.0),
                                  child: Container(
                                    width: 50.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(7.0),
                                        border: Border.all(
                                            color: colorlist.isSelected
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: 2.0),
                                        color: HexColor(colorlist.colorCode)),
                                  ),
                                ));
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 12.0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Information :",
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: 14.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins'),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Text(
                        widget.singleproducts.productInformation,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 100,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 13.0,
                            fontFamily: 'Poppins'),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Text(
                        "Additional information :",
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: 14.0,
                            decoration: TextDecoration.none,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 12.0)),
                  setProductInformation(),
                  Padding(padding: EdgeInsets.only(top: 12.0)),
                  widget.multiproduct.isNotEmpty
                      ? Text(
                    "Similar Products",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins'),
                  )
                      : SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                  ),
                  widget.multiproduct.isNotEmpty
                      ? ListViewfilterItem()
                      : SizedBox(),
                  SizedBox(
                    height: widget.multiproduct.isNotEmpty ? 40.0 : 20.0,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 15.0, bottom: 60.0),
                child: GestureDetector(
                  onTap: () async {
                    FlutterOpenWhatsapp.sendSingleMessage(
                        constantAppDataResponse.data.whatsappnumber,
                        "I have query regarding one of your product ${widget
                            .singleproducts
                            .productCode} \n my userid : ${await getStringFromLocalStorage(
                            DEVICEID)} \n ");
                  },
                  child: Image.asset("assets/images/whatsapp.png"),
                ),
              ),
            ),
            FooterBtn(),
          ],
        ),
      ),
    );
  }

  setProductInformation() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: addlist.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: PrimaryColor, width: 0.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 150,
                color: Color(int.parse("0xffF4CEE0")),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(addlist[index].getName(),
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins')),
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 172,
                color: Color(int.parse("0xffFAE9F1")),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(addlist[index].getValue(),
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ListViewfilterItem() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.multiproduct.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.singleproducts = widget.multiproduct[index];
                });
              },
              child: Container(
                width: 100.0,
                margin: EdgeInsets.only(right: 11.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image(
                            height: 150.0,
                            width: 100.0,
                            image: NetworkImage(
                                widget.multiproduct[index].productImages[0]),
                            fit: BoxFit.fill)),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 3.0,
                        )),
                    Text(
                      widget.multiproduct[index].productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontFamily: 'Poppins'),
                    ),
                    Row(
                      children: [
                        widget.multiproduct[index].discountEnable == "1" ? Text(
                          "\u20B9" +
                              widget.multiproduct[index].productDiscountRate,
                          style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins'),
                        ) : Text(
                          "\u20B9" + widget.multiproduct[index].productPrice,
                          style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins'),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              left: 3.0,
                            )),
                        widget.multiproduct[index].discountEnable == "1" ? Text(
                          "\u20B9" + widget.multiproduct[index].productPrice,
                          style: TextStyle(
                              fontSize: 9.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'Poppins'),
                        ) : SizedBox(),
                        Padding(
                            padding: EdgeInsets.only(
                              left: 3.0,
                            )),
                        widget.multiproduct[index].discountEnable == "1" ? Text(
                          widget.multiproduct[index].productDiscount + "%",
                          style: TextStyle(
                              fontSize: 8.0,
                              color: Colors.green,
                              decoration: TextDecoration.none,
                              fontFamily: 'Poppins'),
                        ) : SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ),
      ),
    );
  }

  FooterBtn() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: incart ? MainAxisAlignment.center : MainAxisAlignment
            .spaceEvenly,
        children: <Widget>[
          ButtonBar(
            children: [
              incart
                  ? SizedBox()
                  : RaisedButton(
                textColor: Colors.black,
                color: Colors.pink[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                onPressed: () {
                  if (uuid == null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                            (route) => false);
                  } else {
                    addcartlist(widget.singleproducts);
                  }
                },
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 12.0, left: 13.0)),
                    SvgPicture.asset("assets/images/buy-cart.svg",
                        color: Colors.black),
                    Padding(padding: EdgeInsets.only(left: 10.2)),
                    Text(
                      "Add to cart",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10.2)),
                  ],
                ),
              ),
              RaisedButton(
                  color: PrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onPressed: () {
                    if (uuid == null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                              (route) => false);
                    } else {
                      List<Cart> products = [];
                      var cName = "";
                      constantAppDataResponse.data.colorslist.forEach((
                          element) {
                        if (element.id == colorid) {
                          cName = element.name;
                        }
                      });


                      products.add(Cart(
                          pid: widget.singleproducts.pid,
                          Colorid: colorid,
                          ColorName: cName,
                          saveforlater: "0",
                          pcount: "1",
                          productName: widget.singleproducts.productName,
                          productCode: widget.singleproducts.productCode,
                          productDiscountRate:
                          widget.singleproducts.productDiscountRate,
                          productImages: widget.singleproducts.productImages[0],
                          productInformation:
                          widget.singleproducts.productInformation,
                          productPrice: widget.singleproducts.productPrice));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Placeorder(products, true)));
                    }
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 12.0, left: 13.0)),
                        SvgPicture.asset("assets/images/buy-cart.svg",
                            color: Colors.white),
                        Padding(padding: EdgeInsets.only(left: 10.2)),
                        Text(
                          "Buy now",
                          style:
                          TextStyle(fontSize: 16.0, fontFamily: 'Poppins'),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10.2)),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  void addcartlist(Products singleproducts) async {
    var map2 = new Map<String, dynamic>();
    map2['uuid'] = uuid;
    map2['pid'] = singleproducts.pid.toString();
    map2['color_id'] = colorid.toString();
    map2['pcount'] = 1.toString();
    map2['pamount'] = singleproducts.productDiscountRate.toString();
    var Cartlist = await getCartlist(map2);
    setState(() {
      if (Cartlist != null) {
        constantcartDataResponse.clear();
        constantcartDataResponse.addAll(Cartlist.data);
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
        count = constantcartDataResponse.length;
        incart = true;
      }
    });
  }

  void wishlistadd(String data) async {
    var map = Map<String, dynamic>();
    map['color_id'] = colorid.toString();
    map['uuid'] = uuid;
    map['pid'] = data;
    print(map.toString());
    var response = await getWishlist(map);
    if (response != null) {
      setState(() {
        constantWishlistDataResponse.clear();
        constantWishlistDataResponse.addAll(response.data);
        if (constantWishlistDataResponse != null &&
            constantWishlistDataResponse.isNotEmpty) {
          constantWishlistDataResponse.forEach((element) {
            constantAppDataResponse.data.colorslist.forEach((element1) {
              if (element1.id == element.Colorid) {
                element.ColorName = element1.name;
              }
            });
          });
        }
      });
    }
  }

  void wishlistRemove(String data) async {
    var map = Map<String, dynamic>();
    map['uuid'] = uuid;
    map['color_id'] = colorid.toString();
    map['pid'] = data;
    map['deletewishlist'] = 1.toString();
    print(map.toString());
    var response = await getWishlist(map);
    if (response != null) {
      setState(() {
        constantWishlistDataResponse.clear();
        constantWishlistDataResponse.addAll(response.data);
        if (constantWishlistDataResponse != null &&
            constantWishlistDataResponse.isNotEmpty) {
          constantWishlistDataResponse.forEach((element) {
            constantAppDataResponse.data.colorslist.forEach((element1) {
              if (element1.id == element.Colorid) {
                element.ColorName = element1.name;
              }
            });
          });
        }
      });
    }
  }
}
