//screen to display list of all orgs in the form of cards, with popup menu buttons to edit and delete org

import 'dart:io';
import 'package:car_rental_mng_app/models/organization.dart';
import 'package:car_rental_mng_app/models/trip.dart';
import 'package:car_rental_mng_app/providers/orgprovider.dart';
import 'package:car_rental_mng_app/providers/tripsprovider.dart';
import 'package:car_rental_mng_app/widgets/organization_card.dart';
import 'package:car_rental_mng_app/widgets/tripcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addTrip.dart';

// ignore: camel_case_types
class Trips extends StatefulWidget {
  const Trips({Key? key}) : super(key: key);

  @override
  State<Trips> createState() => _TripsState();
}

// ignore: camel_case_types
class _TripsState extends State<Trips> {
  GlobalKey formKey = GlobalKey();
  TextEditingController searchController = TextEditingController();
  ScrollController listscrollcontroller = ScrollController();
  FocusScopeNode searchNode = FocusScopeNode();
  bool isSearching = false;
  List<Trip> filteredtriplist = [];
  String searchstring = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      filteredtriplist = List<Trip>.from(
          Provider.of<TripsProvider>(context, listen: false).getTrips);
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

  Future<void> refreshTrips(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<TripsProvider>(context, listen: false).fetchAndSetTrips();
    } on HttpException catch (error) {
      showErrorDialog(error.toString());
    } catch (e) {
      showErrorDialog(e.toString());
    }
    setState(() {
      isLoading = false;
      filteredtriplist = List<Trip>.from(
          Provider.of<TripsProvider>(context, listen: false).getTrips);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Trip> triplist =
        List<Trip>.from(Provider.of<TripsProvider>(context).getTrips);

    void filtertrips(String string) {
      setState(() {
        if (string.toString().isNotEmpty) {
          isSearching = true;
          filteredtriplist = triplist
              .where((triplist) => triplist.bookedByName
                  .toLowerCase()
                  .contains(string.toLowerCase()))
              .toList();
        } else {
          filteredtriplist = triplist;
          isSearching = false;
        }
      });
    }

    return Container(
        margin: const EdgeInsets.all(5),
        child: Stack(children: <Widget>[
          RefreshIndicator(
              onRefresh: () => refreshTrips(context),
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
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
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
                                        filtertrips(searchstring);
                                      },
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintStyle:
                                            const TextStyle(fontSize: 17),
                                        labelText: 'Search Trips Here',
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            if (isSearching) {
                                              setState(() {
                                                isSearching = false;
                                                searchstring = "";
                                                filtertrips(searchstring);
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
                                  : (filteredtriplist.isEmpty)
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
                                              child: const Text(
                                                  'No Trips Found!',
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
                                          itemCount: filteredtriplist.length,
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(5),
                                          itemBuilder: (context, index) {
                                            return TripCard(
                                                tripList: filteredtriplist,
                                                trip: filteredtriplist[index]);
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
                        builder: (context) => AddTrip()))
                    .then((value) => setState(() {
                          filteredtriplist = List<Trip>.from(
                              Provider.of<TripsProvider>(context, listen: false)
                                  .getTrips);
                        }));
              },
              //label: Icon(Icons.add_rounded),
              backgroundColor: Colors.green,
            ),
          ),
        ]));
  }
}
