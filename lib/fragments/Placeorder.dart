import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lehengas_choli_online_shopping/activity/GlobalText.dart';
import 'package:lehengas_choli_online_shopping/activity/home.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/models/AcoountResponse.dart';
import 'package:lehengas_choli_online_shopping/models/ItemClass.dart';
import 'package:lehengas_choli_online_shopping/services/apis.dart';
import 'package:lehengas_choli_online_shopping/services/secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Placeorder extends StatefulWidget {
  List<Cart> tempProducts;
  bool buynow;

  Placeorder(this.tempProducts, this.buynow);

  @override
  _PlaceorderState createState() => _PlaceorderState();
}

class _PlaceorderState extends State<Placeorder> {
  List<Cart> products = [];

  var selectedValue = 'Radio';
  int valueselect = constantAddressDataResponse.isEmpty
      ? 0
      : constantAddressDataResponse.first.addressId;
  int selectposition = 0;

  var producttotal = 0.0;
  var finaltotal = 0.0;
  var discount = 0.0;

  var isAnimation = false;

  var selecedCODPayment = true;
  Razorpay _razorpay;

  @override
  void initState() {
    _razorpay = Razorpay();

    if (constantAppDataResponse.data.paymenttype.length <= 1) {
      if (constantAppDataResponse.data.paymenttype[0] == "0") {
        selectedValue = "Radio";
        selecedCODPayment = true;
      } else {
        selectedValue = "Radio1";
        selecedCODPayment = false;
      }
    } else {
      selectedValue = "Radio";
      selecedCODPayment = true;
    }


    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    products.addAll(widget.tempProducts);
    products.forEach((element) {
      setState(() {
        producttotal = producttotal +
            double.parse(element.productPrice) * double.parse(element.pcount);
        discount = discount +
            double.parse(element.productPrice) * double.parse(element.pcount) -
            double.parse(element.productDiscountRate) *
                double.parse(element.pcount);
      });
    });

    if (selecedCODPayment) {
      setState(() {
        finaltotal = producttotal -
            discount +
            double.parse(constantAppDataResponse.data.codCouriercharge);
      });
    } else {
      setState(() {
        finaltotal = producttotal - discount;
      });
    }

    super.initState();
  }

  incrementConter(index) {
    if (int.parse(products[index].pcount) >= 10) {
      return;
    }
    setState(() {
      products[index].pcount =
          (int.parse(products[index].pcount) + 1).toString();
      producttotal = 0.0;
      discount = 0.0;
      finaltotal = 0.0;
      products.forEach((element) {
        producttotal = producttotal +
            double.parse(element.productPrice) * double.parse(element.pcount);
        discount = discount +
            double.parse(element.productPrice) * double.parse(element.pcount) -
            double.parse(element.productDiscountRate) *
                double.parse(element.pcount);
      });

      if (selecedCODPayment) {
        finaltotal = producttotal -
            discount +
            double.parse(constantAppDataResponse.data.codCouriercharge);
      } else {
        finaltotal = producttotal - discount;
      }
      Counter(products[index]);
    });
  }

