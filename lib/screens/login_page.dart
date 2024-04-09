import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_flutter/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors_app.dart';
import '../utils/constants.dart';
import '../utils/string_app.dart';

class LoginPage extends StatefulWidget {
  final String routeName = '/Login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  late bool _isObscure = false;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late bool isLoading;
  bool _rememberMe = false;

  @override
  void initState() {
    _emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailAddressController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('EMCUS BLE'),
              centerTitle: true,
              leading: null,
            ),
            body: Container(
              decoration: BoxDecoration(
                color: Colors_App().pincodecolor, // Navy blue background color
              ),
              child: Center(
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the value as needed
                  ),
                  margin: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 16.0),
                        _emailTextField(),
                        const SizedBox(height: 16.0),
                        _passwordTextField(),
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                            const Text('Remember Me'),
                          ],
                        ),
                        Row(
                          children: [
                            _forgotPasswordButton(),
                          ],
                        ),
                        _signInButton(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes().registrationForm);
                              },
                              child: Text(
                                "Sign up here",
                                style: TextStyle(color: Colors_App().redColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///Widget section
  Widget _emailTextField() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
      child: TextField(
        maxLength: 20,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        maxLines: 1,
        focusNode: emailFocusNode,
        controller: _emailAddressController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIcon: const Icon(Icons.person),
          hintText: "Enter your email", //String_App().enterUserName,
          labelText: "Enter your email", //String_App().enterUserName,
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
      child: TextField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter(" ", allow: false),
        ],
        enableInteractiveSelection: false,
        obscureText: _isObscure,
        maxLength: 20,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        maxLines: 1,
        controller: passwordController,
        focusNode: passwordFocusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIcon: const Icon(Icons.lock),
          hintText: "Enter Password",
          labelText: "Enter Password",
          //String_App().password,
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(
                () {
                  _isObscure = !_isObscure;
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return SizedBox(
      width: 180,
      height: 50,
      child: ElevatedButton(
        /* onPressed: () async {
          // Show circular progress indicator
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );

          // Perform asynchronous operation
          bool isValid = await _validationForm();
          if (isValid) {
            bool hasInternet = await Constants.checkConnectivity();
            if (hasInternet) {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _emailAddressController.text,
                  password: passwordController.text,
                );
                // Navigate to dashboard page
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes().dashboardPage,
                      (route) => false,
                );
              } catch (error) {
                // Show error dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Something went wrong'),
                      content: Text('Error: ${error.toString()}'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            } else {
              // Show no internet connection dialog
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('No Internet Connection'),
                    content: const Text(
                      'Please check your internet connection and try again.',
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          }

          // Hide circular progress indicator
          Navigator.of(context).pop();
        },
        child: const Text('Login'),*/
        onPressed: () => {
          showDialog(
            context: context,
            barrierDismissible: false,
            // Prevent dialog from being dismissed by tapping outside
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),

          // Perform form validation and other operations
          _validationForm().then((isValid) {
            if (isValid) {
              Constants.checkConnectivity().then((hasInternet) async {
                // Hide circular progress indicator
                Navigator.of(context).pop();

                if (hasInternet) {
                  try {
                    // Show circular progress indicator again
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );

                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailAddressController.text,
                      password: passwordController.text,
                    );

                    // Navigate to dashboard page
                    if (!mounted) return;
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes().dashboardPage,
                      (route) => false,
                    );
                  } catch (error) {
                    // Show error dialog

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Something went wrong'),
                          content: Text('Error: ${error.toString()}'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );

                  }
                } else {
                  // Show no internet connection dialog
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('No Internet Connection'),
                        content: const Text(
                          'Please check your internet connection and try again.',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            } else {
              // Hide circular progress indicator
              Navigator.of(context).pop();
            }
          })

          /* _validationForm().then(
            (value) {
              if (value) {
                Constants.checkConnectivity().then((value) async {
                  if (value) {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailAddressController.text,
                            password: passwordController.text)
                        .then((value) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes().dashboardPage,
                        (route) => false,
                      );
                    }).onError((error, stackTrace) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Something went wrong'),
                            content: Text('Error is ${error.toString()}'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  print("error");
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  } else {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('No Internet Connection'),
                          content: const Text(
                              'Please check your internet connection and try again.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                });
              }
            },
          )*/
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors_App().whitecolor,
          backgroundColor: Colors_App().redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          elevation: 15.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            String_App().signIn,
          ),
        ),
      ),
    );
  }

  Widget _forgotPasswordButton() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "");
          },
          child: Text(
            String_App().forgotPassword,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextButton(
          onPressed: () {
            // Navigator.pushNamed(context, Routes().registrationForm);
          },
          child: Text(
            String_App().mobileRegister,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }

  Future<bool> _validationForm() async {
    if (_emailAddressController.text.toString().trim().isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Email field can not be empty'),
            content: const Text('Please enter your email Id.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    } else if (passwordController.text.toString().trim().isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password can not be empty'),
            content: const Text('Please enter your password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }
}
