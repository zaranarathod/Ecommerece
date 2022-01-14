class GoogleLogInResponse {
  List<Names> names;
  List<Genders> genders;
  List<Birthdays> birthdays;
  List<PhoneNumbers> phoneNumbers;

  GoogleLogInResponse(
      {this.names, this.genders, this.birthdays, this.phoneNumbers});

  GoogleLogInResponse.fromJson(Map<String, dynamic> json) {
    if (json['names'] != null) {
      names = List<Names>();
      json['names'].forEach((v) {
        names.add(Names.fromJson(v));
      });
    }
    if (json['genders'] != null) {
      genders = new List<Genders>();
      json['genders'].forEach((v) {
        genders.add(Genders.fromJson(v));
      });
    }
    if (json['birthdays'] != null) {
      birthdays = List<Birthdays>();
      json['birthdays'].forEach((v) {
        birthdays.add(Birthdays.fromJson(v));
      });
    }
    if (json['phoneNumbers'] != null) {
      phoneNumbers = List<PhoneNumbers>();
      json['phoneNumbers'].forEach((v) {
        phoneNumbers.add(PhoneNumbers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.names != null) {
      data['names'] = this.names.map((v) => v.toJson()).toList();
    }
    if (this.genders != null) {
      data['genders'] = this.genders.map((v) => v.toJson()).toList();
    }
    if (this.birthdays != null) {
      data['birthdays'] = this.birthdays.map((v) => v.toJson()).toList();
    }
    if (this.phoneNumbers != null) {
      data['phoneNumbers'] = this.phoneNumbers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Names {
  String familyName;
  String givenName;

  Names({
    this.familyName,
    this.givenName,
  });

  Names.fromJson(Map<String, dynamic> json) {
    familyName = json['familyName'];
    givenName = json['givenName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['familyName'] = this.familyName;
    data['givenName'] = this.givenName;

    return data;
  }
}

class Genders {
  String formattedValue;

  Genders({this.formattedValue});

  Genders.fromJson(Map<String, dynamic> json) {
    formattedValue = json['formattedValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['formattedValue'] = this.formattedValue;
    return data;
  }
}

class Birthdays {
  Date date;

  Birthdays({this.date});

  Birthdays.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? Date.fromJson(json['date']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    return data;
  }
}

class Date {
  int year;
  int month;
  int day;

  Date({this.year, this.month, this.day});

  Date.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
    return data;
  }
}

class PhoneNumbers {
  String value;

  PhoneNumbers({this.value});

  PhoneNumbers.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['value'] = this.value;

    return data;
  }
}
