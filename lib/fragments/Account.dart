import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lehengas_choli_online_shopping/activity/GlobalText.dart';
import 'package:lehengas_choli_online_shopping/constants/constant.dart';
import 'package:lehengas_choli_online_shopping/services/apis.dart';
import 'package:lehengas_choli_online_shopping/services/secure_storage.dart';
import 'package:lottie/lottie.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController _txtfullname = TextEditingController();
  TextEditingController _txtMobile = TextEditingController();
  TextEditingController _txtaddress1 = TextEditingController();
  TextEditingController _txtaddress2 = TextEditingController();
  TextEditingController _txtpincode = TextEditingController();
  TextEditingController _txtcity = TextEditingController();
  TextEditingController _txtstate = TextEditingController();


  TextEditingController _txtFullName = TextEditingController();
  TextEditingController _txtMobileNumber = TextEditingController();
  TextEditingController _txtAddress1 = TextEditingController();
  TextEditingController _txtAddress2 = TextEditingController();
  TextEditingController _txtPinCode = TextEditingController();
  TextEditingController _txtCity = TextEditingController();
  TextEditingController _txtState = TextEditingController();


  bool isLottieeffect = false;
  bool isEdit = false;

  int addressid = 0;
  int _value = 0;

  bool isAddressAdd = false;

  String phone = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    phone = await getStringFromLocalStorage(PHONE_NUMBER);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isLottieeffect
            ? Center(
            child: Container(
                width: 100,
                height: 100,
                child: Lottie.asset("assets/json/splash_loader.json")))
            : SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 80.0,
                        height: 80.0,
                        margin: EdgeInsets.fromLTRB(10, 12, 0, 0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: profile_pic != null
                                    ? NetworkImage(profile_pic)
                                    : NetworkImage(
                                    "http://lehengascholi.com/public/product/60068001c07a5_product.png")))),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: 14,
                              fontFamily: 'Poppins'),
                        ),
                        Text(
                          "$fullname",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Poppins'),
                        ),
                        Divider(
                          color: Colors.black12,
                          height: 20.0,
                          thickness: 1.0,
                        ),
                        Padding(padding: EdgeInsets.only(top: 15.0)),
                        email != null
                            ? Text(
                          "Email Address",
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: 14,
                              fontFamily: 'Poppins'),
                        )
                            : SizedBox(),
                        email != null
                            ? Text(
                          "$email",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Poppins'),
                        )
                            : SizedBox(),
                        email != null
                            ? Divider(
                          color: Colors.black12,
                          height: 20.0,
                          thickness: 1.0,
                        )
                            : SizedBox(),
                        Padding(padding: EdgeInsets.only(top: 15.0)),
                        phone != null
                            ? phone.isNotEmpty ? Text(
                          "Mobile",
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: 14,
                              fontFamily: 'Poppins'),
                        ) : SizedBox()
                            : SizedBox(),
                        phone != null
                            ? phone.isNotEmpty ? Text(
                          '$phone',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Poppins'),
                        ) : SizedBox()
                            : SizedBox(),
                        phone != null
                            ? phone.isNotEmpty ? Divider(
                          color: Colors.black12,
                          height: 20.0,
                          thickness: 1.0,
                        ) : SizedBox()
                            : SizedBox(),
                        Padding(padding: EdgeInsets.only(top: 15.0)),
                        Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Address...",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 14,
                                    fontFamily: 'Poppins'),
                              ),
                              RaisedButton(
                                color: Colors.pink[50],
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0)),
                                onPressed: () {
                                  setState(() {
                                    isAddressAdd = true;
                                    isLottieeffect = false;
                                    isEdit = false;
                                  });
                                },
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                            ]),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        isAddressAdd
                            ? SizedBox()
                            : constantAddressDataResponse.isEmpty
                            ? Container(
                            margin: EdgeInsets.only(
                                top: 80.0, left: 20.0),
                            width: 300.0,
                            height: 350.0,
                            child: Column(children: [
                              Lottie.asset(
                                  "assets/json/address.json"),
                              Text(
                                "You have no Currently Address in Cart..",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Poppins'),
                              ),
                            ]))
                            : isEdit
                            ? TextFormFieldvalue2()
                            : ListView.builder(
                            itemCount:
                            constantAddressDataResponse
                                .length,
                            shrinkWrap: true,
                            itemBuilder:
                                (BuildContext context,
                                int index) {
                              return addressListItem(index);
                            }),
                        isAddressAdd ? TextFormFieldvalue() : SizedBox(),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  addressListItem(int index) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.pink),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 6.0, bottom: 5.0, right: 6.0),
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
                  constantAddressDataResponse[index].fullname,
                  style: TextStyle(fontSize: 12, fontFamily: 'Poppins'),
                ),
              ],
            ),
            Row(
              children: [
                addressRowItem("address1"),
                Text(constantAddressDataResponse[index].address1,
                    style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
              ],
            ),
            Row(
              children: [
                addressRowItem("address2"),
                Text(constantAddressDataResponse[index].address2,
                    style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
              ],
            ),
            Row(
              children: [
                addressRowItem("Pin Code"),
                Text(constantAddressDataResponse[index].pincode,
                    style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
              ],
            ),
            Row(
              children: [
                addressRowItem("City"),
                Text(constantAddressDataResponse[index].city,
                    style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
              ],
            ),
            Row(
              children: [
                addressRowItem("State"),
                Text(constantAddressDataResponse[index].state,
                    style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
              ],
            ),
            Row(
              children: [
                addressRowItem("Address Type"),
                Text(
                    constantAddressDataResponse[index].addressType == "0"
                        ? "Resident"
                        : "Business",
                    style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Contact : ",
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("+91" + constantAddressDataResponse[0].mobileNumber,
                    style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 26.0,
                  width: 60,
                  child: RaisedButton(
                      color: PrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      onPressed: () {
                        setState(() {
                          isAddressAdd = false;
                          isEdit = true;
                          _txtfullname.text =
                              constantAddressDataResponse[index].fullname;
                          _txtaddress1.text =
                              constantAddressDataResponse[index].address1;
                          _txtaddress2.text =
                              constantAddressDataResponse[index].address2;
                          _txtpincode.text =
                              constantAddressDataResponse[index].pincode;
                          _txtcity.text =
                              constantAddressDataResponse[index].city;
                          _txtstate.text =
                              constantAddressDataResponse[index].state;
                          _txtMobile.text =
                              constantAddressDataResponse[index].mobileNumber;
                          addressid =
                              constantAddressDataResponse[index].addressId;
                          print(constantAddressDataResponse[index].addressId);
                          _value = int.parse(constantAddressDataResponse[index]
                              .addressType);
                        });
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins'),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextFormFieldvalue() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.pink),
      ),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                addressRowItem("Full name"),
                Expanded(
                    child: TextFormField(
                      controller: _txtFullName,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      decoration: InputDecoration(
                        labelText: "Full name",
                        isDense: true,
                        hintText: "Enter your full name..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank '
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("address 1"),
                Expanded(
                    child: TextFormField(
                      controller: _txtAddress1,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Address 1",
                        isDense: true,
                        hintText: "Enter your Address 1..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("address 2"),
                Expanded(
                    child: TextFormField(
                      controller: _txtAddress2,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Address 2",
                        isDense: true,
                        hintText: "Enter your Address 2..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("Pin Code "),
                Expanded(
                    child: TextFormField(
                      controller: _txtPinCode,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Pincode",
                        isDense: true,
                        hintText: "Enter your Pincode..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("City"),
                Expanded(
                    child: TextFormField(
                      controller: _txtCity,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "City",
                        isDense: true,
                        hintText: "Enter your City..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("State"),
                Expanded(
                    child: TextFormField(
                      controller: _txtState,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "State",
                        isDense: true,
                        hintText: "Enter your State..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                Text(
                  "Phone No :  ",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                Expanded(
                    child: TextFormField(
                      controller: _txtMobileNumber,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Mobile number",
                        isDense: true,
                        hintText: "Enter your Mobile number..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("Address Type"),
                DropdownButton(
                    value: _value,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.pink,
                    ),
                    style: TextStyle(color: Colors.pink, fontFamily: 'Poppins'),
                    items: [
                      DropdownMenuItem(
                        child: Text("Resident"),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text("Business"),
                        value: 1,
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 26.0,
                  width: 70,
                  child: RaisedButton(
                      color: PrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      onPressed: () {
                        if (_txtFullName.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your Full Name..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }
                        if (_txtAddress1.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your  Address1..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }
                        if (_txtAddress2.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your Address2..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }
                        if (_txtPinCode.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your pincode..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }

                        if (_txtCity.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your City..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }

                        if (_txtState.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your State..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }

                        if (_txtMobileNumber.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your mobile number..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }
                        setState(() {
                          isAddressAdd = false;
                          isLottieeffect = true;
                          Addaddress();
                        });
                      },
                      child: Text(
                        "Apply",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins'),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextFormFieldvalue2() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.pink),
      ),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                addressRowItem("Full name"),
                Expanded(
                    child: TextFormField(
                      controller: _txtfullname,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      decoration: InputDecoration(
                        labelText: "Full name",
                        isDense: true,
                        hintText: "Enter your full name..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank '
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("address 1"),
                Expanded(
                    child: TextFormField(
                      controller: _txtaddress1,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Address 1",
                        isDense: true,
                        hintText: "Enter your Address 1..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("address 2"),
                Expanded(
                    child: TextFormField(
                      controller: _txtaddress2,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Address 2",
                        isDense: true,
                        hintText: "Enter your Address 2..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("Pin Code "),
                Expanded(
                    child: TextFormField(
                      controller: _txtpincode,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Pincode",
                        isDense: true,
                        hintText: "Enter your Pincode..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("City "),
                Expanded(
                    child: TextFormField(
                      controller: _txtcity,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "City",
                        isDense: true,
                        hintText: "Enter your City..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("State"),
                Expanded(
                    child: TextFormField(
                      controller: _txtstate,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "State",
                        isDense: true,
                        hintText: "Enter your State..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                Text(
                  "Phone No :  ",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                Expanded(
                    child: TextFormField(
                      controller: _txtMobile,
                      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      cursorColor: Colors.pink,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Mobile number",
                        isDense: true,
                        hintText: "Enter your Mobile number..!",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        return value.isEmpty == true
                            ? 'Can not be blank'
                            : null;
                      },
                    )),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Row(
              children: [
                addressRowItem("Address Type"),
                DropdownButton(
                    value: _value,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.pink,
                    ),
                    style: TextStyle(color: Colors.pink, fontFamily: 'Poppins'),
                    items: [
                      DropdownMenuItem(
                        child: Text("Resident"),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text("Business"),
                        value: 1,
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 26.0,
                  width: 70,
                  child: RaisedButton(
                      color: PrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      onPressed: () {
                        if (_txtfullname.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your Full Name..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }
                        if (_txtaddress1.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your  Address1..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }
                        if (_txtaddress2.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your Address2..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }
                        if (_txtpincode.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your pincode..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }

                        if (_txtcity.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your City..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }

                        if (_txtstate.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your State..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }

                        if (_txtMobile.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter your mobile number..!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1);
                          return;
                        }
                        setState(() {
                          isEdit = false;
                          isAddressAdd = false;
                          isLottieeffect = true;
                          UpdateAddaddress();
                        });
                      },
                      child: Text(
                        "Applay",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins'),
                      )),
                ),
              ],
            ),
          ],
        ),
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
          maxLines: 1,
        ),
        GlobalText(
          " : ",
          paddingLeft: 2.0,
          paddingRight: 2.0,
        ),
      ],
    );
  }

  Addaddress() async {
    var map = Map<String, dynamic>();
    map['uuid'] = await getStringFromLocalStorage(DEVICEID);
    map['fullname'] = _txtFullName.text;
    map['mobile_number'] = _txtMobileNumber.text;
    map['address1'] = _txtAddress1.text;
    map['address2'] = _txtAddress2.text;
    map['pincode'] = _txtPinCode.text;
    map['city'] = _txtCity.text;
    map['state'] = _txtState.text;
    map['address_type'] = _value.toString();
    var addaddresslist = await getUserAddresslist(map);

    setState(() {
      if (addaddresslist.data.isNotEmpty) {
        constantAddressDataResponse.clear();
        constantAddressDataResponse.addAll(addaddresslist.data);
      }
      isLottieeffect = false;
    });
  }

  UpdateAddaddress() async {
    var map2 = Map<String, dynamic>();
    map2['uuid'] = await getStringFromLocalStorage(DEVICEID);
    map2['fullname'] = _txtfullname.text;
    map2['mobile_number'] = _txtMobile.text;
    map2['address1'] = _txtaddress1.text;
    map2['address2'] = _txtaddress2.text;
    map2['pincode'] = _txtpincode.text;
    map2['city'] = _txtCity.text;
    map2['state'] = _txtState.text;
    map2['address_type'] = _value.toString();
    map2['address_id'] = addressid.toString();
    var addaddresslist = await getUserAddresslist(map2);
    setState(() {
      if (addaddresslist.data.isNotEmpty) {
        constantAddressDataResponse.clear();
        constantAddressDataResponse.addAll(addaddresslist.data);
      }
      isLottieeffect = false;
    });
  }
}
