class CreateyourstyleRespose {
  bool success;
  List<StyleData> data;
  String message;

  CreateyourstyleRespose({this.success, this.data, this.message});

  CreateyourstyleRespose.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<StyleData>();
      json['data'].forEach((v) {
        data.add(new StyleData.fromJson(v));
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

class StyleData {
  int id;
  String name;

  StyleData({this.id, this.name});

  StyleData.fromJson(Map<String, dynamic> json) {
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