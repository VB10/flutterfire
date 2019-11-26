class Student {
  String key;
  String name;
  int number;

  Student({this.key, this.name, this.number});

  Student.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['number'] = this.number;
    return data;
  }
}
