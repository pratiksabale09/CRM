import 'package:car_rental_mng_app/models/http_exception.dart';
import 'package:car_rental_mng_app/models/vehicle.dart';
import 'package:car_rental_mng_app/providers/vehicleprovider.dart';
import 'package:car_rental_mng_app/screens/vehicles/editvehicle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class VehicleCard extends StatefulWidget {
  
  List<Vehicle> vehicleList;
  Vehicle vehicle;

  VehicleCard({Key? key, required this.vehicleList, required this.vehicle})
      : super(key: key);

  @override
  State<VehicleCard> createState() {
    return _VehicleCard();
  }
}

class _VehicleCard extends State<VehicleCard> {
  bool isLoading = false;
  void showErrorDialog(String message) {
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

  Future<void> delete(Vehicle vehicle) async {
    setState(() {
      isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<VehicleProvider>(context, listen: false)
          .deleteVehicle(vehicle);
      Fluttertoast.showToast(msg: "Vehicle deleted successfully");
    } on HttpException catch (error) {
      showErrorDialog(error.toString());
    } catch(e)
    {
      showErrorDialog(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: <Widget>[
                  IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditVehiclePage(
                                    gotvehicle: widget.vehicle,
                                  ))).then((value) => setState(() {
                            widget.vehicleList = List<Vehicle>.from(
                                Provider.of<VehicleProvider>(context,
                                        listen: false)
                                    .getVehicles);
                          }));
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                  IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) { 
                          return AlertDialog(
                          title: const Text('Delete vehicle?'),
                          content: const Text(
                              'Are you sure you want to delete this vehicle?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('CANCEL'),
                            ),
                            TextButton(
                              onPressed: () {
                                delete(widget.vehicle);
                                Navigator.pop(context, 'deleted');
                              },
                              child: const Text('DELETE'),
                            )
                          ],
                        );
                    }
                      );
                    },
                    color: Theme.of(context).errorColor,
                  ),
                ],
              ),
            ),
            title: Text(widget.vehicle.brandModel),
            subtitle: Text(
              widget.vehicle.brandName,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
            child: Text(
              widget.vehicle.vehicleNo,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