  decrementConter(index) {
    if (int.parse(products[index].pcount) <= 1) {
      return;
    }
    setState(() {
      products[index].pcount =
          (int.parse(products[index].pcount) - 1).toString();
      producttotal = 0.0;
      discount = 0.0;
      finaltotal = 0.0;
      products.forEach((element) {
        producttotal = producttotal +
            double.parse(element.productPrice) * double.parse(element.pcount);
        discount = discount +
            double.parse(element.productPrice) * double.parse(element.pcount) -
            double.parse(element.productDiscountRate) *
                double.parse(element.pcount);
      });

      if (selecedCODPayment) {
        finaltotal = producttotal -
            discount +
            double.parse(constantAppDataResponse.data.codCouriercharge);
      } else {
        finaltotal = producttotal - discount;
      }
      Counter(products[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Place Order",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
      body: isAnimation
          ? Center(
          child: Container(
              width: 100,
              height: 100,
              child: Lottie.asset("assets/json/splash_loader.json")))
          : Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selected Address : ",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.pink,
                        fontFamily: 'Poppins'),
                  ),
                  constantAddressDataResponse.isEmpty
                      ? SizedBox()
                      : Dropdownlist(),
                  Padding(padding: EdgeInsets.only(left: 5.0)),
                  constantAddressDataResponse.isEmpty
                      ? RaisedButton(
                    color: Colors.pink[50],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    onPressed: () {
                      setState(() {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HomePage(4)),
                                (route) => false);
                      });
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Poppins'),
                    ),
                  )
                      : SizedBox(),
                  Padding(padding: EdgeInsets.only(bottom: 10.0)),
                  constantAddressDataResponse.isEmpty
                      ? SizedBox()
                      : AddressList(),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                  ),
                  ProductCart(),
                  Pricedetail(),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ),
          FooterBtn1(),
        ],
      ),
    );
  }

  Dropdownlist() {
    return Row(
      children: [
        Container(
          width: 230,
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.pink)),
          child: Row(children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 5.0)),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: valueselect,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  isDense: true,
                  style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                  onChanged: (int newvalue) {
                    setState(() {
                      valueselect = newvalue;
                      for (int i = 0;
                      i < constantAddressDataResponse.length;
                      i++) {
                        if (constantAddressDataResponse[i].addressId ==
                            valueselect) {
                          selectposition = i;
                        }
                      }
                    });
                  },
                  items: constantAddressDataResponse?.map((item) {
                    return DropdownMenuItem(
                        value: item.addressId, child: Text(item.fullname));
                  })?.toList() ??
                      [],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  AddressList() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.pink,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address :",
                style: TextStyle(
                    fontSize: 14.0, color: Colors.pink, fontFamily: 'Poppins'),
              ),
              Row(
                children: [
                  addressListItem(),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  addressListItem() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            children: [
              addressRowItem(
                "Full Name",
              ),
              Text(
                constantAddressDataResponse[selectposition].fullname,
                style: TextStyle(
                    color: Colors.black, fontSize: 12, fontFamily: 'Poppins'),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            children: [
              addressRowItem("address 1"),
              Text(
                constantAddressDataResponse[(selectposition)].address1,
                style: TextStyle(
                    color: Colors.black, fontSize: 12, fontFamily: 'Poppins'),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            children: [
              addressRowItem("address 2"),
              Text(
                constantAddressDataResponse[(selectposition)].address2,
                style: TextStyle(
                    color: Colors.black, fontSize: 12, fontFamily: 'Poppins'),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            children: [
              addressRowItem("Pin Code"),
              Text(
                constantAddressDataResponse[(selectposition)].pincode,
                style: TextStyle(
                    color: Colors.black, fontSize: 12, fontFamily: 'Poppins'),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            children: [
              addressRowItem("City"),
              Text(
                constantAddressDataResponse[(selectposition)].city,
                style: TextStyle(
                    color: Colors.black, fontSize: 12, fontFamily: 'Poppins'),
              )
            ],
          ),
          Row(
            children: [
              addressRowItem("State"),
              Text(
                constantAddressDataResponse[(selectposition)].state,
                style: TextStyle(
                    color: Colors.black, fontSize: 12, fontFamily: 'Poppins'),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            children: [
              addressRowItem("Address Type"),
              Text(
                constantAddressDataResponse[(selectposition)].addressType == "0"
                    ? "Resident"
                    : "Business",
                style: TextStyle(
                    color: Colors.black, fontSize: 12, fontFamily: 'Poppins'),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Contact : ",
                style: TextStyle(
                    fontSize: 14, color: Colors.pink, fontFamily: 'Poppins'),
              ),

              Text(
                "+91" +
                    constantAddressDataResponse[(selectposition)].mobileNumber,
                style: TextStyle(
                    color: Colors.black, fontSize: 12, fontFamily: 'Poppins'),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 245.0)),
              SizedBox(
                height: 26.0,
                width: 60,
                child: RaisedButton(
                    color: PrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(4)),
                              (route) => false);
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Poppins'),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  addressRowItem(name) {
    return Row(
      children: [
        Text(
          name,
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
          maxLines: 5,
        ),
        GlobalText(
          " : ",
          paddingLeft: 2.0,
          paddingRight: 2.0,
        ),
      ],
    );
  }

  ProductCart() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Products :",
            style: TextStyle(
                fontSize: 14.0, color: Colors.pink, fontFamily: 'Poppins'),
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: products.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CartItem(index);
            },
          ),
          Padding(padding: EdgeInsets.only(top: 25.0)),
        ],
      ),
    );
  }

  CartItem(index) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 10.0, right: 5.0),
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
                      image: NetworkImage(products[index].productImages),
                      fit: BoxFit.fill)),
              Padding(padding: EdgeInsets.only(left: 7.0)),
              Container(
                width: 180.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products[index].productCode,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Poppins',
                          color: Colors.black),
                    ),
                    Text(
                      products[index].productName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Poppins',
                          color: Colors.grey),
                    ),
                    Text(
                      products[index].ColorName,
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
                          "\u20B9" + products[index].productDiscountRate,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Poppins',
                              color: Colors.pink),
                        ),
                        Padding(padding: EdgeInsets.only(left: 10.0)),
                        Text(
                          "\u20B9" + products[index].productPrice,
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        incrementConter(index);
                      },
                    ),
                    Divider(
                      height: 1,
                      color: Colors.pink,
                    ),
                    Column(children: [
                      Text(
                        products[index].pcount,
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
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
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
                  if (products.length == 1) {
                    removecartlistitem(products[index]);
                    producttotal = 0.0;
                    discount = 0.0;
                    finaltotal = 0.0;
                    products.forEach((element) {
                      producttotal = producttotal +
                          double.parse(element.productPrice) *
                              double.parse(element.pcount);
                      discount = discount +
                          double.parse(element.productPrice) *
                              double.parse(element.pcount) -
                          double.parse(element.productDiscountRate) *
                              double.parse(element.pcount);
                    });

                    if (selecedCODPayment) {
                      finaltotal = producttotal -
                          discount +
                          double.parse(
                              constantAppDataResponse.data.codCouriercharge);
                    } else {
                      finaltotal = producttotal - discount;
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(4)),
                            (route) => false);
                  } else {
                    removecartlistitem(products[index]);
                    setState(() {
                      products.removeAt(index);
                      producttotal = 0.0;
                      discount = 0.0;
                      finaltotal = 0.0;
                      products.forEach((element) {
                        producttotal = producttotal +
                            double.parse(element.productPrice) *
                                double.parse(element.pcount);
                        discount = discount +
                            double.parse(element.productPrice) *
                                double.parse(element.pcount) -
                            double.parse(element.productDiscountRate) *
                                double.parse(element.pcount);
                      });

                      if (selecedCODPayment) {
                        finaltotal = producttotal -
                            discount +
                            double.parse(
                                constantAppDataResponse.data.codCouriercharge);
                      } else {
                        finaltotal = producttotal - discount;
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Pricedetail() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.pink,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price Details",
                style: TextStyle(
                    fontSize: 14.0, color: Colors.pink, fontFamily: 'Poppins'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 14.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price(${products.length} item)",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  ),

                  Text(
                    "\u20B9$producttotal",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discount",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  ),

                  Text(
                    "\u20B9$discount",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  )
                ],
              ),
              Row(
                children: [
                  constantAppDataResponse.data.paymenttype.length <= 1
                      ? constantAppDataResponse.data.paymenttype[0] == "0" ?
                  Radio(
                    value: 'Radio',
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                        selecedCODPayment = true;
                        producttotal = 0.0;
                        discount = 0.0;
                        finaltotal = 0.0;
                        products.forEach((element) {
                          producttotal = producttotal +
                              double.parse(element.productPrice) *
                                  double.parse(element.pcount);
                          discount = discount +
                              double.parse(element.productPrice) *
                                  double.parse(element.pcount) -
                              double.parse(element.productDiscountRate) *
                                  double.parse(element.pcount);
                        });

                        if (selecedCODPayment) {
                          finaltotal = producttotal -
                              discount +
                              double.parse(constantAppDataResponse
                                  .data.codCouriercharge);
                        } else {
                          finaltotal = producttotal - discount;
                        }
                      });
                    },
                  ) :
                  SizedBox()
                      :
                  Radio(
                    value: 'Radio',
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                        selecedCODPayment = true;
                        producttotal = 0.0;
                        discount = 0.0;
                        finaltotal = 0.0;
                        products.forEach((element) {
                          producttotal = producttotal +
                              double.parse(element.productPrice) *
                                  double.parse(element.pcount);
                          discount = discount +
                              double.parse(element.productPrice) *
                                  double.parse(element.pcount) -
                              double.parse(element.productDiscountRate) *
                                  double.parse(element.pcount);
                        });

                        if (selecedCODPayment) {
                          finaltotal = producttotal -
                              discount +
                              double.parse(constantAppDataResponse
                                  .data.codCouriercharge);
                        } else {
                          finaltotal = producttotal - discount;
                        }
                      });
                    },
                  ),
                  constantAppDataResponse.data.paymenttype.length <= 1
                      ? constantAppDataResponse.data.paymenttype[0] == "0"
                      ? Text('COD')
                      : SizedBox()
                      :
                  Text('COD'),
                  Padding(
                    padding: EdgeInsets.only(left: 50.0),
                  ),
                  constantAppDataResponse.data.paymenttype.length <= 1
                      ? constantAppDataResponse.data.paymenttype[0] == "1"
                      ? Radio(
                    value: 'Radio1',
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                        selecedCODPayment = false;
                        producttotal = 0.0;
                        discount = 0.0;
                        finaltotal = 0.0;
                        products.forEach((element) {
                          producttotal = producttotal +
                              double.parse(element.productPrice) *
                                  double.parse(element.pcount);
                          discount = discount +
                              double.parse(element.productPrice) *
                                  double.parse(element.pcount) -
                              double.parse(element.productDiscountRate) *
                                  double.parse(element.pcount);
                        });

                        if (selecedCODPayment) {
                          finaltotal = producttotal -
                              discount +
                              double.parse(constantAppDataResponse
                                  .data.codCouriercharge);
                        } else {
                          finaltotal = producttotal - discount;
                        }
                      });
                    },
                  )
                      : SizedBox()
                      :
                  Radio(
                    value: 'Radio1',
                    groupValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                        selecedCODPayment = false;
                        producttotal = 0.0;
                        discount = 0.0;
                        finaltotal = 0.0;
                        products.forEach((element) {
                          producttotal = producttotal +
                              double.parse(element.productPrice) *
                                  double.parse(element.pcount);
                          discount = discount +
                              double.parse(element.productPrice) *
                                  double.parse(element.pcount) -
                              double.parse(element.productDiscountRate) *
                                  double.parse(element.pcount);
                        });

                        if (selecedCODPayment) {
                          finaltotal = producttotal -
                              discount +
                              double.parse(constantAppDataResponse
                                  .data.codCouriercharge);
                        } else {
                          finaltotal = producttotal - discount;
                        }
                      });
                    },
                  ),
                  constantAppDataResponse.data.paymenttype.length <= 1
                      ? constantAppDataResponse.data.paymenttype[0] == "1"
                      ? Text('Prepaid')
                      : SizedBox()
                      :
                  Text('Prepaid'),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 7.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery charges",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  ),

                  Text(
                    selecedCODPayment
                        ? '\u20B9' +
                        '${constantAppDataResponse.data.codCouriercharge}'
                        : "\u20B90.0",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 7.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total amount",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  ),

                  Text(
                    "\u20B9" + "$finaltotal",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 7.0),
        ),
        Text(
          "You will save \u20B9$discount on this order",
          style: TextStyle(
              fontSize: 10.0, color: Colors.green, fontFamily: 'Poppins'),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
        ),
      ]),
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
                      "\u20B9$finaltotal",
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
                      if (valueselect == 0) {
                        Fluttertoast.showToast(
                            msg: "Enter Address to further proceed",
                            timeInSecForIosWeb: 4);
                        return;
                      }
                      if (selecedCODPayment) {
                        if (finaltotal > double.parse(
                            constantAppDataResponse.data.maxAmountCod)) {
                          Fluttertoast.showToast(
                              msg: "Max COD order amount is \u20B9${constantAppDataResponse
                                  .data.maxAmountCod}",
                              timeInSecForIosWeb: 4);
                        } else {
                          callCODPAyment();
                        }
                      } else {
                        callRazorPayPayment();
                      }
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 13.0, bottom: 12.0, left: 15.0)),
                          SvgPicture.asset("assets/images/buy-cart.svg",
                              color: Colors.white),
                          Padding(padding: EdgeInsets.only(left: 25.2)),
                          Text(
                            "Continue",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: 'Poppins'),
                          ),
                          Padding(padding: EdgeInsets.only(left: 15.2)),
                        ],
                      ),
                    )),
              ],
              alignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max),
        ],
      ),
    );
  }

  void removecartlistitem(Cart data) async {
    var map = Map<String, dynamic>();
    map['uuid'] = await getStringFromLocalStorage(DEVICEID);
    map['pid'] = data.pid.toString();
    map['deletecart'] = 1.toString();
    var cartlist = await getCartlist(map);

    if (cartlist.data.isEmpty) {
      constantcartDataResponse.clear();
    } else {
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
    }
  }

  void Counter(Cart data) async {
    var map = Map<String, dynamic>();
    map['uuid'] = await getStringFromLocalStorage(DEVICEID);
    map['pid'] = data.pid.toString();
    map['pcount'] = data.pcount.toString();
    map['updatecart'] = 1.toString();
    var cartlist = await getCartlist(map);

    if (cartlist.data.isEmpty) {
      constantcartDataResponse.clear();
    } else {
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
    }
  }

  void callRazorPayPayment() async {
    var options = {
      'key': '${constantAppDataResponse.data.razorpay}',
      'amount': finaltotal.toInt() * 100,
      'name': '${constantAppDataResponse.data.companyname}',
      'prefill': {'email': '$email', 'name': '$fullname'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void callCODPAyment() async {
    setState(() {
      isAnimation = true;
    });

    var map = Map<String, dynamic>();
    map['uuid'] = await getStringFromLocalStorage(DEVICEID);

    var list = [];
    list.clear();

    products.forEach((element) {
      ItemClass itemClass = ItemClass(
          element.pid.toString(), element.pcount, element.Colorid.toString());
      list.add(itemClass);
    });

    map['product'] = jsonEncode(list);
    map['address_id'] = valueselect.toString();
    map['payment_type'] = 0.toString();
    map['updated_wallet_balance'] = 0.toString();
    map['total_amount'] = finaltotal.toString();

    var cartlist = await order(map);

    if (cartlist != null) {
      if (cartlist.data.order.isNotEmpty) {
        constantorderResponse.clear();
        constantorderResponse.addAll(cartlist.data.order);
        if (constantorderResponse != null && constantorderResponse.isNotEmpty) {
          constantorderResponse.forEach((element) {
            constantAppDataResponse.data.colorslist.forEach((element1) {
              element.product.forEach((element2) {
                if (element2.Colorid == element1.id) {
                  element2.ColorName = element1.name;
                }
              });
            });
          });
        }

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
      }
      if (!widget.buynow) {
        constantcartDataResponse.clear();
      }
    }
    setState(() {
      isAnimation = false;
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(3)),
            (route) => false);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() {
      isAnimation = true;
    });

    var map = Map<String, dynamic>();
    map['uuid'] = await getStringFromLocalStorage(DEVICEID);

    var list = [];
    list.clear();

    products.forEach((element) {
      ItemClass itemClass = ItemClass(
          element.pid.toString(), element.pcount, element.Colorid.toString());
      list.add(itemClass);
    });

    map['product'] = jsonEncode(list);
    map['address_id'] = valueselect.toString();
    map['payment_type'] = 1.toString();
    map['payment_transaction_id'] = response.paymentId.toString();
    map['updated_wallet_balance'] = 0.toString();
    map['total_amount'] = finaltotal.toString();
    var cartlist = await order(map);
    if (cartlist != null) {
      if (cartlist.data.order.isNotEmpty) {
        constantorderResponse.clear();
        constantorderResponse.addAll(cartlist.data.order);
        if (constantorderResponse != null && constantorderResponse.isNotEmpty) {
          constantorderResponse.forEach((element) {
            constantAppDataResponse.data.colorslist.forEach((element1) {
              element.product.forEach((element2) {
                if (element2.Colorid == element1.id) {
                  element2.ColorName = element1.name;
                }
              });
            });
          });
        }
      }
      if (!widget.buynow) {
        constantcartDataResponse.clear();
      }
    }
    setState(() {
      isAnimation = false;
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(3)),
            (route) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Something went Wrong!!",
        timeInSecForIosWeb: 4);
  }

  Future<void> _handleExternalWallet(ExternalWalletResponse response) async {
    setState(() {
      isAnimation = true;
    });

    var map = Map<String, dynamic>();
    map['uuid'] = await getStringFromLocalStorage(DEVICEID);

    var list = [];
    list.clear();

    products.forEach((element) {
      ItemClass itemClass = ItemClass(
          element.pid.toString(), element.pcount, element.Colorid.toString());
      list.add(itemClass);
    });

    map['product'] = jsonEncode(list);
    map['address_id'] = valueselect.toString();
    map['payment_type'] = 1.toString();
    map['payment_transaction_id'] = response.walletName.toString();
    map['updated_wallet_balance'] = 0.toString();
    map['total_amount'] = finaltotal.toString();
    var cartlist = await order(map);

    if (cartlist != null) {
      if (cartlist.data.order.isNotEmpty) {
        constantorderResponse.clear();
        constantorderResponse.addAll(cartlist.data.order);
        if (constantorderResponse != null && constantorderResponse.isNotEmpty) {
          constantorderResponse.forEach((element) {
            constantAppDataResponse.data.colorslist.forEach((element1) {
              element.product.forEach((element2) {
                if (element2.Colorid == element1.id) {
                  element2.ColorName = element1.name;
                  return;
                }
              });
            });
          });
        }
      }
      if (!widget.buynow) {
        constantcartDataResponse.clear();
      }
    }
    setState(() {
      isAnimation = false;
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(3)),
            (route) => false);
  }
}
