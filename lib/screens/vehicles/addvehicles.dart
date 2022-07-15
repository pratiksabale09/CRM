//add vehicle screen, text form screen with save button

import 'package:car_rental_mng_app/forms/addvehicleform.dart';
import 'package:car_rental_mng_app/models/http_exception.dart';
import 'package:car_rental_mng_app/models/vehicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_mng_app/providers/vehicleprovider.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({Key? key}) : super(key: key);

  @override
  _AddVehiclePage createState() => _AddVehiclePage();
}

class _AddVehiclePage extends State<AddVehiclePage> {
  TextEditingController vehicleNocontroller = TextEditingController();
  TextEditingController vehicleTypecontroller = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController brandModelController = TextEditingController();
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

   Future<void> saveform(Vehicle vehicle) async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<VehicleProvider>(context, listen: false)
          .addVehicleInList(vehicle);
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
      Fluttertoast.showToast(msg: "Vehicle added successfully");
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
          title: const Text("Add Vehicles"),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              ): SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            //begin the form
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VehicleForm(
                  vehicleNocontroller: vehicleNocontroller,
                  vehicleTypecontroller: vehicleTypecontroller,
                  brandNameController: brandNameController,
                  brandModelController: brandModelController,
                ),
              ),
              Transform.scale(
                    scale: 0.8,
                    child: Wrap(children: <Widget>[
                      CupertinoSwitch(
                        value: isOutSideVehicle,
                        onChanged: (value) {
                          setState(() {
                            isOutSideVehicle = value;
                          });
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 8, left: 10),
                          child: InkWell(
                            child: Text(
                              'Outside Vehicle',
                              style: TextStyle(
                                  color: (isOutSideVehicle == false)
                                      ? Colors.blueGrey
                                      : Colors.black,
                                  fontSize: 25),
                            ),
                            onTap: () {
                              setState(() {
                                isOutSideVehicle = !isOutSideVehicle;
                              });
                            },
                          )),
                    ])),
              ElevatedButton(
                  onPressed: () {
                    Vehicle vehicle = Vehicle(
                        vehicleNo: vehicleNocontroller.text,
                        vehicleType: vehicleTypecontroller.text,
                        brandName: brandNameController.text,
                        brandModel: brandModelController.text,
                        isOutSideVehicle: isOutSideVehicle);

                    // Provider.of<VehicleProvider>(context, listen: false)
                    //     .addVehicleInList(vehicle);
                    // Fluttertoast.showToast(msg: "Vehicle Added Successfully");
                    // Navigator.of(context).pop(MaterialPageRoute(
                    //     builder: (context) => const Vehicles_Screen()));
                    saveform(vehicle);
                  },
                  child: const Text('Save'))
            ]),
          ),
        ));
  }
}
