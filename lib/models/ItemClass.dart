class ItemClass {
  String pid;
  String pcount;
  String color_id;


  ItemClass(this.pid,
      this.pcount,
      this.color_id);

  ItemClass.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    pcount = json['pcount'];
    color_id = json['color_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['pcount'] = this.pcount;
    data['color_id'] = this.color_id;
    return data;
  }
}