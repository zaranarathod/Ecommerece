class FacebookResponse {
  String name;
  String firstName;
  String lastName;
  String email;
  String id;
  String birthday;
  String gender;

  FacebookResponse({this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.id,
    this.birthday,
    this.gender});

  FacebookResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    id = json['id'];
    birthday = json['birthday'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['id'] = this.id;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    return data;
  }
}