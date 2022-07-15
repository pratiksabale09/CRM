import 'package:car_rental_mng_app/models/user.dart';

class Signup extends User{
  String otp;
  

  Signup({required this.otp}) : super(accId: super.accId, address: super.address, id: super.id, mobile: super.mobile,
  password: super.password, name: super.name,
  isDisabled: super.isDisabled, userType: super.userType, email: super.email, 
  dob: super.dob, isOutSideDriver: super.isOutSideDriver, orgId: super.orgId, roleId: super.roleId,
  createdAt: super.createdAt, updatedAt: super.updatedAt, drivingLicense: super.drivingLicense);
}