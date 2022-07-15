import 'package:car_rental_mng_app/models/http_exception.dart';
import 'package:car_rental_mng_app/models/trip.dart';
import 'package:car_rental_mng_app/providers/tripsprovider.dart';
import 'package:car_rental_mng_app/screens/trips/editTrip.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TripCard extends StatefulWidget {
  
  List<Trip> tripList;
  Trip trip;

  TripCard({Key? key, required this.tripList, required this.trip}) : super(key: key);

  @override
  State<TripCard> createState() {
    return _TripCard();
  }
}

class _TripCard extends State<TripCard> {
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

  Future<void> delete(Trip trip) async {
    setState(() {
      isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<TripsProvider>(context, listen: false)
          .deleteTrip(trip);
      Fluttertoast.showToast(msg: "Trip deleted successfully");
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
                              builder: (context) => Tripsform(
                                    gottrip: widget.trip,
                                  ))).then((value) => setState(() {
                            widget.tripList = List<Trip>.from(
                                Provider.of<TripsProvider>(context,
                                        listen: false)
                                    .getTrips);
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
                          title: const Text('Delete Trip?'),
                          content: const Text(
                              'Are you sure you want to delete this trip?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('CANCEL'),
                            ),
                            TextButton(
                              onPressed: () {
                                delete(widget.trip);
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
            title: Text(widget.trip.bookedByName),
            subtitle: Text(
              widget.trip.userName,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
            child: Text(
              widget.trip.userMob,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
