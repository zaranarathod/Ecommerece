import 'package:flutter/material.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lottie/lottie.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              children: [
                constantorderResponse.isEmpty
                    ? Center(
                  child: Column(
                    children: [
                      Lottie.asset("assets/json/emptyorder.json"),
                      Text(
                        "You have no Currently Order...",
                        style: TextStyle(
                            fontSize: 15.0, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: constantorderResponse.length,
                  itemBuilder: (context, index) {
                    return OrderItem(index);
                  },
                ),
              ],
            )),
      ),
    );
  }

  OrderItem(index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.pink,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(children: [
          Padding(padding: EdgeInsets.only(top: 10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Id :",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),

              Text(
                "${constantorderResponse[index].orderId}",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              )
            ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Date :",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),

              Text(
                "${constantorderResponse[index].orderDate}",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              )
            ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Amount :",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),

              Text(
                "${constantorderResponse[index].totalAmount}",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              )
            ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Courier Amount :",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),

              Text(
                "${constantorderResponse[index].courierCharge}",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              )
            ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Status :",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),

              Text(
                "${constantorderResponse[index].orderState}",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              )
            ],),

          constantorderResponse[index].orderState.contains("conf")
              ? SizedBox()
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Courier Name :",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),

              Text(
                "${constantorderResponse[index].courier}",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              )
            ],),
          constantorderResponse[index].orderState.contains("conf")
              ? SizedBox()
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Traking Id :",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),

              Text(
                "${constantorderResponse[index].tracking}",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              )
            ],),
          constantorderResponse[index].product.length != 0 ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Products :",
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontFamily: 'Poppins'),
              ),
            ],
          ) : SizedBox(),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemCount: constantorderResponse[index].product.length,
            itemBuilder: (context, index1) {
              return OrderItem1(index, index1);
            },
          ),
          Padding(padding: EdgeInsets.only(top: 10.0)),
        ]),
      ),
    );
  }


  OrderItem1(index, index1) {
    return Card(
      child: Container(
        margin: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 10.0, right: 5.0),
        child: Column(
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
                            constantorderResponse[index].product[index1]
                                .productImages),
                        fit: BoxFit.fill)),
                Padding(padding: EdgeInsets.only(left: 7.0)),
                Container(
                  width: 210.0,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              constantorderResponse[index].product[index1]
                                  .productCode,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Poppins',
                                  color: Colors.black),
                            ),
                            Padding(padding: EdgeInsets.only(left: 15.0)),
                            Text(
                              " x   ${constantorderResponse[index]
                                  .product[index1].pcount}",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Poppins',
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          constantorderResponse[index].product[index1]
                              .productName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Poppins',
                              color: Colors.grey),
                        ),
                        constantorderResponse[index].product[index1]
                            .ColorName != null ?
                        Text(
                          constantorderResponse[index].product[index1]
                              .ColorName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Poppins',
                              color: Colors.grey),
                        ) : SizedBox(),
                        Text(
                          "\u20B9" +
                              constantorderResponse[index].product[index1]
                                  .productPrice,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              fontFamily: 'Poppins',
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
