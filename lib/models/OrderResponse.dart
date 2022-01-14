import 'AcoountResponse.dart';

class OrderResponse {
  bool success;
  Data data;
  String message;

  OrderResponse({this.success, this.data, this.message});

  OrderResponse.fromJson(Map<String, dynamic> json) {
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
  List<OrderStatus> order;

  Data({this.order});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = new List<OrderStatus>();
      json['order'].forEach((v) {
        order.add(new OrderStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order.map((v) => v.toJson()).toList();
    }
    return data;
  }
}