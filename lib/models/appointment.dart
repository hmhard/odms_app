import 'package:organd/models/user.dart';

class Appointment {

  final int id;
  final int  donor_id;
  final int status;
  final int user_id;
  final DateTime appointmentDate;
  final String firstName;
  final String middleName;
  final String lastName;


  Appointment({
      this.status,
      this.donor_id,
      this.user_id,
      this.appointmentDate,
      this.firstName,
      this.middleName,
      this.lastName,
      this.id,

  });



  factory Appointment.fromJson(Map<dynamic, dynamic> json) {
   var  data=json['data'];
   if(data==null)
     return Appointment();

    return Appointment(

      id: data['appointment_id'],
    donor_id:data['donor_id'],
    status: data['status'],
    appointmentDate: DateTime.parse(data['appointmentDate']),
    user_id: data['user_id'],
    firstName: data['firstName'],
    middleName: data['middleName'],
    lastName: data['lastName'],

    );
  }
}