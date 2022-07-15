import 'address.dart';
import 'driving_license.dart';

class User {

  String id;
  String mobile;
  String password;
  String name;
  bool isDisabled = true;
  User userType;
  String? email;
  Address? address;
  DateTime? dob;
  bool? isOutSideDriver;
  String orgId;
  String accId;
  String roleId;
  DrivingLicense? drivingLicense;
  DateTime? createdAt;
  DateTime? updatedAt;
  User({required this.id, required this.password, required this.mobile, 
  required this.name, required this.isDisabled, required this.userType, required this.email, required this.address,
  required this.dob, required this.isOutSideDriver, required this.accId, required this.roleId, required this.createdAt, required this.drivingLicense,
  required this.orgId, required this.updatedAt});

}