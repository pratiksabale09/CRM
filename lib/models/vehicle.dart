class Vehicle {
  String id = '';
  String vehicleNo;
  bool isOutSideVehicle;
  dynamic orgId;
  dynamic accId;
  String? gpsEndPoint;
  String vehicleType;
  String brandName;
  String brandModel;
  Vehicle(
      {required this.vehicleNo,
      required this.vehicleType,
      required this.brandName,
      required this.brandModel,
      required this.isOutSideVehicle});
  Vehicle.full(
      {required this.id,
      required this.vehicleNo,
      required this.isOutSideVehicle,
      required this.orgId,
      required this.accId,
      required this.gpsEndPoint,
      required this.vehicleType,
      required this.brandName,
      required this.brandModel});
}
