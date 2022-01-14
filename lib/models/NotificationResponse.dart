class NotificationResponse {
  bool success;
  Data data;
  String message;

  NotificationResponse({this.success, this.data, this.message});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
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
  List<notificationdata> notification;

  Data({this.notification});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notification'] != null) {
      notification = new List<notificationdata>();
      json['notification'].forEach((v) {
        notification.add(new notificationdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notification != null) {
      data['notification'] = this.notification.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class notificationdata {
  String title;
  String description;
  String image;
  String earlier;

  notificationdata({this.title, this.description, this.image, this.earlier});

  notificationdata.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    earlier = json['earlier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['earlier'] = this.earlier;
    return data;
  }
}