//add org screen, text form screen with save button

import 'dart:io';

import 'package:car_rental_mng_app/forms/addorgform.dart';
import 'package:car_rental_mng_app/models/organization.dart';
import 'package:car_rental_mng_app/providers/orgprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class AddOrgPage extends StatefulWidget {
  const AddOrgPage({Key? key}) : super(key: key);

  @override
  _AddOrgPage createState() => _AddOrgPage();
}

class _AddOrgPage extends State<AddOrgPage> {
  TextEditingController orgnamecontroller = TextEditingController();
  TextEditingController legalnamecontroller = TextEditingController();
  TextEditingController brandnameController = TextEditingController();
  TextEditingController taglinecontroller = TextEditingController();

  TextEditingController gstnumbercontroller = TextEditingController();
  TextEditingController orgtypecontroller = TextEditingController();
  TextEditingController websitecontroller = TextEditingController();
  TextEditingController termofservicecontroller = TextEditingController();

  TextEditingController privacypolicycontroller = TextEditingController();
  //address
  // TextEditingController emailcontroller = TextEditingController();
  // TextEditingController mobilecontroller = TextEditingController();
  // TextEditingController socialurlcontroller = TextEditingController();
  // TextEditingController tollfreenocontroller = TextEditingController();
  bool isOutSideVehicle = false;
  bool isLoading = false;
  bool adderror = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

     Future<void> saveform(Organization organization) async {
       print("saveform called");
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<OrgProvider>(context, listen: false)
          .addOrgInList(organization);
    } on HttpException catch (error) {
      adderror = true;
      Navigator.pop(context);
      _showErrorDialog(error.toString());
    } catch (e)
    {
      adderror = true;
      Navigator.pop(context);
      _showErrorDialog(e.toString());
    }
    if (adderror == false) {
      //print('I am here');
      Fluttertoast.showToast(msg: "Organization added successfully");
      Navigator.pop(context); //to pop form screen
    }
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Organizations"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            //begin the form
            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OrgForm(
                    orgnamecontroller: orgnamecontroller,
                    legalnamecontroller: legalnamecontroller,
                    brandnameController: brandnameController,
                    taglinecontroller: taglinecontroller,
                    gstnumbercontroller: gstnumbercontroller,
                    orgtypecontroller: orgtypecontroller,
                    websitecontroller: websitecontroller,
                    termofservicecontroller: termofservicecontroller,
                    privacypolicycontroller: privacypolicycontroller,
                    // emailcontroller: emailcontroller,
                    // mobilecontroller: mobilecontroller,
                    // socialurlcontroller: socialurlcontroller,
                    // tollfreenocontroller: tollfreenocontroller
                  )),
              ElevatedButton(
                  onPressed: () {
                    Organization organization = Organization(
                      name: orgnamecontroller.text,
                      legalName: legalnamecontroller.text,
                      brandName: brandnameController.text,
                      tagLine: taglinecontroller.text,
                      smsLable: '',
                      smsConfig: '',
                      gstNumber: gstnumbercontroller.text,
                      orgType: orgtypecontroller.text,
                      orgId: '',
                      accId: '',
                      website: websitecontroller.text,
                      termOfService: termofservicecontroller.text,
                      privacyPolicy: privacypolicycontroller.text,
                      // config: '',
                      // addresses: [],
                      // emails: [],
                      // mobiles: [],
                      // socialUrls: [],
                      // tollfreeNo: [],
                      // createdAt: DateTime.now(),
                      // updatedAt: DateTime.now(),
                      // limits: [],
                      // defaultAddressesId: ''
                    );
                    saveform(organization);
                  },
                  child: const Text('Save'))
            ]),
          ),
        ));
  }
}
