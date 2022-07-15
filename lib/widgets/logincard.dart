import 'package:car_rental_mng_app/models/auth_login.dart';
import 'package:car_rental_mng_app/models/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

// ignore: must_be_immutable
class LoginCard extends StatefulWidget {
  bool isHiddenPassword = true;

  LoginCard({Key? key}) : super(key: key);

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusScopeNode _node = FocusScopeNode();

  AuthLogin authLogin = AuthLogin(email: '', password: '', rememberMe: false);
  String token = '';
  var isLoading = false;
  final passwordController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var parsedJson;

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
      // Invalid
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<AuthProvider>(context, listen: false).signIn(authLogin);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      isLoading = false;
    });
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
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: FocusScope(
            node: _node,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
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
                  onSaved: (value) {
                    authLogin.email = value!;
                    print(authLogin.email);
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
                  maxLength: 16,
                  obscureText: widget.isHiddenPassword,
                  controller: passwordController,
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
                    authLogin.password = value!;
                    print(authLogin.password);
                  },
                ),
                const SizedBox(height: 12),
                Transform.scale(
                    scale: 0.6,
                    child: Wrap(children: <Widget>[
                      CupertinoSwitch(
                        value: authLogin.rememberMe,
                        onChanged: (value) {
                          setState(() {
                            authLogin.rememberMe = value;
                          });
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 8, left: 10),
                          child: InkWell(
                            child: Text(
                              'Remember Me',
                              style: TextStyle(
                                  color: (authLogin.rememberMe == false)
                                      ? Colors.blueGrey
                                      : Colors.black,
                                  fontSize: 25),
                            ),
                            onTap: () {
                              setState(() {
                                authLogin.rememberMe = !authLogin.rememberMe;
                              });
                            },
                          )),
                    ])),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  // ignore: deprecated_member_use
                  RaisedButton(
                    child: const Text('LOGIN'),
                    onPressed: () {
                      // const snackBar =
                      //     SnackBar(content: Text('Login Bypassed'));
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pushReplacementNamed('/tabscreen');
                      //uncomment all above and below lines to avoid login bypass and execute submit function 
                      //_submit();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).cardColor,
                  ),
                // ignore: deprecated_member_use
              ],
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
}
