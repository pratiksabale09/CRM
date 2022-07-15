//provider for oraganizations

import 'dart:io';
import 'package:car_rental_mng_app/constants/apiconstants.dart';
import 'package:car_rental_mng_app/models/organization.dart';
import 'package:car_rental_mng_app/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrgProvider extends ChangeNotifier {
  //default organization list
  final AuthProvider authprovider;
  OrgProvider(this.authprovider);

  List<Organization> orgList = [
    Organization(
        name: 'name',
        legalName: 'legalName',
        brandName: 'brandName',
        tagLine: 'tagLine',
        smsLable: 'smsLable',
        smsConfig: 'smsConfig',
        gstNumber: 'gstNumber',
        orgType: 'orgType',
        orgId: 'orgId',
        accId: 'accId',
        website: 'website',
        termOfService: 'termOfService',
        privacyPolicy: 'privacyPolicy'),
    Organization(
        name: 'name',
        legalName: 'legalName',
        brandName: 'brandName',
        tagLine: 'tagLine',
        smsLable: 'smsLable',
        smsConfig: 'smsConfig',
        gstNumber: 'gstNumber',
        orgType: 'orgType',
        orgId: 'orgId',
        accId: 'accId',
        website: 'website',
        termOfService: 'termOfService',
        privacyPolicy: 'privacyPolicy'),
    Organization(
        name: 'name',
        legalName: 'legalName',
        brandName: 'brandName',
        tagLine: 'tagLine',
        smsLable: 'smsLable',
        smsConfig: 'smsConfig',
        gstNumber: 'gstNumber',
        orgType: 'orgType',
        orgId: 'orgId',
        accId: 'accId',
        website: 'website',
        termOfService: 'termOfService',
        privacyPolicy: 'privacyPolicy'),
    Organization(
        name: 'name',
        legalName: 'legalName',
        brandName: 'brandName',
        tagLine: 'tagLine',
        smsLable: 'smsLable',
        smsConfig: 'smsConfig',
        gstNumber: 'gstNumber',
        orgType: 'orgType',
        orgId: 'orgId',
        accId: 'accId',
        website: 'website',
        termOfService: 'termOfService',
        privacyPolicy: 'privacyPolicy'),
    Organization(
        name: 'name',
        legalName: 'legalName',
        brandName: 'brandName',
        tagLine: 'tagLine',
        smsLable: 'smsLable',
        smsConfig: 'smsConfig',
        gstNumber: 'gstNumber',
        orgType: 'orgType',
        orgId: 'orgId',
        accId: 'accId',
        website: 'website',
        termOfService: 'termOfService',
        privacyPolicy: 'privacyPolicy'),
    Organization(
        name: 'name',
        legalName: 'legalName',
        brandName: 'brandName',
        tagLine: 'tagLine',
        smsLable: 'smsLable',
        smsConfig: 'smsConfig',
        gstNumber: 'gstNumber',
        orgType: 'orgType',
        orgId: 'orgId',
        accId: 'accId',
        website: 'website',
        termOfService: 'termOfService',
        privacyPolicy: 'privacyPolicy'),
    Organization(
        name: 'name',
        legalName: 'legalName',
        brandName: 'brandName',
        tagLine: 'tagLine',
        smsLable: 'smsLable',
        smsConfig: 'smsConfig',
        gstNumber: 'gstNumber',
        orgType: 'orgType',
        orgId: 'orgId',
        accId: 'accId',
        website: 'website',
        termOfService: 'termOfService',
        privacyPolicy: 'privacyPolicy'),
  ];

  //getter
  List<Organization> get getOrgs {
    return orgList;
  }

  //fetch orgs
  Future<void> fetchAndSetOrgs() async {
    final url = Api.getOrgList(); //remove the string interpolation once api is created
    print('Vehicle List Api: $url');
    String token = authprovider.gettoken.toString();
    print('token in vehicle Provider, while fetching vehicles: $token');
    Map<String, dynamic> extractedData = {};
    List<Organization> loadedOrgs = [];
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body.toString());
      extractedData = json.decode(response.body);
      print('Extracted Data: $extractedData');
      if (extractedData['error']) {
        loadedOrgs = [];
      } else {
        extractedData['items'].forEach((orgData) {
          loadedOrgs.add(Organization(
            name: orgData['name'],
            legalName: orgData['legalName'],
            brandName: orgData['brandName'],
            tagLine: orgData['tagLine'],
            smsLable: orgData['smsLable'],
            smsConfig: orgData['smsConfig'],
            gstNumber: orgData['gstNumber'],
            orgType: orgData['orgType'],
            orgId: orgData['orgId'],
            accId: orgData['accId'],
            website: orgData['website'],
            termOfService: orgData['termOfService'],
            privacyPolicy: orgData['privacyPolicy'],
          ));
        });
      }
      orgList = loadedOrgs;
      notifyListeners();
    } catch (error) {
      orgList = loadedOrgs;
      if (extractedData.isEmpty) {
        throw 'An error occured';
      } else {
        throw extractedData['message'];
      }
    }
  }

  //function to edit existing organization
  Future<void> editOrgInList(Organization organization, Organization neworg) async {
    String token = authprovider.gettoken.toString();
    final orgIndex = orgList.indexOf(organization);
    Map<String, dynamic> responseData = {};
    if (orgIndex >= 0) {
      final url = Api.editOrgById(organization.id);//remove the string interpolation once api's are created
      print('Edit Vehicle List Api: $url');
      try {
        final response = await http.patch(Uri.parse(url), body: {
            'name': neworg.name,
            'legalName': neworg.legalName,
            'brandName': neworg.brandName,
            'tagLine': neworg.tagLine,
            'smsLable': neworg.smsLable,
            'smsConfig': neworg.smsConfig,
            'gstNumber': neworg.gstNumber,
            'orgType': neworg.orgType,
            'orgId': neworg.orgId,
            'accId': neworg.accId,
            'website': neworg.website,
            'termOfService': neworg.termOfService,
            'privacyPolicy': neworg.privacyPolicy,
          }, headers: {
          'Authorization': 'Bearer $token'
        });
        print(response.body);
        responseData = jsonDecode(response.body);
        print("im here");
          orgList[orgIndex] = neworg;
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

  //function to add new org
  Future<void> addOrgInList(Organization org) async {
    String token = authprovider.gettoken.toString();
    final url =
         Api.addOrg(); //remove this string inperpolation once organizations api are ready
    print('Api for add vehicle: $url');
    Map<String, dynamic> responseData = {};
    try {
      final response = await http.post(Uri.parse(url), body: {
        'name': org.name,
        'legalName': org.legalName,
        'brandName': org.brandName,
        'tagLine': org.tagLine,
        'smsLable': org.smsLable,
        'smsConfig': org.smsConfig,
        'gstNumber': org.gstNumber,
        'orgType': org.orgType,
        'orgId': org.orgId,
        'accId': org.accId,
        'website': org.website,
        'termOfService': org.termOfService,
        'privacyPolicy': org.privacyPolicy,
      }, headers: {
        'Authorization': 'Bearer $token'
      });
      responseData = jsonDecode(response.body);
      orgList.add(org);
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

  //function to delete existing organization
  Future<void> deleteOrg(Organization organization) async {
    String token = authprovider.gettoken.toString();
    Map<String, dynamic> responseData = {};
    final url = Api.deleteVehicleById(organization.id); //remove the string interpolation once apis are created
    final existingOrgIndex =
        orgList.indexWhere((element) => (element == organization));
    Organization? existingOrg = orgList[existingOrgIndex];
    orgList.removeAt(existingOrgIndex);
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
        orgList.insert(existingOrgIndex, existingOrg);
        notifyListeners();
        throw 'An Error Occured';
      } else {
        orgList.insert(existingOrgIndex, existingOrg);
        notifyListeners();
        throw HttpException(responseData['message']);
      }
    }
    existingOrg = null;
  }
}


