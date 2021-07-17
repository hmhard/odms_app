import 'package:organd/models/user.dart';

class Donor {
  final String firstName;
  final String middleName;
  final String lastName;
  final String sex;
  final String phone;
  final String email;
  final String bloodType;
  final String organ;
  final int id;
  final String title;

  Donor({
      this.firstName,
      this.middleName,
      this.lastName,
      this.sex,
      this.phone,
      this.email,
      this.bloodType,
      this.organ,
      this.id,
      this.title,
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(

      firstName: json['data']['firstName'],
      middleName: json['data']['middleName'],
      lastName: json['data']['lastName'],
      sex: json['data']['sex'],
      phone: json['data']['phone'],
      email: json['data']['email'],
      bloodType: json['data']['bloodType'],
      organ: json['data']['organ_name'],

    );
  }
}