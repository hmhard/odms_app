class User {

  final int id;
  final String email;
  final String firstName;
  final String middleName;
  final String lastName;
  final String sex;
  final String phone;
    bool isActive;
  final  String birthDate;

  User({

      this.id,
      this.email,
      this.firstName,
      this.middleName,
      this.lastName,
      this.sex,
      this.phone,
      this.birthDate,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
    );
  }

  @override
  String toString() {
    return 'User{firstName: ${firstName}, middleName: $middleName, lastName: $lastName}';
  }
}