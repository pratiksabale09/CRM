import 'package:car_rental_mng_app/models/Address.dart';
import 'package:car_rental_mng_app/models/user.dart';
import 'package:car_rental_mng_app/models/vehicle.dart';

import 'enums/booked_by_type.dart';
import 'enums/tripstatustype.dart';
import 'enums/triptype.dart';

class Trip {
  String id;
  Address from;
  Address to;
  TripStatusType status;
  DateTime bookingDate;
  TripType tripType;
  String userName;
  String userMob;
  BookedByType bookedBy;
  String bookedByName;
  DateTime startDateTime;
  DateTime endDateTime;
  int startKm;
  int endKm;
  Object tripCharges;
  String tripDetails;
  String otherDetails;
  bool isOutSideVehicle;
  String vehicleId;
  bool isOutSideDriver;
  String driverId;
  
  Trip({required this.id, required this.from, required this.to, required this.status, required this.tripType,
   required this.userName, required this.userMob, required this.bookedBy, required this.bookedByName, 
   required this.bookingDate, required this.driverId, required this.startDateTime,
   required this.endDateTime, required this.startKm, required this.endKm,
   required this.tripCharges, required this.tripDetails, required this.isOutSideDriver,
   required this.isOutSideVehicle, required this.otherDetails, required this.vehicleId});
}