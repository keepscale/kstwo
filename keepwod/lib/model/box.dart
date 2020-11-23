class Box {
  String name;
  String logoUrl;

  Box({this.name, this.logoUrl});

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(name: json['name'], logoUrl: json['logoUrl']);
  }
}
