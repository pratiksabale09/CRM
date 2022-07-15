//provider for vehicles

import 'dart:io';
import 'package:car_rental_mng_app/constants/apiconstants.dart';
import 'package:car_rental_mng_app/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:car_rental_mng_app/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VehicleProvider extends ChangeNotifier {
  AuthProvider authprovider = AuthProvider();
  VehicleProvider(this.authprovider);

  //default vehicle list
  List<Vehicle> vehicleList = [
    Vehicle(
        vehicleNo: 'MH14AA0000',
        isOutSideVehicle: false,
        vehicleType: 'vehicleType',
        brandName: 'Hyundai',
        brandModel: 'Xcent'),
    Vehicle(
        vehicleNo: 'MH14AA0000',
        isOutSideVehicle: false,
        vehicleType: 'vehicleType',
        brandName: 'Hyundai',
        brandModel: 'Xcent'),
    Vehicle(
        vehicleNo: 'MH14AA0000',
        isOutSideVehicle: false,
        vehicleType: 'vehicleType',
        brandName: 'Hyundai',
        brandModel: 'Xcent'),
    Vehicle(
        vehicleNo: 'MH14AA0000',
        isOutSideVehicle: false,
        vehicleType: 'vehicleType',
        brandName: 'Hyundai',
        brandModel: 'Xcent'),
           Vehicle(
        vehicleNo: 'MH14AA0000',
        isOutSideVehicle: false,
        vehicleType: 'vehicleType',
        brandName: 'Hyundai',
        brandModel: 'Xcent'),
    Vehicle(
        vehicleNo: 'MH14AA0000',
        isOutSideVehicle: false,
        vehicleType: 'vehicleType',
        brandName: 'Hyundai',
        brandModel: 'Xcent'),
    Vehicle(
        vehicleNo: 'MH14AA0000',
        isOutSideVehicle: false,
        vehicleType: 'vehicleType',
        brandName: 'Hyundai',
        brandModel: 'Xcent'),
    Vehicle(
        vehicleNo: 'MH14AA0000',
        isOutSideVehicle: false,
        vehicleType: 'vehicleType',
        brandName: 'Hyundai',
        brandModel: 'Xcent'),
        
  ];

  //getter
  List<Vehicle> get getVehicles {
    return vehicleList;
  }

  //fetch vehicle list
  Future<void> fetchAndSetVehicles() async {
    final url = Api.getVehicleList();
    print('Vehicle List Api: $url');
    String token = authprovider.gettoken.toString();
    print('token in vehicle Provider, while fetching vehicles: $token');
    Map<String, dynamic> extractedData = {};
    List<Vehicle> loadedVehicles = [];
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body.toString());
      extractedData = json.decode(response.body);
      print('Extracted Data: $extractedData');
      if (extractedData['error']) {
        loadedVehicles = [];
      } else {
        extractedData['items'].forEach((vehicleData) {
          loadedVehicles.add(Vehicle(
              vehicleNo: vehicleData['vehicleNo'],
              vehicleType: vehicleData['vehicleType'],
              brandName: vehicleData['brandName'],
              brandModel: vehicleData['brandModel'],
              isOutSideVehicle: vehicleData['isOutSideVehicle']));
        });
      }
      vehicleList = loadedVehicles;
      notifyListeners();
    } catch (error) {
      vehicleList = loadedVehicles;
      if (extractedData.isEmpty) {
        throw 'An error occured';
      } else {
        throw extractedData['message'];
      }
    }
  }

  //function to edit existing vehicle
  Future<void> editVehicleInList(Vehicle vehicle, Vehicle vehiclenew) async {
    String token = authprovider.gettoken.toString();
    final vehicleIndex = vehicleList.indexOf(vehicle);
    Map<String, dynamic> responseData = {};
    if (vehicleIndex >= 0) {
      final url = Api.editVehicleById(vehicle.id);
      print('Edit Vehicle List Api: $url');
      try {
        final response = await http.patch(Uri.parse(url), body: {
          'vehicleNo': vehiclenew.vehicleNo,
          'isOutSideVehicle': vehiclenew.isOutSideVehicle.toString(),
          'brandModel': vehiclenew.brandModel,
          'brandName': vehiclenew.brandName,
          'vehicleType': vehiclenew.vehicleType,
        }, headers: {
          'Authorization': 'Bearer $token'
        });
        print(response.body);
        responseData = jsonDecode(response.body);
        print("im here");
          vehicleList[vehicleIndex] = vehiclenew;
        notifyListeners();
      } catch (error) {
        if (responseData.isEmpty) {
          throw 'An error occured';
        } else {
          throw HttpException(responseData['message']);
        }
      }
      return Future.value();
    }
  }

  //function to add new vehilce
  Future<void> addVehicleInList(Vehicle vehicle) async {
    String token = authprovider.gettoken.toString();
    final url = Api.addVehicle();
    print('Api for add vehicle: $url');
    Map<String, dynamic> responseData = {};
    try {
      final response = await http.post(Uri.parse(url), body: {
        'vehicleNo': vehicle.vehicleNo,
        'isOutSideVehicle': vehicle.isOutSideVehicle.toString(),
        'brandModel': vehicle.brandModel,
        'brandName': vehicle.brandName,
        'vehicleType': vehicle.vehicleType,
        //'gpsEndPoint': vehicle.gpsEndPoint,
        //'orgId': vehicle.orgId,
        //'accId': vehicle.accId,
      }, headers: {
        'Authorization': 'Bearer $token'
      });
      responseData = jsonDecode(response.body);
      vehicleList.add(vehicle);
      notifyListeners();
    } catch (error) {
      if(responseData.isEmpty){
        throw 'An error occured';
      }else
      {
      throw HttpException(responseData['message']);
      }
    }
    return Future.value();
  }

  Future<void> deleteVehicle(Vehicle vehicle) async {
    String token = authprovider.gettoken.toString();
    Map<String, dynamic> responseData = {};
    final url = Api.deleteVehicleById(vehicle.id);
    final existingVehicleIndex =
        vehicleList.indexWhere((element) => (element == vehicle));
    Vehicle? existingVehicle = vehicleList[existingVehicleIndex];
    vehicleList.removeAt(existingVehicleIndex);
    notifyListeners();
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      notifyListeners();
      responseData = jsonDecode(response.body);
    } catch (error) {
      print(error);
      if (responseData.isEmpty) {
        vehicleList.insert(existingVehicleIndex, existingVehicle);
        notifyListeners();
        throw 'An Error Occured';
      } else {
        vehicleList.insert(existingVehicleIndex, existingVehicle);
        notifyListeners();
        throw HttpException(responseData['message']);
      }
    }
    existingVehicle = null;
  }
}
