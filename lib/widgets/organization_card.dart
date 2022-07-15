import 'package:car_rental_mng_app/models/organization.dart';
import 'package:car_rental_mng_app/providers/orgprovider.dart';
import 'package:car_rental_mng_app/screens/organizations/editorgscreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OrgCard extends StatefulWidget {
  List<Organization> orgList;
  Organization org;

  OrgCard({Key? key, required this.orgList, required this.org})
      : super(key: key);

  @override
  State<OrgCard> createState() {
    return _OrgCard();
  }
}

class _OrgCard extends State<OrgCard> {
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
                              builder: (context) => EditOrgPage(
                                    gotOrg: widget.org,
                                  ))).then((value) => setState(() {
                            widget.orgList = List<Organization>.from(
                                Provider.of<OrgProvider>(context,
                                        listen: false)
                                    .getOrgs);
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
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Delete Organization?'),
                          content: const Text(
                              'Are you sure you want to delete this organization?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('CANCEL'),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<OrgProvider>(context,
                                        listen: false)
                                    .deleteOrg(widget.org);
                                Fluttertoast.showToast(msg: "Organization Deleted");
                                Navigator.pop(context, 'deleted');
                              },
                              child: const Text('DELETE'),
                            )
                          ],
                        ),
                      );
                    },
                    color: Theme.of(context).errorColor,
                  ),
                ],
              ),
            ),
            title: Text(widget.org.name),
            subtitle: Text(
              widget.org.brandName,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
            child: Text(
              widget.org.orgType,
              style: const TextStyle(
                color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
