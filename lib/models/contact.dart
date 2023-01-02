class Contact {
  final String name;
  final String phone;

  Contact(this.name, this.phone);

  Contact.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        phone = json["phone"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  bool operator ==(Object other) {
    return other.runtimeType == Contact && other.toString() == toString();
  }
}
