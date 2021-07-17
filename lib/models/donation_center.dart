import 'package:organd/models/user.dart';

class DonationCenter {
  final String name;
  final String address;
  final String photo;
  final String location;
  final String description;

  final int id;

  DonationCenter({
      this.name,
      this.address,
      this.photo,
      this.location,
      this.description,
      this.id,

  });



  factory DonationCenter.fromJson(Map<dynamic, dynamic> json) {
   var  data=json;
   print("don");
   print(json);
    return DonationCenter(

      name: data['name'],
      address: data['address'],
      photo: data['photo'],
      location: data['location'],
      description: data['description'],

    );
  }
}