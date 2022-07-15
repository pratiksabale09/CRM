//provider for vehicles

import 'dart:io';
import 'package:car_rental_mng_app/constants/apiconstants.dart';
import 'package:car_rental_mng_app/models/Address.dart';
import 'package:car_rental_mng_app/models/enums/booked_by_type.dart';
import 'package:car_rental_mng_app/models/enums/geolocation.dart';
import 'package:car_rental_mng_app/models/enums/tripstatustype.dart';
import 'package:car_rental_mng_app/models/enums/triptype.dart';
import 'package:car_rental_mng_app/models/trip.dart';
import 'package:car_rental_mng_app/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripsProvider extends ChangeNotifier {
  AuthProvider authprovider = AuthProvider();
  GeoLocation geolocation = GeoLocation();
  DateTime bookingDate = DateTime(1);
  TripsProvider(this.authprovider);

  //default trips list
  List<Trip> tripList = [
    Trip(
        id: "",
        from: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        to: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        status: TripStatusType(),
        tripType: TripType(),
        userName: 'userName',
        userMob: 'userMob',
        bookedBy: BookedByType(),
        bookedByName: 'bookedByName',
        bookingDate: DateTime.now(),
        driverId: 'driverId',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
        startKm: 1,
        endKm: 1,
        tripCharges: 'tripCharges',
        tripDetails: 'tripDetails',
        isOutSideDriver: false,
        isOutSideVehicle: false,
        otherDetails: 'otherDetails',
        vehicleId: 'ID'),
    Trip(
        id: "",
        from: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        to: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        status: TripStatusType(),
        tripType: TripType(),
        userName: 'userName',
        userMob: 'userMob',
        bookedBy: BookedByType(),
        bookedByName: 'bookedByName',
        bookingDate: DateTime.now(),
        driverId: 'driverId',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
        startKm: 1,
        endKm: 1,
        tripCharges: 'tripCharges',
        tripDetails: 'tripDetails',
        isOutSideDriver: false,
        isOutSideVehicle: false,
        otherDetails: 'otherDetails',
        vehicleId: 'ID'),
    Trip(
        id: "",
        from: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        to: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        status: TripStatusType(),
        tripType: TripType(),
        userName: 'userName',
        userMob: 'userMob',
        bookedBy: BookedByType(),
        bookedByName: 'bookedByName',
        bookingDate: DateTime.now(),
        driverId: 'driverId',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
        startKm: 1,
        endKm: 1,
        tripCharges: 'tripCharges',
        tripDetails: 'tripDetails',
        isOutSideDriver: false,
        isOutSideVehicle: false,
        otherDetails: 'otherDetails',
        vehicleId: 'ID'),
    Trip(
        id: "",
        from: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        to: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        status: TripStatusType(),
        tripType: TripType(),
        userName: 'userName',
        userMob: 'userMob',
        bookedBy: BookedByType(),
        bookedByName: 'bookedByName',
        bookingDate: DateTime.now(),
        driverId: 'driverId',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
        startKm: 1,
        endKm: 1,
        tripCharges: 'tripCharges',
        tripDetails: 'tripDetails',
        isOutSideDriver: false,
        isOutSideVehicle: false,
        otherDetails: 'otherDetails',
        vehicleId: 'ID'),
    Trip(
        id: "",
        from: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        to: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        status: TripStatusType(),
        tripType: TripType(),
        userName: 'userName',
        userMob: 'userMob',
        bookedBy: BookedByType(),
        bookedByName: 'bookedByName',
        bookingDate: DateTime.now(),
        driverId: 'driverId',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
        startKm: 1,
        endKm: 1,
        tripCharges: 'tripCharges',
        tripDetails: 'tripDetails',
        isOutSideDriver: false,
        isOutSideVehicle: false,
        otherDetails: 'otherDetails',
        vehicleId: 'ID'),
    Trip(
        id: "",
        from: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        to: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        status: TripStatusType(),
        tripType: TripType(),
        userName: 'userName',
        userMob: 'userMob',
        bookedBy: BookedByType(),
        bookedByName: 'bookedByName',
        bookingDate: DateTime.now(),
        driverId: 'driverId',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
        startKm: 1,
        endKm: 1,
        tripCharges: 'tripCharges',
        tripDetails: 'tripDetails',
        isOutSideDriver: false,
        isOutSideVehicle: false,
        otherDetails: 'otherDetails',
        vehicleId: 'ID'),
    Trip(
        id: "",
        from: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        to: Address(
            street: 'street',
            landmark: 'landmark',
            city: 'city',
            pincode: 'pincode',
            state: 'state'),
        status: TripStatusType(),
        tripType: TripType(),
        userName: 'userName',
        userMob: 'userMob',
        bookedBy: BookedByType(),
        bookedByName: 'bookedByName',
        bookingDate: DateTime.now(),
        driverId: 'driverId',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
        startKm: 1,
        endKm: 1,
        tripCharges: 'tripCharges',
        tripDetails: 'tripDetails',
        isOutSideDriver: false,
        isOutSideVehicle: false,
        otherDetails: 'otherDetails',
        vehicleId: 'ID'),
  ];

  //getter
  List<Trip> get getTrips {
    return tripList;
  }

  Future<void> fetchAndSetTrips() async {
    final url = Api.getTripList();
    print('Trip List List Api: $url');
    String token = authprovider.gettoken.toString();
    print('token in trip Provider, while fetching trips: $token');
    Map<String, dynamic> extractedData = {};
    List<Trip> loadedTrips = [];
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body.toString());
      extractedData = json.decode(response.body);
      print('Extracted Data: $extractedData');
      if (extractedData['error']) {
        loadedTrips = [];
      } else {
        extractedData['items'].forEach((tripData) {
          loadedTrips.add(Trip(
              id: tripData['id'],
              from: tripData['from'],
              to: tripData['to'],
              status: tripData['status'],
              tripType: tripData['tripType'],
              userName: tripData['userName'],
              userMob: tripData['userMob'],
              bookedBy: tripData['bookedBy'],
              bookedByName: tripData['bookedByName'],
              bookingDate: tripData['bookingDate'],
              driverId: tripData['driverId'],
              startDateTime: tripData['startDateTime'],
              endDateTime: tripData['endDateTime'],
              startKm: tripData['startKm'],
              endKm: tripData['endKm'],
              tripCharges: tripData['tripCharges'],
              tripDetails: tripData['tripDetails'],
              isOutSideDriver: tripData['isOutSideDriver'],
              isOutSideVehicle: tripData['isOutSideVehicle'],
              otherDetails: tripData['otherDetails'],
              vehicleId: tripData['vehicleId']));
        });
      }
      tripList = loadedTrips;
      notifyListeners();
    } catch (error) {
      tripList = loadedTrips;
      if (extractedData.isEmpty) {
        throw 'An error occured';
      } else {
        throw extractedData['message'];
      }
    }
  }

  //function to edit existing trip
  Future<void> editTripInList(Trip trip, Trip tripnew) async {
    String token = authprovider.gettoken.toString();
    final tripIndex = tripList.indexOf(trip);
    Map<String, dynamic> responseData = {};
    if (tripIndex >= 0) {
      final url = Api.editTripById(trip.id);
      print('Edit Trip List Api: $url');
      try {
        final response = await http.patch(Uri.parse(url), body: {
          'id': tripnew.id,
          'from': tripnew.from,
          'to': tripnew.to,
          'status': tripnew.status,
          'tripType': tripnew.tripType,
          'userName': tripnew.userName,
          'userMob': tripnew.userMob,
          'bookedBy': tripnew.bookedBy,
          'bookedByName': tripnew.bookedByName,
          'bookingDate': tripnew.bookingDate,
          'driverId': tripnew.driverId,
          'startDateTime': tripnew.startDateTime,
          'endDateTime': tripnew.endDateTime,
          'startKm': tripnew.startKm,
          'endKm': tripnew.endKm,
          'tripCharges': tripnew.tripCharges,
          'tripDetails': tripnew.tripDetails,
          'isOutSideDriver': tripnew.isOutSideDriver,
          'isOutSideVehicle': tripnew.isOutSideVehicle,
          'otherDetails': tripnew.otherDetails,
          'vehicleId': tripnew.vehicleId,
        }, headers: {
          'Authorization': 'Bearer $token'
        });
        print(response.body);
        responseData = jsonDecode(response.body);
        tripList[tripIndex] = tripnew;
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

  //function to add new trip
  Future<void> addTripInList(Trip trip) async {
    String token = authprovider.gettoken.toString();
    final url = Api.addTrip();
    print('Api for add add: $url');
    Map<String, dynamic> responseData = {};
    try {
      final response = await http.post(Uri.parse(url), body: {
        'id': trip.id,
        'from': trip.from,
        'to': trip.to,
        'status': trip.status,
        'tripType': trip.tripType,
        'userName': trip.userName,
        'userMob': trip.userMob,
        'bookedBy': trip.bookedBy,
        'bookedByName': trip.bookedByName,
        'bookingDate': trip.bookingDate,
        'driverId': trip.driverId,
        'startDateTime': trip.startDateTime,
        'endDateTime': trip.endDateTime,
        'startKm': trip.startKm,
        'endKm': trip.endKm,
        'tripCharges': trip.tripCharges,
        'tripDetails': trip.tripDetails,
        'isOutSideDriver': trip.isOutSideDriver,
        'isOutSideVehicle': trip.isOutSideVehicle,
        'otherDetails': trip.otherDetails,
        'vehicleId': trip.vehicleId,
      }, headers: {
        'Authorization': 'Bearer $token'
      });
      responseData = jsonDecode(response.body);
      tripList.add(trip);
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

  //function to delete trip
  Future<void> deleteTrip(Trip trip) async {
    String token = authprovider.gettoken.toString();
    Map<String, dynamic> responseData = {};
    final url = Api.deleteTripById(trip.id);
    final existingTripIndex =
        tripList.indexWhere((element) => (element == trip));
    Trip? existingTrip = tripList[existingTripIndex];
    tripList.removeAt(existingTripIndex);
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
        tripList.insert(existingTripIndex, existingTrip);
        notifyListeners();
        throw 'An Error Occured';
      } else {
        tripList.insert(existingTripIndex, existingTrip);
        notifyListeners();
        throw HttpException(responseData['message']);
      }
    }
    existingTrip = null;
  }
}
