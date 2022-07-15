//screen to display list of all vehicles in the form of cards, with popup menu buttons to edit and delete vehicle

import 'package:car_rental_mng_app/models/http_exception.dart';
import 'package:car_rental_mng_app/models/vehicle.dart';
import 'package:car_rental_mng_app/providers/vehicleprovider.dart';
import 'package:car_rental_mng_app/screens/vehicles/addvehicles.dart';
import 'package:car_rental_mng_app/widgets/vehicle_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class Vehicles_Screen extends StatefulWidget {
  const Vehicles_Screen({Key? key}) : super(key: key);

  @override
  State<Vehicles_Screen> createState() => _Vehicles_ScreenState();
}

// ignore: camel_case_types
class _Vehicles_ScreenState extends State<Vehicles_Screen> {
  GlobalKey formKey = GlobalKey();
  TextEditingController searchController = TextEditingController();
  ScrollController listscrollcontroller = ScrollController();
  FocusScopeNode searchNode = FocusScopeNode();
  bool isSearching = false;
  List<Vehicle> filteredvehiclelist = [];
  String searchstring = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      filteredvehiclelist = List<Vehicle>.from(
          Provider.of<VehicleProvider>(context, listen: false).getVehicles);
    });
    super.didChangeDependencies();
  }

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

  Future<void> refreshVehicles(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<VehicleProvider>(context, listen: false)
          .fetchAndSetVehicles();
    } on HttpException catch (error) {
      showErrorDialog(error.toString());
    } catch (e) {
      showErrorDialog(e.toString());
    }
    setState(() {
      isLoading = false;
      filteredvehiclelist = List<Vehicle>.from(
          Provider.of<VehicleProvider>(context, listen: false).getVehicles);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Vehicle> vehiclelist =
        List<Vehicle>.from(Provider.of<VehicleProvider>(context).getVehicles);

    void filtervehicles(String string) {
      setState(() {
        if (string.toString().isNotEmpty) {
          isSearching = true;
          filteredvehiclelist = vehiclelist
              .where((vehiclelist) => vehiclelist.brandModel
                  .toLowerCase()
                  .contains(string.toLowerCase()))
              .toList();
        } else {
          filteredvehiclelist = vehiclelist;
          isSearching = false;
        }
      });
    }

    return Container(
        margin: const EdgeInsets.all(5),
        child: Stack(children: <Widget>[
          RefreshIndicator(
              onRefresh: () => refreshVehicles(context),
              child: Form(
                  key: formKey,
                  child: FocusScope(
                      node: searchNode,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(top: 8, bottom: 8),
                                child: SizedBox(
                                    height: 35,
                                    child: TextField(
                                      controller: searchController,
                                      onTap: () {
                                        setState(() {
                                          searchNode.requestFocus();
                                        });
                                        setState(() {
                                          isSearching = true;
                                          searchNode.requestFocus();
                                        });
                                      },
                                      onChanged: (value) {
                                        searchstring = value;
                                        searchController.text = value;
                                        searchController.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: searchController
                                                        .text.length));
                                        filtervehicles(searchstring);
                                      },
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintStyle:
                                            const TextStyle(fontSize: 17),
                                        labelText: 'Search Vehicle Here',
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            if (isSearching) {
                                              setState(() {
                                                isSearching = false;
                                                searchstring = "";
                                                filtervehicles(searchstring);
                                                searchController.clear();
                                                searchNode.unfocus();
                                              });
                                            } else {
                                              setState(() {
                                                isSearching = true;
                                                searchNode.requestFocus();
                                              });
                                            }
                                          },
                                          child: Icon(
                                            isSearching
                                                ? Icons.cancel
                                                : Icons.search,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    )))
                          ]),
                          Flexible(
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    )
                                  : (filteredvehiclelist.isEmpty)
                                      ? SingleChildScrollView(
                                          physics: const BouncingScrollPhysics(
                                              parent:
                                                  AlwaysScrollableScrollPhysics()),
                                          scrollDirection: Axis.vertical,
                                          child: SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: const Text('No Vehicles Found!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black87,
                                                  ))))
                                      : ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics: const BouncingScrollPhysics(
                                              parent:
                                                  AlwaysScrollableScrollPhysics()),
                                          controller: listscrollcontroller,
                                          itemCount: filteredvehiclelist.length,
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(5),
                                          itemBuilder: (context, index) {
                                            return VehicleCard(
                                                vehicleList:
                                                    filteredvehiclelist,
                                                vehicle:
                                                    filteredvehiclelist[index]);
                                          },
                                        )),
                        ],
                      )))),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: const Icon(Icons.add_rounded),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => const AddVehiclePage()))
                    .then((value) => setState(() {
                          filteredvehiclelist = List<Vehicle>.from(
                              Provider.of<VehicleProvider>(context,
                                      listen: false)
                                  .getVehicles);
                        }));
              },
              //label: Icon(Icons.add_rounded),
              backgroundColor: Colors.green,
            ),
          ),
        ]));
  }
}
