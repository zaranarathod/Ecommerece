class ProductlistResponse {
  bool success;
  Data data;
  String message;

  ProductlistResponse({this.success, this.data, this.message});

  ProductlistResponse.fromJson(Map<String, dynamic> json) {
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
  int totalPages;
  List<Products> products;

  Data({this.products, this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_page'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_page'] = this.totalPages;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int pid;
  String productName;
  String productCode;
  String productCategory;
  String productPrice;
  String productInformation;
  String productRating;
  String productRateBy;
  String productFabric;
  List<ProductColor> productColor;
  String discountEnable;
  String productDiscountRate;
  String productDiscount;
  String productTrending;
  List<Map<String, dynamic>> additionalInfo;
  List<String> productImages;

  Products({
    this.additionalInfo,
    this.pid,
    this.productName,
    this.productCode,
    this.productCategory,
    this.productPrice,
    this.productInformation,
    this.productRating,
    this.productRateBy,
    this.productFabric,
    this.productColor,
    this.discountEnable,
    this.productDiscountRate,
    this.productDiscount,
    this.productTrending,
    this.productImages});

  Products.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    productName = json['product_name'];
    productCode = json['product_code'];
    productCategory = json['product_category'];
    productPrice = json['product_price'];
    productInformation = json['product_information'];
    productRating = json['product_rating'];
    productRateBy = json['product_rate_by'];
    productFabric = json['product_fabric'];
    if (json['product_color'] != null) {
      productColor = new List<ProductColor>();
      json['product_color'].forEach((v) {
        productColor.add(new ProductColor.fromJson(v));
      });
    }
    discountEnable = json['discount_enable'];
    productDiscountRate = json['product_discount_rate'];
    productDiscount = json['product_discount'];
    productTrending = json['product_trending'];
    productImages = json['product_images'].cast<String>();
    additionalInfo =
        json['additional_product_information'].cast<Map<String, dynamic>>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['product_category'] = this.productCategory;
    data['product_price'] = this.productPrice;
    data['product_information'] = this.productInformation;
    data['product_rating'] = this.productRating;
    data['product_rate_by'] = this.productRateBy;
    data['product_fabric'] = this.productFabric;
    if (this.productColor != null) {
      data['product_color'] = this.productColor.map((v) => v.toJson()).toList();
    }
    data['discount_enable'] = this.discountEnable;
    data['product_discount_rate'] = this.productDiscountRate;
    data['product_discount'] = this.productDiscount;
    data['product_trending'] = this.productTrending;
    data['product_images'] = this.productImages;
    data['additional_product_information'] = this.additionalInfo;
    return data;
  }
}


class ProductColor {
  int id;
  bool isSelected = false;
  String colorName;
  String colorCode;

  ProductColor({this.id, this.colorName, this.colorCode, this.isSelected});

  ProductColor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    colorName = json['color_name'];
    colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color_name'] = this.colorName;
    data['color_code'] = this.colorCode;
    return data;
  }
}