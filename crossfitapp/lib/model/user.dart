class User{

  final int id;
  final String title;
  final String firstName;
  final String lastName;
  final String nickName;
  final String address;
  final String zipCode;
  final String city;
  final String telephonNumber;
  final String email;

  User({this.id, this.title, this.firstName, this.lastName, this.nickName, 
    this.address, this.zipCode, this.city, this.telephonNumber, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      title: json['title'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      nickName: json['nickName'],
      address: json['address'],
      zipCode: json['zipCode'],
      city: json['city'],
      telephonNumber: json['telephonNumber'],
      email: json['email']
    );
  }

}