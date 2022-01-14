import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/models/GetAppDataResponse.dart';
import 'package:lehengas_choli_online_shopping/models/ProductlistResponse.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'Product_detail.dart';


class Createyourstyle extends StatefulWidget {
  @override
  _CreateyourstyleState createState() => _CreateyourstyleState();
}

class _CreateyourstyleState extends State<Createyourstyle> {
  TextEditingController _searchbar = TextEditingController();
  String maxprice;
  String minprice;

  int selected = 0;
  bool isProductlist = true;

  bool issortby = false;
  bool isFliter = false;
  bool issearchbar = false;

  bool isavg = false;
  bool isLowprice = false;
  bool isHighprise = false;
  bool isRel = false;

  String color = "";
  String selectedFabrics = "";
  bool bottombtncolor = false;
  List<Products> filtredproducts = [];
  List<Products> trending = [];
  SfRangeValues _values;

  @override
  void initState() {
    super.initState();
    getProductlist();
  }

  Dialogbtn() {
    return Row(
      children: [
        Expanded(
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  if (isRel) {
                    color = "";
                    _values = SfRangeValues(double.parse(minprice) + 1500,
                        double.parse(maxprice) - 1500);
                    selectedFabrics = "";
                    constantAppDataResponse.data.colorslist.forEach((element) {
                      element.selected = false;
                    });
                    constantAppDataResponse.data.fabriclist.forEach((element) {
                      element.selected = false;
                    });
                    filtredproducts.clear();
                    filtredproducts.addAll(Productlist.data.products);
                    selected = 0;
                  }

                  if (isHighprise) {
                    if (filtredproducts.isNotEmpty) {
                      filtredproducts.sort((a, b) =>
                          double.parse(a.productDiscountRate)
                              .compareTo(double.parse(b.productDiscountRate)));
                      var temp = filtredproducts.reversed.toList();
                      filtredproducts.clear();
                      filtredproducts.addAll(temp);
                    } else {
                      color = "";
                      _values = SfRangeValues(double.parse(minprice) + 1500,
                          double.parse(maxprice) - 1500);
                      selectedFabrics = "";
                      constantAppDataResponse.data.colorslist.forEach((
                          element) {
                        element.selected = false;
                      });
                      constantAppDataResponse.data.fabriclist.forEach((
                          element) {
                        element.selected = false;
                      });
                      filtredproducts.addAll(Productlist.data.products);
                      filtredproducts.sort((a, b) =>
                          double.parse(a.productDiscountRate)
                              .compareTo(double.parse(b.productDiscountRate)));
                      var temp = filtredproducts.reversed.toList();
                      filtredproducts.clear();
                      filtredproducts.addAll(temp);
                    }
                  }

                  if (isLowprice) {
                    if (filtredproducts.isNotEmpty) {
                      filtredproducts.sort((a, b) =>
                          double.parse(a.productDiscountRate)
                              .compareTo(double.parse(b.productDiscountRate)));
                    } else {
                      color = "";
                      _values = SfRangeValues(double.parse(minprice) + 1500,
                          double.parse(maxprice) - 1500);
                      selectedFabrics = "";
                      constantAppDataResponse.data.colorslist.forEach((
                          element) {
                        element.selected = false;
                      });
                      constantAppDataResponse.data.fabriclist.forEach((
                          element) {
                        element.selected = false;
                      });
                      filtredproducts.addAll(Productlist.data.products);
                      filtredproducts.sort((a, b) =>
                          double.parse(a.productDiscountRate)
                              .compareTo(double.parse(b.productDiscountRate)));
                    }
                  }

                  if (isavg) {
                    if (filtredproducts.isNotEmpty) {
                      filtredproducts.sort((a, b) =>
                          double.parse(a.productRating)
                              .compareTo(double.parse(b.productRating)));
                    } else {
                      color = "";
                      _values = SfRangeValues(double.parse(minprice) + 1500,
                          double.parse(maxprice) - 1500);
                      selectedFabrics = "";
                      constantAppDataResponse.data.colorslist.forEach((
                          element) {
                        element.selected = false;
                      });
                      constantAppDataResponse.data.fabriclist.forEach((
                          element) {
                        element.selected = false;
                      });
                      filtredproducts.addAll(Productlist.data.products);
                      filtredproducts.sort((a, b) =>
                          double.parse(a.productRating)
                              .compareTo(double.parse(b.productRating)));
                    }
                  }

                  if (color.isNotEmpty) {
                    if (filtredproducts.isNotEmpty) {
                      List<Products> tempList1 = [];
                      filtredproducts.forEach((element) {
                        if (element.productColor == color) {
                          tempList1.add(element);
                        }
                      });
                      filtredproducts.clear();
                      filtredproducts.addAll(tempList1);
                    } else {
                      isRel = false;
                      isLowprice = false;
                      isHighprise = false;
                      isavg = false;
                      _values = SfRangeValues(double.parse(minprice) + 1500,
                          double.parse(maxprice) - 1500);
                      selectedFabrics = "";
                      constantAppDataResponse.data.fabriclist.forEach((
                          element) {
                        element.selected = false;
                      });
                      filtredproducts.addAll(Productlist.data.products);
                      List<Products> tempList1 = [];
                      filtredproducts.forEach((element) {
                        if (element.productColor == color) {
                          tempList1.add(element);
                        }
                      });
                      filtredproducts.clear();
                      filtredproducts.addAll(tempList1);
                    }
                  }


                  if (double.parse(_values.start.toString()) !=
                      double.parse(minprice) + 1500) {
                    if (filtredproducts.isNotEmpty) {
                      List<Products> tempList2 = [];
                      filtredproducts.forEach((element) {
                        if (double.parse(element.productDiscountRate) >=
                            double.parse(_values.start.toString())) {
                          tempList2.add(element);
                        }
                      });
                      filtredproducts.clear();
                      filtredproducts.addAll(tempList2);
                    } else {
                      isRel = false;
                      isLowprice = false;
                      isHighprise = false;
                      isavg = false;
                      color = "";
                      _values = SfRangeValues(
                          _values.start, double.parse(maxprice) - 1500);
                      selectedFabrics = "";
                      constantAppDataResponse.data.colorslist.forEach((
                          element) {
                        element.selected = false;
                      });
                      filtredproducts.addAll(Productlist.data.products);
                      List<Products> tempList2 = [];
                      filtredproducts.forEach((element) {
                        if (double.parse(element.productDiscountRate) >=
                            double.parse(_values.start.toString())) {
                          tempList2.add(element);
                        }
                      });
                      filtredproducts.clear();
                      filtredproducts.addAll(tempList2);
                    }
                  }

                  if (double.parse(_values.end.toString()) !=
                      double.parse(maxprice) - 1500) {
                    if (filtredproducts.isNotEmpty) {
                      List<Products> tempList3 = [];
                      filtredproducts.forEach((element) {
                        if (double.parse(element.productDiscountRate) <=
                            double.parse(_values.end.toString())) {
                          tempList3.add(element);
                        }
                      });
                      filtredproducts.clear();
                      filtredproducts.addAll(tempList3);
                    } else {
                      isRel = false;
                      isLowprice = false;
                      isHighprise = false;
                      isavg = false;
                      _values = SfRangeValues(
                          double.parse(minprice) + 1500, _values.end);
                      color = "";
                      selectedFabrics = "";
                      constantAppDataResponse.data.colorslist.forEach((
                          element) {
                        element.selected = false;
                      });
                      constantAppDataResponse.data.fabriclist.forEach((
                          element) {
                        element.selected = false;
                      });
                      filtredproducts.addAll(Productlist.data.products);
                      List<Products> tempList3 = [];
                      filtredproducts.forEach((element) {
                        if (double.parse(element.productDiscountRate) <=
                            double.parse(_values.start.toString())) {
                          tempList3.add(element);
                        }
                      });
                      filtredproducts.clear();
                      filtredproducts.addAll(tempList3);
                    }
                  }

                  if (selectedFabrics.isNotEmpty) {
                    if (filtredproducts.isNotEmpty) {
                      List<Products> tempList4 = [];
                      filtredproducts.forEach((element) {
                        if (element.productFabric == selectedFabrics) {
                          tempList4.add(element);
                        }
                      });
                      filtredproducts.clear();
                      filtredproducts.addAll(tempList4);
                    } else {
                      isRel = false;
                      isLowprice = false;
                      isHighprise = false;
                      isavg = false;
                      _values = SfRangeValues(double.parse(minprice) + 1500,
                          double.parse(maxprice) - 1500);
                      color = "";
                      constantAppDataResponse.data.colorslist.forEach((
                          element) {
                        element.selected = false;
                      });
                      constantAppDataResponse.data.fabriclist.forEach((
                          element) {
                        element.selected = false;
                      });
                      filtredproducts.addAll(Productlist.data.products);
                      List<Products> tempList4 = [];
                      filtredproducts.forEach((element) {
                        if (element.productFabric == selectedFabrics) {
                          tempList4.add(element);
                        }
                      });
                      filtredproducts.clear();
                      filtredproducts.addAll(tempList4);
                    }
                  }


                  bottombtncolor = false;
                  issortby = false;
                  isFliter = false;
                  issearchbar = false;
                  // isavg = false;
                  // isLowprice = false;
                  // isHighprise = false;
                  // isRel = false;
                  // color = "";
                  // calculateminPrice = "";
                  // calculatemaxPrice = "";
                  // selectedFabrics = "";
                  // constantAppDataResponse.data.colorslist.forEach((element) {
                  //   element.selected = false;
                  // });
                  // constantAppDataResponse.data.fabriclist.forEach((element) {
                  //   element.selected = false;
                  // });
                });
              },
              color: PrimaryColor,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              child: Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Poppins', fontSize: 16.0),
              ),
            )),
        Padding(padding: EdgeInsets.only(right: 21.0)),
        Expanded(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                bottombtncolor = false;
                issortby = false;
                isFliter = false;
                issearchbar = false;
                isavg = false;
                isLowprice = false;
                isHighprise = false;
                isRel = false;
                filtredproducts.clear();
                filtredproducts.addAll(Productlist.data.products);
                selected = 0;
                color = "";
                selectedFabrics = "";

                _values = SfRangeValues(double.parse(minprice) + 1500,
                    double.parse(maxprice) - 1500);

                constantAppDataResponse.data.colorslist.forEach((element) {
                  element.selected = false;
                });
                constantAppDataResponse.data.fabriclist.forEach((element) {
                  element.selected = false;
                });
              });
            },
            color: PrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Text(
              "Cancel",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 16.0),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(right: 16.0)),
      ],
    );
  }

  Checkboxtextstyle(name) {
    return Text(
      name,
      style:
      TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14),
    );
  }

  void getProductlist() async {
    setState(() {
      isProductlist = true;
      minprice = constantAppDataResponse.data.minprice;
      maxprice = constantAppDataResponse.data.maxprice;
      _values = SfRangeValues(
          double.parse(minprice) + 1500, double.parse(maxprice) - 1500);
      filtredproducts.clear();
      filtredproducts.addAll(Productlist.data.products);
      trending.clear();
      Productlist.data.products.forEach((element) {
        if (element.productTrending == "1") {
          trending.add(element);
        }
      });
      isProductlist = false;
    });

    print(filtredproducts.length);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return RefreshIndicator(
          onRefresh: () async {
            Future.delayed(const Duration(milliseconds: 500), () {
              getProductlist();
            });
          },
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 30.0,
                          ),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: constantAppDataResponse.data.category
                                .length,
                            itemBuilder: (context, index) =>
                                CategoryRowItem(
                                    constantAppDataResponse.data.category[index]
                                        .name,
                                    index),
                          ),
                        ),
                        serchbar(),
                        trending.length >= 1
                            ? Padding(padding: EdgeInsets.only(top: 10.0))
                            : SizedBox(),
                        trending.length >= 1 ? Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            "Trending : ",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.pink,
                                fontFamily: "Poppins"),
                          ),) : SizedBox(),
                        trending.length >= 1
                            ? Padding(padding: EdgeInsets.only(top: 10.0))
                            : SizedBox(),
                        trending.length >= 1 ? Container(
                            height: 200,
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child:
                            ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: trending.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    categotyItem(trending[index])))
                            : SizedBox(),
                        isProductlist ? ListBoxShimmer() : gridvieProductItem(
                            orientation),
                        SizedBox(
                          height: 30.0,
                        ),
                      ]),
                ),
                Positioned(
                    bottom: 0.0, left: 0.0, right: 0.0, child: Visible()),
              ],
            ),
          ),
        );
      },


    );
  }

  serchbar() {
    return Visibility(
      visible: issearchbar,
      child: Container(
        margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
        child: TextField(
          cursorColor: Colors.pink,
          controller: _searchbar,
          onChanged: (String text) {
            setState(() {
              if (_searchbar.text.isEmpty) {
                _values = SfRangeValues(double.parse(minprice) + 1500,
                    double.parse(maxprice) - 1500);

                issortby = false;
                isFliter = false;
                issearchbar = false;
                bottombtncolor = false;

                isavg = false;
                isLowprice = false;
                isHighprise = false;
                isRel = false;

                filtredproducts.clear();
                filtredproducts.addAll(Productlist.data.products);
                selected = 0;
                color = "";
                selectedFabrics = "";
              } else {
                bottombtncolor = false;

                List<Products> list = [];

                filtredproducts.forEach((element) {
                  if (element.productName.toLowerCase().contains(
                      _searchbar.text.toLowerCase())) {
                    list.add(element);
                  }
                });

                if (list.isEmpty) {
                  filtredproducts.clear();
                } else {
                  filtredproducts.clear();
                  filtredproducts.addAll(list);
                }
              }
            });
          },
          onEditingComplete: () {
            if (bottombtncolor) {
              bottombtncolor = false;
            }
            FocusScope.of(context).requestFocus(FocusNode());
          },
          autofocus: true,
          decoration: InputDecoration(
              hintText: "Search...",
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(width: 2.0))),
        ),
      ),
    );
  }

  Visible() {
    return Column(children: [
      Visibility(
        visible: issortby,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                topLeft: Radius.circular(25.0)),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 16.0),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 6.9)),
                Container(
                  color: Colors.grey,
                  height: 2.0,
                  width: 120.0,
                ),
                Padding(padding: EdgeInsets.only(top: 9.6)),
                Text(
                  "Sort by",
                  style: TextStyle(
                      color: Colors.pink, fontFamily: 'Poppins', fontSize: 14),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Row(children: [
                  Container(
                    width: 16.0,
                    height: 19.0,
                    child: Checkbox(
                      value: isRel,
                      onChanged: (value) {
                        setState(() {
                          isRel = value;
                          if (value) {
                            isHighprise = false;
                            isLowprice = false;
                            isavg = false;
                          }
                        });
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 20.0)),
                  Checkboxtextstyle("Relevance"),
                ]),
                Padding(padding: EdgeInsets.only(top: 8)),
                Row(children: [
                  Container(
                    width: 16.0,
                    height: 19.0,
                    child: Checkbox(
                        value: isHighprise,
                        onChanged: (value) {
                          setState(() {
                            isHighprise = value;
                            if (value) {
                              isRel = false;
                              isLowprice = false;
                              isavg = false;
                            }
                          });
                        }),
                  ),
                  Padding(padding: EdgeInsets.only(left: 20.0)),
                  Checkboxtextstyle("High Price"),
                ]),
                Padding(padding: EdgeInsets.only(top: 8)),
                Row(children: [
                  Container(
                    width: 16.0,
                    height: 19.0,
                    child: Checkbox(
                        value: isLowprice,
                        onChanged: (value) {
                          setState(() {
                            if (value) {
                              isRel = false;
                              isHighprise = false;
                              isavg = false;
                            }
                            isLowprice = value;
                          });
                        }),
                  ),
                  Padding(padding: EdgeInsets.only(left: 20.0)),
                  Checkboxtextstyle("Low Price"),
                ]),
                Padding(padding: EdgeInsets.only(top: 8)),
                Row(children: [
                  Container(
                    width: 16.0,
                    height: 19.0,
                    child: Checkbox(
                      value: isavg,
                      onChanged: (bool value) {
                        setState(() {
                          if (value) {
                            isRel = false;
                            isLowprice = false;
                            isHighprise = false;
                          }
                          isavg = value;
                        });
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 20.0)),
                  Checkboxtextstyle("Average Rating")
                ]),
                Padding(padding: EdgeInsets.only(left: 16.0, bottom: 5.0)),
                Dialogbtn(),
              ],
            ),
          ),
        ),
      ),
      Visibility(
          visible: isFliter,
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0)),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 16.0),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 6.9)),
                  Container(
                    color: Colors.grey,
                    height: 2.0,
                    width: 120.0,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    "Filters",
                    style: TextStyle(
                        color: Colors.pink,
                        fontFamily: 'Poppins',
                        fontSize: 14),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Text(
                        "Price",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: 14),
                      ),
                    ],
                  ),
                  // FlutterSlider(
                  //   values: [
                  //     double.parse(minprice) + 1500,double.parse(maxprice)-1500,
                  //   ],
                  //   rangeSlider: true,
                  //   max: double.parse(maxprice),
                  //   min:   double.parse(minprice),
                  //   trackBar: FlutterSliderTrackBar(
                  //     inactiveTrackBar: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: Colors.pink,
                  //     ),
                  //     activeTrackBar: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.pink,
                  //           offset: Offset(5, 5),
                  //           blurRadius: 30.0,
                  //           spreadRadius: 4.0,
                  //         ),
                  //       ],
                  //       borderRadius: BorderRadius.circular(4),
                  //       color: Colors.pink,
                  //     ),
                  //   ),
                  //   tooltip: FlutterSliderTooltip(
                  //     format: (String value) {
                  //       return '\u20B9' + value;
                  //     },
                  //     textStyle: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 13.0,
                  //         fontFamily: 'Poppins'),
                  //   ),
                  //   onDragCompleted:
                  //       (_, lowerValue, upperValue) {
                  //       calculateminPrice = lowerValue.toString();
                  //       calculatemaxPrice = upperValue.toString();
                  //     setState(() {});
                  //   },
                  // ),
                  SfRangeSlider(
                    min: double.parse(minprice),
                    max: double.parse(maxprice),
                    values: _values,
                    interval: 1000,
                    showTicks: false,
                    showLabels: false,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (SfRangeValues values) {
                      setState(() {
                        _values = values;
                      });
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Colors",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: 14),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        height: 30.0,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          children: constantAppDataResponse.data.colorslist
                              .map((Colorslist colorlist) {
                            return InkWell(
                                onTap: () async {
                                  setState(() {
                                    color = colorlist.name;
                                    constantAppDataResponse.data.colorslist
                                        .forEach((element) {
                                      element.selected = false;
                                    });
                                    colorlist.selected = true;
                                  });
                                },
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(left: 4.0, right: 4.0),
                                  child: Container(
                                    width: 30.0,
                                    height: 22.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(7.0),
                                        border: Border.all(
                                            color: colorlist.selected
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: 2.0),
                                        color: HexColor(colorlist.colorCode)),
                                  ),
                                ));
                          }).toList(),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Text(
                        "Fabrics",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: 14),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Container(
                        height: 150,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          primary: false,
                          children: constantAppDataResponse.data.fabriclist
                              .map((Fabriclist fabricList) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                ),
                                Row(children: [
                                  Container(
                                    width: 16.0,
                                    height: 19.0,
                                    child: Checkbox(
                                      value: fabricList.selected,
                                      onChanged: (bool value) {
                                        setState(() {
                                          if (value) {
                                            selectedFabrics = fabricList.name;
                                            constantAppDataResponse
                                                .data.fabriclist
                                                .forEach((element) {
                                              element.selected = false;
                                            });
                                            fabricList.selected = value;
                                          } else {
                                            fabricList.selected = value;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 20.0)),
                                  Checkboxtextstyle(fabricList.name),
                                ]),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Dialogbtn(),
                    ],
                  ),
                ],
              ),
            ),
          )),
      Container(
        color: bottombtncolor
            ? Colors.white
            : issearchbar
            ? Colors.white
            : isFliter
            ? Colors.white
            : issortby
            ? Colors.white
            : Colors.transparent,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/images/levels.svg",
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    if (issearchbar) {
                      issearchbar = false;
                    }
                    if (issortby) {
                      issortby = false;
                    }
                    bottombtncolor = !bottombtncolor;
                    isFliter = !isFliter;
                  });
                },
              ),
              Padding(padding: EdgeInsets.only(left: 45.0)),
              FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/images/Layer_2.svg",
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    bottombtncolor = !bottombtncolor;
                    issearchbar = !issearchbar;
                    if (issortby) {
                      issortby = false;
                    }
                    if (isFliter) {
                      isFliter = false;
                    }
                  });
                },
              ),
              Padding(padding: EdgeInsets.only(right: 45.0)),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/images/Path 5.svg",
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    if (issearchbar) {
                      issearchbar = false;
                    }
                    if (isFliter) {
                      isFliter = false;
                    }
                    bottombtncolor = !bottombtncolor;
                    issortby = !issortby;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  CategoryRowItem(name, int index) {
    return selected == index
        ? Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding:
        EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0, bottom: 5.0),
        child: Text(
          name.toString(),
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    )
        : Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.pink),
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding:
        EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0, bottom: 5.0),
        child: GestureDetector(
          child: Text(
            name.toString(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          onTap: () async {
            setState(() {
              filtredproducts.clear();
              if (name == "Home") {
                filtredproducts.addAll(Productlist.data.products);
              }
              Productlist.data.products.forEach((element) {
                if (name != "Home") {
                  if (element.productCategory == name.toString()) {
                    filtredproducts.add(element);
                  }
                }
              });
              selected = index;
            });
            print(filtredproducts.length);
          },
        ),
      ),
    );
  }


  ListBoxShimmer() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        period: Duration(seconds: 2),
        child: GridView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 12.0,
            childAspectRatio: 1 / 1.5,
          ),
          shrinkWrap: true,
          children: ListBoxShimmerContainer(),
        ),
        baseColor: Colors.grey[500],
        highlightColor: Colors.grey[100],
      ),
    );
  }

  ListBoxShimmerContainer() {
    return List.generate(10, (index) {
      return Container(
        width: double.infinity,
        height: 250.0,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20.0)),
      );
    });
  }

  gridvieProductItem(Orientation orientation) {
    return filtredproducts.isNotEmpty
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "Products : ",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.pink,
                  fontFamily: "Poppins"),
            )),
        Padding(padding: EdgeInsets.only(bottom: 10.0)),
        Center(
          child:
          GridView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
              mainAxisSpacing: 0,
              crossAxisSpacing: 12.0,
              childAspectRatio: orientation == Orientation.portrait
                  ? 1 / 2.0
                  : 1 / 2.0,
            ),
            shrinkWrap: true,
            children: GridviewListItem(),
          ),
        ),
      ],
    )
        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            "Products : ",
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.pink,
                fontFamily: "Poppins"),
          )),
      Padding(padding: EdgeInsets.only(bottom: 10.0)),
      Center(
        child: Lottie.asset("assets/json/cartematy.json",
            height: 200, width: MediaQuery
                .of(context)
                .size
                .width - 100),
      ),
      SizedBox(
        height: 10,
      ),
      Center(
        child: Text(
          "We didn't find product in this category..",
          style: TextStyle(fontSize: 15.0, fontFamily: 'Poppins'),
        ),
      ),
      SizedBox(
        height: 20,
      )
    ]);
  }

  GridviewListItem() {
    return List.generate(filtredproducts.length, (index) {
      return InkWell(
        child: Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image(
                  height: 250.0,
                  width: double.infinity,
                  image: NetworkImage(filtredproducts[index].productImages[0]
                  ),
                  fit: BoxFit.fill)),
          SizedBox(height: 6.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filtredproducts[index].productName,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                filtredproducts[index].productCode,
                style: TextStyle(
                    fontSize: 17, color: Colors.black, fontFamily: 'Poppins'),
              ),
              Row(
                children: [
                  filtredproducts[index].discountEnable == "1" ? Text(
                    "\u20B9" + filtredproducts[index].productDiscountRate,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ) : SizedBox(),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 5.0,
                      )),
                  filtredproducts[index].discountEnable == "1" ? Text(
                    "\u20B9" + filtredproducts[index].productPrice,
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Poppins'),
                  ) : Text(
                    "\u20B9" + filtredproducts[index].productPrice,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 5.0,
                      )),
                  filtredproducts[index].discountEnable == "1" ? Text(
                    filtredproducts[index].productDiscount + "%",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontFamily: 'Poppins'),
                  ) : SizedBox(),
                ],
              ),
            ],
          )
        ]),
        onTap: () {
          List<Products> abc = [];
          filtredproducts.forEach((element) {
            if (filtredproducts[index].productCategory ==
                element.productCategory) {
              if (element.productCode != filtredproducts[index].productCode) {
                abc.add(element);
              }
            }
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Product_detail(filtredproducts[index], abc)));
        },
      );
    });
  }

  categotyItem(Products trendingsingle) {
    return InkWell(
      child: Container(
        width: 100.0,
        margin: EdgeInsets.only(right: 6.0, left: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image(
                    height: 150.0,
                    width: 100.0,
                    image: NetworkImage(trendingsingle.productImages[0]),
                    fit: BoxFit.fill)),
            Padding(
                padding: EdgeInsets.only(
                  top: 3.0,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50.0,
                  child: Text(
                    trendingsingle.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins'),
                  ),
                ),
                Container(
                  width: 50.0,
                  child: Text(
                    trendingsingle.productCode,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins'),
                  ),
                )
              ],
            ),
            Row(
              children: [
                trendingsingle.discountEnable == "1" ? Text(
                  "\u20B9" + trendingsingle.productDiscountRate,
                  style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontFamily: 'Poppins'),
                ) : SizedBox(),
                Padding(
                    padding: EdgeInsets.only(
                      left: 5.0,
                    )),
                trendingsingle.discountEnable == "1" ? Text(
                  "\u20B9" + trendingsingle.productPrice,
                  style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontFamily: 'Poppins'),
                ) : Text(
                  "\u20B9" + trendingsingle.productPrice,
                  style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontFamily: 'Poppins'),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      left: 5.0,
                    )),
                trendingsingle.discountEnable == "1" ? Text(
                  trendingsingle.productDiscount + "%",
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
      onTap: () {
        List<Products> xzz = [];
        trending.forEach((element) {
          if (trendingsingle.productCategory == element.productCategory) {
            if (element.productCode != trendingsingle.productCode) {
              xzz.add(element);
            }
          }
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Product_detail(trendingsingle, xzz)));
      },
    );
  }
}
