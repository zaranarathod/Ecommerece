import 'package:lehengas_choli_online_shopping/models/WishlistResponse.dart';

class AccountResponse {
  bool success;
  Data data;
  String message;

  AccountResponse({this.success, this.data, this.message});

  AccountResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  Userdata userdata;

  Data({this.userdata});

  Data.fromJson(Map<String, dynamic> json) {
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userdata != null) {
      data['userdata'] = this.userdata.toJson();
    }
    return data;
  }
}

class Userdata {
  String name;
  String email;
  String phone;
  String walletbalance;
  List<Addresses> addresses;
  List<Cart> cart;
  List<WishListData> wishlist;
  List<OrderStatus> orderStatus;

  Userdata({this.name,
    this.email,
    this.phone,
    this.walletbalance,
    this.addresses,
    this.cart,
    this.wishlist,
    this.orderStatus});

  Userdata.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    walletbalance = json['walletbalance'];
    if (json['addresses'] != null) {
      addresses = [];
      json['addresses'].forEach((v) {
        addresses.add(Addresses.fromJson(v));
      });
    }
    if (json['cart'] != null) {
      cart = [];
      json['cart'].forEach((v) {
        cart.add(new Cart.fromJson(v));
      });
    }
    if (json['wishlist'] != null) {
      wishlist = [];
      json['wishlist'].forEach((v) {
        wishlist.add(WishListData.fromJson(v));
      });
    }
    if (json['orderStatus'] != null) {
      orderStatus = [];
      json['orderStatus'].forEach((v) {
        orderStatus.add(OrderStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['walletbalance'] = this.walletbalance;
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }

    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist.map((v) => v.toJson()).toList();
    }
    if (this.orderStatus != null) {
      data['orderStatus'] = this.orderStatus.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int addressId;
  String fullname;
  String mobileNumber;
  String address1;
  String address2;
  String pincode;
  String city;
  String state;
  String addressType;

  Addresses({this.addressId,
    this.fullname,
    this.mobileNumber,
    this.address1,
    this.address2,
    this.pincode,
    this.city, this.state,
    this.addressType});

  Addresses.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    fullname = json['fullname'];
    mobileNumber = json['mobile_number'];
    address1 = json['address1'];
    address2 = json['address2'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    addressType = json['address_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['fullname'] = this.fullname;
    data['mobile_number'] = this.mobileNumber;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['pincode'] = this.pincode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['address_type'] = this.addressType;
    return data;
  }
}

class Cart {
  int pid;
  String saveforlater;
  String pcount;
  int Colorid;
  String ColorName;
  String productName;
  String productPrice;
  String productDiscountRate;
  String productCode;
  String productInformation;
  String productImages;

  Cart({this.pid,
    this.saveforlater,
    this.pcount,
    this.Colorid,
    this.ColorName,
    this.productName,
    this.productPrice,
    this.productDiscountRate,
    this.productCode,
    this.productInformation,
    this.productImages});

  Cart.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    saveforlater = json['saveforlater'];
    pcount = json['pcount'];
    Colorid = json['color_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productDiscountRate = json['product_discount_rate'];
    productCode = json['product_code'];
    productInformation = json['product_information'];
    productImages = json['product_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['saveforlater'] = this.saveforlater;
    data['pcount'] = this.pcount;
    data['color_id'] = this.Colorid;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_discount_rate'] = this.productDiscountRate;
    data['product_code'] = this.productCode;
    data['product_information'] = this.productInformation;
    data['product_images'] = this.productImages;
    return data;
  }
}

class Product {
  int pid;
  String productName;
  String productPrice;
  String pcount;
  String productDiscountRate;
  String productCode;
  int Colorid;
  String ColorName;
  String productInformation;
  String productImages;

  Product({this.pid,
    this.productName,
    this.productPrice,
    this.productDiscountRate,
    this.productCode,
    this.pcount,
    this.ColorName,
    this.Colorid,
    this.productInformation,
    this.productImages});

  Product.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    pcount = json['pcount'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    if (json['product_discount_rate'] != null) {
      productDiscountRate = json['product_discount_rate'];
    }
    productCode = json['product_code'];
    Colorid = json['color_id'];
    productInformation = json['product_information'];
    productImages = json['product_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['pcount'] = this.pcount;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_discount_rate'] = this.productDiscountRate;
    data['product_code'] = this.productCode;
    data['color_id'] = this.Colorid;
    data['product_information'] = this.productInformation;
    data['product_images'] = this.productImages;
    return data;
  }
}


class OrderStatus {
  String orderId;
  String orderDate;
  String totalAmount;
  String courier;
  String tracking;
  String courierCharge;
  String paymentType;
  String orderState;
  List<Product> product;

  OrderStatus({this.orderId,
    this.orderDate,
    this.totalAmount,
    this.courier,
    this.tracking,
    this.courierCharge,
    this.paymentType,
    this.orderState,
    this.product});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    if (json['courier_name'] != null) {
      courier = json['courier_name'];
    }
    if (json['tracking_id'] != null) {
      tracking = json['tracking_id'];
    }
    orderDate = json['order_date'];
    totalAmount = json['total_amount'];
    courierCharge = json['courier_charge'];
    paymentType = json['payment_type'];
    orderState = json['order_state'];
    if (json['product'] != null) {
      product = [];
      json['product'].forEach((v) {
        product.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['courier_name'] = this.courier;
    data['tracking_id'] = this.tracking;
    data['order_date'] = this.orderDate;
    data['total_amount'] = this.totalAmount;
    data['courier_charge'] = this.courierCharge;
    data['payment_type'] = this.paymentType;
    data['order_state'] = this.orderState;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
