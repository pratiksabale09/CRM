//a text form to add vehicle

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrgForm extends StatefulWidget {
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

  OrgForm({
    Key? key,
    required this.orgnamecontroller,
    required this.legalnamecontroller,
    required this.brandnameController,
    required this.taglinecontroller,
    required this.gstnumbercontroller,
    required this.orgtypecontroller,
    required this.websitecontroller,
    required this.termofservicecontroller,
    required this.privacypolicycontroller,
    // required this.emailcontroller,
    // required this.mobilecontroller,
    // required this.socialurlcontroller,
    // required this.tollfreenocontroller,
  }) : super(key: key);

  @override
  _OrgFormState createState() => _OrgFormState();
}

class _OrgFormState extends State<OrgForm> {
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
