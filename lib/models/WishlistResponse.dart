class WishlistResponse {
  bool success;
  List<WishListData> data;
  String message;

  WishlistResponse({this.success, this.data, this.message});

  WishlistResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new WishListData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class WishListData {
  int pid;
  int Colorid;
  String ColorName;
  String productName;
  String productInformation;
  String productImages;
  String productCode;
  String productPrice;
  String productDiscountRate;

  WishListData({this.pid,
    this.Colorid,
    this.ColorName,
    this.productName,
    this.productInformation,
    this.productImages,
    this.productCode,
    this.productPrice,
    this.productDiscountRate});

  WishListData.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    Colorid = json['color_id'];
    productName = json['product_name'];
    productInformation = json['product_information'];
    productImages = json['product_images'];
    productCode = json['product_code'];
    productPrice = json['product_price'];
    productDiscountRate = json['product_discount_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['color_id'] = this.Colorid;
    data['product_name'] = this.productName;
    data['product_information'] = this.productInformation;
    data['product_images'] = this.productImages;
    data['product_code'] = this.productCode;
    data['product_price'] = this.productPrice;
    data['product_discount_rate'] = this.productDiscountRate;
    return data;
  }
}