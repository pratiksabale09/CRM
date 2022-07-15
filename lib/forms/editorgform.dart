//a text form to edit existing vehicle

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditOrgForm extends StatefulWidget {
  FocusScopeNode node = FocusScopeNode();
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

  String orgName,
      legalName,
      brandName,
      tagLine,
      gstNumber,
      orgType,
      website,
      termofservice,
      privacypolicy
      // email,
      // mobile,
      // socialurl,
      // tollfreeno
      ;

  EditOrgForm({
    Key? key,
    required this.orgnamecontroller,
    required this.orgName,
    required this.legalnamecontroller,
    required this.legalName,
    required this.brandnameController,
    required this.brandName,
    required this.taglinecontroller,
    required this.tagLine,
    required this.gstnumbercontroller,
    required this.gstNumber,
    required this.orgtypecontroller,
    required this.orgType,
    required this.websitecontroller,
    required this.website,
    required this.termofservicecontroller,
    required this.termofservice,
    required this.privacypolicycontroller,
    required this.privacypolicy,
    // required this.emailcontroller,
    // required this.email,
    // required this.mobilecontroller,
    // required this.mobile,
    // required this.socialurlcontroller,
    // required this.socialurl,
    // required this.tollfreenocontroller,
    // required this.tollfreeno
  }) : super(key: key);

  @override
  _EditOrgFormState createState() => _EditOrgFormState();
}

class _EditOrgFormState extends State<EditOrgForm> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: formkey,
      child: FocusScope(
        node: widget.node,
        child: Container(
          margin: const EdgeInsets.all(8.0),
          //begin the form
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.orgName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Organization Name',
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.orgnamecontroller.text = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.legalName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Org Legal Name',
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.legalnamecontroller.text = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.brandName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Brand Name',
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.brandnameController.text = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.tagLine,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Tagline',
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.taglinecontroller.text = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.gstNumber,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'GST Number',
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.gstnumbercontroller.text = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.orgType,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Organization Type',
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.orgtypecontroller.text = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.website,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Website',
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.websitecontroller.text = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.termofservice,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Term of Service',
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.termofservicecontroller.text = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.privacypolicy,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Privacy Policy',
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.privacypolicycontroller.text = value;
                    });
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     initialValue: widget.email,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintStyle: TextStyle(fontSize: 17),
              //       labelText: 'Email',
              //       contentPadding: EdgeInsets.all(20),
              //     ),
              //     onChanged: (value) {
              //       setState(() {
              //         widget.emailcontroller.text = value;
              //       });
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     initialValue: widget.mobile,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintStyle: TextStyle(fontSize: 17),
              //       labelText: 'Mobile',
              //       contentPadding: EdgeInsets.all(20),
              //     ),
              //     onChanged: (value) {
              //       setState(() {
              //         widget.mobilecontroller.text = value;
              //       });
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     initialValue: widget.socialurl,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintStyle: TextStyle(fontSize: 17),
              //       labelText: 'Social URL',
              //       contentPadding: EdgeInsets.all(20),
              //     ),
              //     onChanged: (value) {
              //       setState(() {
              //         widget.socialurlcontroller.text = value;
              //       });
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     initialValue: widget.tollfreeno,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintStyle: TextStyle(fontSize: 17),
              //       labelText: 'Toll Free Number',
              //       contentPadding: EdgeInsets.all(20),
              //     ),
              //     onChanged: (value) {
              //       setState(() {
              //         widget.tollfreenocontroller.text = value;
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ));
  }
}
