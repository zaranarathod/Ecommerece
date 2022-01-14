import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/models/ProductlistResponse.dart';
import 'package:lehengas_choli_online_shopping/models/WishlistResponse.dart';
import 'package:lehengas_choli_online_shopping/services/apis.dart';
import 'package:lehengas_choli_online_shopping/services/secure_storage.dart';
import 'package:lottie/lottie.dart';

import 'Product_detail.dart';

class Wishlistdata extends StatefulWidget {
  @override
  _WishlistdataState createState() => _WishlistdataState();
}

class _WishlistdataState extends State<Wishlistdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: constantWishlistDataResponse.isEmpty
          ? Center(
        child: Container(
            width: 300.0,
            height: 350.0,
            child: Column(
              children: [
                Lottie.asset("assets/json/emptywishlist.json"),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                Text(
                  "You have no Currently Wishlist..",
                  style: TextStyle(fontSize: 15.0, fontFamily: 'Poppins'),
                )
              ],
            )),
      )
          : ListView.builder(
        shrinkWrap: true,
        itemCount: constantWishlistDataResponse.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(6.0),
            child: InkWell(
              onTap: () {
                List<Products> abc = [];
                Products selectedProduct;

                Productlist.data.products.forEach((element) {
                  if (constantWishlistDataResponse[index].pid ==
                      element.pid) {
                    selectedProduct = element;
                    return;
                  }
                });

                Productlist.data.products
                  ..forEach((element) {
                    if (selectedProduct.productCategory ==
                        element.productCategory) {
                      if (element.productCode !=
                          selectedProduct.productCode) {
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
                elevation: 3.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 6.0)),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 6.0)),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: FadeInImage(
                                  height: 107.0,
                                  width: 75.0,
                                  placeholder: AssetImage(
                                      "assets/images/profile.png"),
                                  image: NetworkImage(
                                      constantWishlistDataResponse[index]
                                          .productImages),
                                  fit: BoxFit.fill)),
                          Padding(padding: EdgeInsets.only(left: 6.0)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                constantWishlistDataResponse[index]
                                    .productCode,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                "Color :- ${constantWishlistDataResponse[index]
                                    .ColorName}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                constantWishlistDataResponse[index]
                                    .productName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                              Container(
                                width: 220,
                                child: Text(
                                  constantWishlistDataResponse[index]
                                      .productInformation,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              Text(
                                "\u20B9" +
                                    constantWishlistDataResponse[index]
                                        .productDiscountRate,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.pink,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                    color: PrimaryColor,
                                    borderRadius:
                                    BorderRadius.circular(8.0)),
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
                                removeWishList(
                                    constantWishlistDataResponse[index]);
                              }),
                        ]),
                    Padding(
                        padding:
                        EdgeInsets.only(bottom: 5.0, right: 5.0)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void removeWishList(WishListData data) async {
    var map = new Map<String, dynamic>();
    map["uuid"] = await getStringFromLocalStorage(DEVICEID);
    map["pid"] = data.pid.toString();
    map["color_id"] = data.Colorid.toString();
    map["deletewishlist"] = 1.toString();
    var wishlist2 = await getWishlist(map);

    setState(() {
      if (wishlist2.data.isNotEmpty) {
        constantWishlistDataResponse.clear();
        constantWishlistDataResponse.addAll(wishlist2.data);
      } else {
        constantWishlistDataResponse.clear();
      }
    });
  }
}
