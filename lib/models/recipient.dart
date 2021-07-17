import 'package:organd/models/user.dart';

class Recipient {
  final String firstName;
  final String middleName;
  final String lastName;
  final String sex;
  final String phone;
  final String email;
  final String bloodType;
  final String organNeeded;
  final int id;
  final String title;

  Recipient({
      this.firstName,
      this.middleName,
      this.lastName,
      this.sex,
      this.phone,
      this.email,
      this.bloodType,
      this.organNeeded,
      this.id,
      this.title,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) {
    return Recipient(

      firstName: json['data']['firstName'],
      middleName: json['data']['middleName'],
      lastName: json['data']['lastName'],
      sex: json['data']['sex'],
      phone: json['data']['phone'],
      email: json['data']['email'],
      bloodType: json['data']['bloodType'],
      organNeeded: json['data']['organ_name'],

    );
  }
}