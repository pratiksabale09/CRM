import 'dart:math';
import 'package:car_rental_mng_app/providers/auth_provider.dart';
import 'package:car_rental_mng_app/screens/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  Color profileiconcolor =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
  String username = 'Username Here';
  String initials = ''; //initials will be fetched from username string
  // ignore: prefer_typing_uninitialized_variables
  var firstchar;
  String secondchar = '';

  //function to fetch username initials
  String getInit(String username) {
    for (int i = 0; i < username.length; i++) {
      if (username[i] != " ") {
        firstchar = username[i].toUpperCase();
      }
      break;
    }
    for (int i = username.length - 2; i >= 0; i--) {
      if (username[i] == " ") {
        secondchar = username[i + 1].toUpperCase();
      }
    }
    initials = '$firstchar$secondchar';
    print('initials: $initials');
    return initials;
  }

  //manual signout function
  signOut() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to Sign Out'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'CANCEL');
            },
            child: const Text('CANCEL'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
            child: const Text("SIGN OUT"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            Container(
                height: 130,
                width: double.infinity,
                color: Colors.indigo,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Text(
                        username,
                        style: const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    )
                  ],
                )
                ),
            Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 140),
                    color: Colors.white,
                    child: ListView(
                      children: ListTile.divideTiles(
                        context: context,
                        tiles: [
                          ListTile(
                            leading: const Icon(Icons.person_outline_rounded),
                            title: const Text('My Profile'),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserProfile()));
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout_rounded),
                            title: const Text('Sign Out'),
                            onTap: () {
                              signOut();
                            },
                          ),
                          const ListTile(
                            title: Text(
                                'This list is scrollable if more tiles are added'),
                          ),
                        ],
                      ).toList(),
                    ))),
          ],
        ),
        Align(
          alignment: const Alignment(0, -0.7),
          child: SizedBox(
              width: size.width * 0.85,
              height: size.height * 0.22,
              child: Stack(
                alignment: Alignment.topCenter, children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  child: Card(
                    elevation: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 35, top: 35),
                              child: Text('REPORTS   ',
                                  style: TextStyle(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.bold,
                                  ))),
                          Padding(
                              padding: const EdgeInsets.only(right: 40, top: 10),
                              child: Icon(
                                Icons.library_books_outlined,
                                size: 30,
                                color: Colors.blue[700],
                              )),
                        ]),
                        const Padding(
                          padding: EdgeInsets.only(top: 40, bottom: 20),
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                            //indent: 5,
                            endIndent: 0,
                            //width: 20,
                          ),
                        ),
                        Column(children: <Widget>[
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 35, right: 5, top: 35),
                              child: Text('TRIPS LEFT',
                                  style: TextStyle(
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.bold,
                                  ))),
                          Padding(
                              padding: const EdgeInsets.only(left: 35, top: 12),
                              child: Text(
                                '100',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                  fontSize: 26,
                                ),
                              )),
                        ]),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 34,
                  backgroundColor: (profileiconcolor == Colors.indigo)
                      ? Colors.yellow
                      : profileiconcolor,
                  child: Text(
                    getInit(username),
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ])),
        ),
      ],
    );
  }
}
