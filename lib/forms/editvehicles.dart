
//a text form to edit existing vehicle

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditVehicleForm extends StatefulWidget {
 FocusScopeNode node = FocusScopeNode();
  TextEditingController vehicleNocontroller = TextEditingController();
  TextEditingController vehicleTypecontroller = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController brandModelController = TextEditingController();
  String vehicleNo, vehicleType, brandName, brandModel;
   bool isOutsideVehicle = false;

    EditVehicleForm(
      {Key? key,
      required this.vehicleNocontroller,
      required this.vehicleTypecontroller,
      required this.brandNameController,
      required this.brandModelController,
      required this.vehicleNo,
      required this.vehicleType,
      required this.brandName,
      required this.brandModel})
      : super(key: key);

  @override
  _EditVehicleFormState createState() => _EditVehicleFormState();
}

class _EditVehicleFormState extends State<EditVehicleForm> {
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
                  initialValue: widget.vehicleNo,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Vehicle Number',
                    contentPadding: EdgeInsets.all(20),
                  ),
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
                  initialValue: widget.vehicleType,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Vehicle Type',
                    contentPadding: EdgeInsets.all(20),
                  ),
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
                  initialValue: widget.brandName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Brand Name',
                    contentPadding: EdgeInsets.all(20),
                  ),
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
                  initialValue: widget.brandModel,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 17),
                    labelText: 'Brand Model',
                    contentPadding: EdgeInsets.all(20),
                  ),
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
      )
    );
  }
}
