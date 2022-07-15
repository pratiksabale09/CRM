//a text form to add vehicle

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VehicleForm extends StatefulWidget {
  FocusScopeNode node = FocusScopeNode();
  TextEditingController vehicleNocontroller = TextEditingController();
  TextEditingController vehicleTypecontroller = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController brandModelController = TextEditingController();
   bool isOutsideVehicle = false;

  VehicleForm(
      {Key? key,
      required this.vehicleNocontroller,
      required this.vehicleTypecontroller,
      required this.brandNameController,
      required this.brandModelController})
      : super(key: key);

  @override
  _VehicleFormState createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
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
                      labelText: 'Vehicle Number',
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onEditingComplete: widget.node.nextFocus,
                    onChanged: (value) {
                      setState(() {
                        widget.vehicleNocontroller.text = value;
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
                      labelText: "Vehicle Type",
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onEditingComplete: widget.node.nextFocus,
                    onChanged: (value) {
                      setState(() {
                        widget.vehicleTypecontroller.text = value;
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
                    onEditingComplete: widget.node.nextFocus,
                    onChanged: (value) {
                      setState(() {
                        widget.brandNameController.text = value;
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
                      labelText: 'Brand Model',
                      contentPadding: EdgeInsets.all(20),
                    ),
                    onEditingComplete: widget.node.nextFocus,
                    onChanged: (value) {
                      setState(() {
                        widget.brandModelController.text = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
