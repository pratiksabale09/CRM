//edit vehicle screen, text form screen to modify properties of existing organization

import 'package:car_rental_mng_app/forms/editorgform.dart';
import 'package:car_rental_mng_app/models/organization.dart';
import 'package:car_rental_mng_app/providers/orgprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditOrgPage extends StatefulWidget {
  Organization gotOrg;
  EditOrgPage({Key? key, required this.gotOrg}) : super(key: key);

  @override
  _EditOrgPage createState() => _EditOrgPage();
}

class _EditOrgPage extends State<EditOrgPage> {
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

  bool _isLoading = false;
  bool editerror = false;

  @override
  void initState() {
    if (orgnamecontroller.text == "") {
      orgnamecontroller.text = widget.gotOrg.name;
    }
    if (legalnamecontroller.text == "") {
      legalnamecontroller.text = widget.gotOrg.legalName;
    }
    if (brandnameController.text == "") {
      brandnameController.text = widget.gotOrg.brandName;
    }
    if (taglinecontroller.text == "") {
      taglinecontroller.text = widget.gotOrg.tagLine;
    }
    if (gstnumbercontroller.text == "") {
      gstnumbercontroller.text = widget.gotOrg.gstNumber;
    }
    if (orgtypecontroller.text == "") {
      orgtypecontroller.text = widget.gotOrg.orgType;
    }
    if (websitecontroller.text == "") {
      websitecontroller.text = widget.gotOrg.website;
    }
    if (termofservicecontroller.text == "") {
      termofservicecontroller.text = widget.gotOrg.termOfService;
    }
    if (privacypolicycontroller.text == "") {
      privacypolicycontroller.text = widget.gotOrg.privacyPolicy;
    }
    // if (emailcontroller.text == "") {
    //   emailcontroller.text = widget.gotOrg.emails.toString();
    // }
    // if (mobilecontroller.text == "") {
    //   mobilecontroller.text = widget.gotOrg.mobiles.toString();
    // }
    // if (socialurlcontroller.text == "") {
    //   socialurlcontroller.text = widget.gotOrg.socialUrls.toString();
    // }
    // if (tollfreenocontroller.text == "") {
    //   tollfreenocontroller.text = widget.gotOrg.tollfreeNo.toString();
    // }
    super.initState();
  }

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
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<OrgProvider>(context, listen: false)
          .editOrgInList(widget.gotOrg,organization);
    } catch (error) {
      editerror = true;
      Navigator.pop(context);
      const errorMessage =
          'Could not edit organization. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    if (editerror == false) {
      Fluttertoast.showToast(msg: "Organization edited successfully");
      Navigator.pop(context); //to pop form screen
    }
    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    // final vehicle = ModalRoute.of(context)?.settings.arguments as Vehicle;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Organization"),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  //begin the form
                  child: Column(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EditOrgForm(
                            orgnamecontroller: orgnamecontroller,
                            orgName: widget.gotOrg.name,
                            legalnamecontroller: legalnamecontroller,
                            legalName: widget.gotOrg.legalName,
                            brandnameController: brandnameController,
                            brandName: widget.gotOrg.brandName,
                            taglinecontroller: taglinecontroller,
                            tagLine: widget.gotOrg.tagLine,
                            gstnumbercontroller: gstnumbercontroller,
                            gstNumber: widget.gotOrg.gstNumber,
                            orgtypecontroller: orgtypecontroller,
                            orgType: widget.gotOrg.orgType,
                            websitecontroller: websitecontroller,
                            website: widget.gotOrg.website,
                            termofservicecontroller: termofservicecontroller,
                            termofservice: widget.gotOrg.termOfService,
                            privacypolicycontroller: privacypolicycontroller,
                            privacypolicy: widget.gotOrg.privacyPolicy,
                            // emailcontroller: emailcontroller,
                            // email: widget.gotOrg.emails.toString(),
                            // mobilecontroller: mobilecontroller,
                            // mobile: widget.gotOrg.mobiles.toString(),
                            // socialurlcontroller: socialurlcontroller,
                            // socialurl: widget.gotOrg.socialUrls.toString(),
                            // tollfreenocontroller: tollfreenocontroller,
                            // tollfreeno: widget.gotOrg.tollfreeNo.toString()
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
                              //config: '',
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
