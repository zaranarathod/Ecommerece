class GetAppDataResponse {
  bool success;
  Data data;
  String message;

  GetAppDataResponse({this.success, this.data, this.message});

  GetAppDataResponse.fromJson(Map<String, dynamic> json) {
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
  String companyname;
  String contactusemail;
  String whatsappnumber;
  String privacypolicylink;
  String shippingpolicylink;
  String returnpolicylink;
  String maxprice;
  String razorpay;
  String minprice;
  String aboutuslink;
  String notificationTitle;
  String notificationText;
  String shareUrl;
  List<String> paymenttype;
  List<String> login;
  String codCouriercharge;
  String maxAmountCod;
  String instagram;
  List<Colorslist> colorslist;
  List<Fabriclist> fabriclist;
  List<Category> category;

  Data({this.companyname,
    this.contactusemail,
    this.whatsappnumber,
    this.privacypolicylink,
    this.shippingpolicylink,
    this.returnpolicylink,
    this.maxprice,
    this.razorpay,
    this.minprice,
    this.aboutuslink,
    this.notificationTitle,
    this.notificationText,
    this.shareUrl,
    this.paymenttype,
    this.login,
    this.codCouriercharge,
    this.maxAmountCod,
    this.instagram,
    this.colorslist,
    this.fabriclist,
    this.category});

  Data.fromJson(Map<String, dynamic> json) {
    companyname = json['companyname'];
    contactusemail = json['contactusemail'];
    whatsappnumber = json['whatsappnumber'];
    privacypolicylink = json['privacypolicylink'];
    shippingpolicylink = json['shippingpolicylink'];
    returnpolicylink = json['returnpolicylink'];
    maxprice = json['maxprice'];
    razorpay = json['razorpay_id'];
    minprice = json['minprice'];
    aboutuslink = json['aboutuslink'];
    notificationTitle = json['notification_title'];
    notificationText = json['notification_text'];
    shareUrl = json['share_url'];
    paymenttype = json['paymenttype'].cast<String>();
    login = json['login'].cast<String>();
    codCouriercharge = json['cod_couriercharge'];
    maxAmountCod = json['max_amount_cod'];
    instagram = json['instagram'];
    if (json['colorslist'] != null) {
      colorslist = new List<Colorslist>();
      json['colorslist'].forEach((v) {
        colorslist.add(new Colorslist.fromJson(v));
      });
    }
    if (json['fabriclist'] != null) {
      fabriclist = new List<Fabriclist>();
      json['fabriclist'].forEach((v) {
        fabriclist.add(new Fabriclist.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyname'] = this.companyname;
    data['contactusemail'] = this.contactusemail;
    data['whatsappnumber'] = this.whatsappnumber;
    data['razorpay_id'] = this.razorpay;
    data['privacypolicylink'] = this.privacypolicylink;
    data['shippingpolicylink'] = this.shippingpolicylink;
    data['returnpolicylink'] = this.returnpolicylink;
    data['maxprice'] = this.maxprice;
    data['minprice'] = this.minprice;
    data['aboutuslink'] = this.aboutuslink;
    data['notification_title'] = this.notificationTitle;
    data['notification_text'] = this.notificationText;
    data['share_url'] = this.shareUrl;
    data['paymenttype'] = this.paymenttype;
    data['login'] = this.login;
    data['cod_couriercharge'] = this.codCouriercharge;
    data['max_amount_cod'] = this.maxAmountCod;
    data['instagram'] = this.instagram;
    if (this.colorslist != null) {
      data['colorslist'] = this.colorslist.map((v) => v.toJson()).toList();
    }
    if (this.fabriclist != null) {
      data['fabriclist'] = this.fabriclist.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Colorslist {
  int id;
  bool selected = false;
  String name;
  String colorCode;

  Colorslist({this.id, this.name, this.colorCode});

  Colorslist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    selected = false;
    colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['selected'] = this.selected;
    data['color_code'] = this.colorCode;
    return data;
  }
}

class Fabriclist {
  int id;
  bool selected = false;
  String name;

  Fabriclist({this.id, this.name});

  Fabriclist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selected = false;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['selected'] = this.selected;
    data['name'] = this.name;
    return data;
  }
}

class Category {
  int id;
  String name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}