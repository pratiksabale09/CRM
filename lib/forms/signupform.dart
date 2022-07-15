import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignUpCard extends StatefulWidget {
  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;
  String signupas;

  SignUpCard({Key? key, required this.signupas}) : super(key: key);

  @override
  _SignUpCardState createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusScopeNode _node = FocusScopeNode();
  final FocusScopeNode _otpnode = FocusScopeNode();
  final FocusScopeNode _confirmPass = FocusScopeNode();
  var isLoading = false;
  final passwordController = TextEditingController();

  Map<String, String> authData = {
    'signupas': '',
    'name': '',
    'mobileNumber': '',
    'email': '',
    'password': '',
    'OTP': '',
  };

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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    try {}catch(e){}
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _sendOtp() async {
    //sendotp function here
  }

  bool _authenticateOtp(String? otp) {
    //authenticate otp function here
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: Colors.blueGrey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        //constraints: const BoxConstraints(minHeight: 400),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: FocusScope(
            node: _node,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    onSaved: (value) {
                      authData['name'] = value!;
                    },
                    onEditingComplete: _node.nextFocus,
                    validator: (value) {
                      if (value.toString().length < 3) {
                        return 'Name too short!';
                      }
                    },
                    maxLength: 50,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'Mobile Number'),
                    onSaved: (value) {
                      authData['mobileNumber'] = value!;
                    },
                    validator: (value) {
                      if (value.toString().length != 10) {
                        return 'Invalid mobile number!';
                      }
                    },
                    maxLength: 10,
                  ),
                  const SizedBox(height: 12),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    child: const Text('Send OTP'),
                    onPressed: () async {
                      _otpnode.requestFocus();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 6.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).cardColor,
                  ),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Enter OTP'),
                    validator: (value) {
                      //provide otp validator here
                      if (value != 'your otp') {
                        return 'Invalid OTP!';
                      }
                    },
                    onSaved: (value) {
                      authData['OTP'] = value!;
                    },
                    onEditingComplete: _node.nextFocus,
                    focusNode: _otpnode,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          (value.length < 5)) {
                        return 'E-Mail must be greater than 5 characters!';
                      }
                      String pattern = r'\w+@\w+\.\w+';
                      if (!RegExp(pattern).hasMatch(value)) {
                        return 'Invalid E-mail Address format.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      authData['email'] = value!;
                    },
                    onEditingComplete: _node.nextFocus,
                  ),
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
                      if (!RegExp(passwordPattern).hasMatch(value)) {
                        return 'Password must contain one uppercase, one lowercase, one number and one special character.';
                      }
                    },
                    onSaved: (value) {
                      authData['password'] = value!;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_confirmPass);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: InkWell(
                        onTap: _toggleconfirmpassview,
                        child: Icon(
                          !widget.isHiddenConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                        ),
                      ),
                    ),
                    obscureText: widget.isHiddenConfirmPassword,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Passwords do not match!';
                      }
                    },
                    focusNode: _confirmPass,
                  ),
                  const SizedBox(height: 12),
                  if (isLoading)
                    const CircularProgressIndicator()
                  else
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: const Text('SIGN UP'),
                      onPressed:
                          (_authenticateOtp(authData['OTP'])) ? _submit : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).cardColor,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _togglepassview() {
    setState(() {
      widget.isHiddenPassword = !widget.isHiddenPassword;
    });
  }

  void _toggleconfirmpassview() {
    setState(() {
      widget.isHiddenConfirmPassword = !widget.isHiddenConfirmPassword;
    });
  }
}
