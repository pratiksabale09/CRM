//edit vehicle screen, text form screen to modify properties of existing vehicle

import 'package:car_rental_mng_app/forms/editvehicles.dart';
import 'package:car_rental_mng_app/models/http_exception.dart';
import 'package:car_rental_mng_app/models/vehicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_mng_app/providers/vehicleprovider.dart';

// ignore: must_be_immutable
class EditVehiclePage extends StatefulWidget {
  Vehicle gotvehicle;
  EditVehiclePage({Key? key, required this.gotvehicle}) : super(key: key);

  @override
  _EditVehiclePage createState() => _EditVehiclePage();
}

class _EditVehiclePage extends State<EditVehiclePage> {
  TextEditingController vehicleNocontroller = TextEditingController();
  TextEditingController vehicleTypecontroller = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController brandModelController = TextEditingController();

  bool _isLoading = false;
  bool editerror = false;

  @override
  void initState() {
    if (vehicleNocontroller.text == "") {
      vehicleNocontroller.text = widget.gotvehicle.vehicleNo;
    }
    if (vehicleTypecontroller.text == "") {
      vehicleTypecontroller.text = widget.gotvehicle.vehicleType;
    }
    if (brandNameController.text == "") {
      brandNameController.text = widget.gotvehicle.brandName;
    }
    if (brandModelController.text == "") {
      brandModelController.text = widget.gotvehicle.brandModel;
    }
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

   Future<void> saveform(Vehicle vehicle) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<VehicleProvider>(context, listen: false)
          .editVehicleInList(widget.gotvehicle,vehicle);
    } on HttpException catch (error) {
      editerror = true;
      Navigator.pop(context);
      _showErrorDialog(error.toString());
    } catch (e)
    {
      editerror = true;
      Navigator.pop(context);
      _showErrorDialog(e.toString());
    }
    if (editerror == false) {
      Fluttertoast.showToast(msg: "Vehicle edited successfully");
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
          title: const Text("Edit Vehicles"),
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
                        child: EditVehicleForm(
                            vehicleNocontroller: vehicleNocontroller,
                            vehicleTypecontroller: vehicleTypecontroller,
                            brandNameController: brandNameController,
                            brandModelController: brandModelController,
                            vehicleNo: widget.gotvehicle.vehicleNo,
                            vehicleType: widget.gotvehicle.vehicleType,
                            brandName: widget.gotvehicle.brandName,
                            brandModel: widget.gotvehicle.brandModel)),
                    Transform.scale(
                        scale: 0.8,
                        child: Wrap(children: <Widget>[
                          CupertinoSwitch(
                            value: widget.gotvehicle.isOutSideVehicle,
                            onChanged: (value) {
                              setState(() {
                                widget.gotvehicle.isOutSideVehicle = value;
                              });
                            },
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 8, left: 10),
                              child: InkWell(
                                child: Text(
                                  'Outside Vehicle',
                                  style: TextStyle(
                                      color:
                                          (widget.gotvehicle.isOutSideVehicle ==
                                                  false)
                                              ? Colors.blueGrey
                                              : Colors.black,
                                      fontSize: 25),
                                ),
                                onTap: () {
                                  setState(() {
                                    widget.gotvehicle.isOutSideVehicle =
                                        !(widget.gotvehicle.isOutSideVehicle);
                                  });
                                },
                              )),
                        ])),
                    ElevatedButton(
                        onPressed: () {
                          Vehicle newvehicle = Vehicle(
                              vehicleNo: vehicleNocontroller.text,
                              vehicleType: vehicleTypecontroller.text,
                              brandName: brandNameController.text,
                              brandModel: brandModelController.text,
                              isOutSideVehicle:
                                  widget.gotvehicle.isOutSideVehicle);

                          saveform(newvehicle);
                        },
                        child: const Text('Save'))
                  ]),
                ),
              ));
  }
}
