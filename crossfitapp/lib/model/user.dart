class User{
  final String firstname;
  final String lastname;
  final String email;

  User({this.firstname, this.lastname, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstname: json['firstName'],
      lastname: json['lastName'],
      email: json['email'],
    );
  }

}