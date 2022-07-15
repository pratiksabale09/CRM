import 'package:car_rental_mng_app/models/organization.dart';
import 'package:car_rental_mng_app/models/role.dart';
import 'package:car_rental_mng_app/models/user.dart';
import 'address.dart';
import 'driving_license.dart';
import 'enums/gender.dart';

class UserProfileModel {

  String id;
  String mobile;
  String password;
  String name;
  Gender gender;
  bool isDisabled = true;
  User userType;
  String email;
  Address address;
  DateTime dob;
  bool isOutSideDriver;
  Organization orgId;
  String accId;
  Role roleId;
  DrivingLicense drivingLicense;
  DateTime createdAt;
  DateTime updatedAt;
  
  UserProfileModel({required this.id, required this.password, 
  required this.mobile, required this.name, 
  required this.gender, required this.accId, required this.orgId, 
  required this.roleId, required this.userType, required this.address, required this.createdAt, required this.dob,
   required this.drivingLicense, required this.email, required this.isDisabled, required this.isOutSideDriver, required this.updatedAt});

}