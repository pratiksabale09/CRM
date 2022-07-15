import 'package:car_rental_mng_app/models/enums/gender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserProfile extends StatefulWidget {
  bool isHiddenPassword = true;

  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int mailcount = 1;
  int mobilecount = 1;
  List<Map<String, dynamic>> emailvalues = [];
  List<Map<String, dynamic>> mobilevalues = [];
  final FocusScopeNode node = FocusScopeNode();
  final FocusScopeNode formnode = FocusScopeNode();
  TextEditingController dateinputcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey formKey = GlobalKey();
  String emailkey = 'Primary';
  String mobilekey = 'Mobile';
  String usertypedropdownValue = 'Customer';
  String genderdropdownvalue = 'Male';
  bool isDisabled = true;

  Map<String, dynamic> userdata = {
    'name': '',
    'mobile': '',
    'password': '',
    'gender': '',
    'userType': '',
    'email': '',
    'address': '',
    'dob': '',
    'isOutSideDriver': false,
    'orgId': '',
    'accId': '',
    'roleId': '',
    'drivingLicense': ''
  };

  Gender genderlist = Gender();

  //function to enable/disable form editing
  void _togglelock() {
    setState(() {
      isDisabled = !isDisabled;
      FocusScope.of(context).unfocus();
    });
  }
  //on update email in dynamic form store in key value pair
  onUpdateemail(int index, String val) async {
    int foundKey = -1;
    for (var map in emailvalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      emailvalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
    };
    emailvalues.add(json);
  }
  //on update mobile number in dynamic form store in key value pair
  onUpdatemobile(int index, String val) async {
    int foundKey = -1;
    for (var map in mobilevalues) {
      if (map.containsKey("id")) {
        if (map["id"] == index) {
          foundKey = index;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      mobilevalues.removeWhere((map) {
        return map["id"] == foundKey;
      });
    }
    Map<String, dynamic> json = {
      "id": index,
      "value": val,
    };
    mobilevalues.add(json);
  }
  //helper function to dynamically add text fields for mobile numbers
  mobilerow(int index) {
    if (index == 0) {
      mobilekey = 'Mobile';
    } else if (index == 1) {
      mobilekey = 'Home';
    } else if (index == 2) {
      mobilekey = 'Work';
    }
    return Row(
      children: [
        Text(mobilekey),
        const SizedBox(width: 30),
        Expanded(
            child: Form(
                child: FocusScope(
          node: node,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(labelText: mobilekey),
            keyboardType: TextInputType.number,
            maxLength: 10,
            validator: (value) {
              if (value.toString().length != 10) {
                return 'Invalid mobile number!';
              }
            },
            onEditingComplete: node.nextFocus,
            onChanged: (val) {
              onUpdatemobile(index, val);
            },
          ),
        ))),
      ],
    );
  }
  //helper function to dynamically add textfields for multiple emails
  mailrow(int index) {
    if (index == 0) {
      emailkey = 'Primary';
    } else if (index == 1) {
      emailkey = 'Secondary';
    } else if (index == 2) {
      emailkey = 'Work';
    }
    return Row(
      children: [
        (index == 0) ? const Text('Email') : Text(emailkey),
        const SizedBox(width: 30),
        Expanded(
            child: Form(
                child: FocusScope(
          node: node,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(labelText: '$emailkey E-Mail'),
            keyboardType: TextInputType.emailAddress,
            maxLength: 20,
            validator: (value) {
              if (value == null || value.isEmpty || (value.length < 5)) {
                return 'E-Mail must be greater than 5 characters!';
              }
              String pattern = r'\w+@\w+\.\w+';
              if (!RegExp(pattern).hasMatch(value)) {
                return 'Invalid E-mail Address format.';
              }
              return null;
            },
            onEditingComplete: node.nextFocus,
            onChanged: (val) {
              onUpdateemail(index, val);
            },
          ),
        ))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: FocusScope(
                        node: formnode,
                        child: Column(
                          children: <Widget>[
                             //raisedbutton to enable or disable form editing, kept outside ignorepointer scope to keep it enabled
                            // ignore: deprecated_member_use
                            RaisedButton(
                                child:
                                    (isDisabled) ? const Text('ENABLE EDIT') : const Text('SAVE'),
                                onPressed: _togglelock
                                //buttonnode.nextFocus;
                                ,
                                color:
                                    (isDisabled) ? Colors.grey : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                            //to keep form disabled until edit button is pressed
                            IgnorePointer(
                              ignoring: isDisabled,
                              child: Column(children: <Widget>[
                                //textfield for name
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'Name'),
                                  onSaved: (value) {
                                    userdata['name'] = value!;
                                  },
                                  onEditingComplete: formnode.nextFocus,
                                  validator: (value) {
                                    if (value.toString().length < 3) {
                                      return 'Name too short!';
                                    }
                                  },
                                  maxLength: 50,
                                ),
                                //dynamic textfields for multiple mobiles
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: mobilecount,
                                    itemBuilder: (context, index) {
                                      return mobilerow(index);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 115),
                                  child: Row(children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          if (mobilecount < 3) {
                                            mobilecount++;
                                          }
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          if (mobilecount > 1) {
                                            mobilecount--;
                                          }
                                        });
                                      },
                                    ),
                                  ]),
                                ),
                                //dynamic textfields for multiple emails
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: mailcount,
                                    itemBuilder: (context, index) {
                                      return mailrow(index);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 115),
                                  child: Row(children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          if (mailcount < 3) {
                                            mailcount++;
                                          }
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          if (mailcount > 1) {
                                            mailcount--;
                                          }
                                        });
                                      },
                                    ),
                                  ]),
                                ),
                                //textfield for password
                                TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      suffixIcon: InkWell(
                                        onTap: _togglepassview,
                                        child: Icon(
                                          !widget.isHiddenPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    controller: passwordController,
                                    obscureText: widget.isHiddenPassword,
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 8) {
                                        return 'Password too short!';
                                      }
                                      String passwordPattern =
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                      if (!RegExp(passwordPattern)
                                          .hasMatch(value)) {
                                        return 'Password must contain one uppercase, one lowercase, one number and one special character.';
                                      }
                                    }),
                                Row(
                                  children: const <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 45, right: 10, top: 15),
                                    child: Text(
                                      'User Type',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 80, right: 10, top: 15),
                                    child: Text(
                                      'Gender',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ]),
                                //dropdowns for user type and gender selection
                                Row(children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 30, right: 10),
                                        //user type drop down
                                    child: DropdownButton<String>(
                                      value: usertypedropdownValue,
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 8,
                                      style: TextStyle(color: Colors.grey[800]),
                                      underline: Container(
                                        height: 1,
                                        color: Colors.blueGrey[800],
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          usertypedropdownValue = newValue!;
                                          userdata['userType'] =
                                              usertypedropdownValue;
                                        });
                                      },
                                      items: <String>[
                                        'Customer',
                                        'Driver',
                                        'Organization'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 40, right: 10),
                                    child:
                                    //gender dropdown 
                                    DropdownButton<String>(
                                      value: genderdropdownvalue,
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 8,
                                      style: TextStyle(color: Colors.grey[800]),
                                      underline: Container(
                                        height: 1,
                                        color: Colors.blueGrey[800],
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          genderdropdownvalue = newValue!;
                                          userdata['gender'] =
                                              genderdropdownvalue;
                                        });
                                      },
                                      items: <String>[
                                        'Male',
                                        'Female',
                                        'Other',
                                        'Prefer not to say'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ]),
                                //textfield for address
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Address'),
                                  onSaved: (value) {
                                    userdata['address'] = value!;
                                  },
                                  onEditingComplete: formnode.nextFocus,
                                ),
                                //textfield for date of birth
                                TextFormField(
                                  controller: dateinputcontroller,
                                  decoration: const InputDecoration(
                                    labelText: 'Date Of Birth',
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101))
                                        .then((pickedDate) {
                                      setState(() {
                                        dateinputcontroller.text = pickedDate
                                            .toString()
                                            .substring(0, 10);
                                      });
                                    });
                                  },
                                  onSaved: (pickedDate) {
                                    userdata['DOB'] = dateinputcontroller.text;
                                  },
                                  onEditingComplete: formnode.nextFocus,
                                ),
                                //textfield for driving license
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Driving License'),
                                  onSaved: (value) {
                                    userdata['drivingLicense'] = value!;
                                  },
                                  onEditingComplete: formnode.nextFocus,
                                ),
                                //switch to select outside driver
                                Transform.scale(
                                    scale: 0.65,
                                    child: Wrap(children: <Widget>[
                                      CupertinoSwitch(
                                        value: userdata['isOutSideDriver'],
                                        onChanged: (value) {
                                          setState(() {
                                            userdata['isOutSideDriver'] = value;
                                          });
                                        },
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 10),
                                          child: InkWell(
                                            child: Text(
                                              'Outside Driver',
                                              style: TextStyle(
                                                  color: (userdata[
                                                              'isOutSideDriver'] ==
                                                          false)
                                                      ? Colors.blueGrey
                                                      : Colors.black,
                                                  fontSize: 25),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                userdata['isOutSideDriver'] =
                                                    !userdata[
                                                        'isOutSideDriver'];
                                              });
                                            },
                                          ))
                                    ])),
                              ]),
                            ),
                            // ignore: deprecated_member_use
                           
                          ],
                        ))))));
  }
  //function to toggle hide/show password
  void _togglepassview() {
    setState(() {
      widget.isHiddenPassword = !widget.isHiddenPassword;
    });
  }
}
