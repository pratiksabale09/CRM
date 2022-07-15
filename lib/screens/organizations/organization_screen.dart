//screen to display list of all orgs in the form of cards, with popup menu buttons to edit and delete org

import 'dart:io';

import 'package:car_rental_mng_app/models/organization.dart';
import 'package:car_rental_mng_app/providers/orgprovider.dart';
import 'package:car_rental_mng_app/widgets/organization_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addorgscreen.dart';

// ignore: camel_case_types
class Org_Screen extends StatefulWidget {
  const Org_Screen({Key? key}) : super(key: key);

  @override
  State<Org_Screen> createState() => _Org_ScreenState();
}

// ignore: camel_case_types
class _Org_ScreenState extends State<Org_Screen> {
  GlobalKey formKey = GlobalKey();
  TextEditingController searchController = TextEditingController();
  ScrollController listscrollcontroller = ScrollController();
  FocusScopeNode searchNode = FocusScopeNode();
  bool isSearching = false;
  List<Organization> filteredorglist = [];
  String searchstring = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      filteredorglist = List<Organization>.from(
          Provider.of<OrgProvider>(context, listen: false).getOrgs);
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

  Future<void> refreshOrgs(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<OrgProvider>(context, listen: false).fetchAndSetOrgs();
    } on HttpException catch (error) {
      showErrorDialog(error.toString());
    } catch (e) {
      showErrorDialog(e.toString());
    }
    setState(() {
      isLoading = false;
      filteredorglist = List<Organization>.from(
          Provider.of<OrgProvider>(context, listen: false).getOrgs);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Organization> orglist =
        List<Organization>.from(Provider.of<OrgProvider>(context).getOrgs);

    void filtervehicles(String string) {
      setState(() {
        if (string.toString().isNotEmpty) {
          isSearching = true;
          filteredorglist = orglist
              .where((orglist) => orglist.brandName
                  .toLowerCase()
                  .contains(string.toLowerCase()))
              .toList();
        } else {
          filteredorglist = orglist;
          isSearching = false;
        }
      });
    }

    return Container(
        margin: const EdgeInsets.all(5),
        child: Stack(children: <Widget>[
          RefreshIndicator(
              onRefresh: () => refreshOrgs(context),
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
                                        filtervehicles(searchstring);
                                      },
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintStyle:
                                            const TextStyle(fontSize: 17),
                                        labelText: 'Search Organization Here',
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
                                  : (filteredorglist.isEmpty)
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
                                                  'No Organizations Found!',
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
                                          itemCount: filteredorglist.length,
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(5),
                                          itemBuilder: (context, index) {
                                            return OrgCard(
                                                orgList: filteredorglist,
                                                org: filteredorglist[index]);
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
                        builder: (context) => const AddOrgPage()))
                    .then((value) => setState(() {
                          filteredorglist = List<Organization>.from(
                              Provider.of<OrgProvider>(context, listen: false)
                                  .getOrgs);
                        }));
              },
              //label: Icon(Icons.add_rounded),
              backgroundColor: Colors.green,
            ),
          ),
        ]));
  }
}
