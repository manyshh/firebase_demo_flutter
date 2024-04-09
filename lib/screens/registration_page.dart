import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors_app.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';

class RegistrationForm extends StatefulWidget {
  String routeName = '/RegistrationForm';

  RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  bool _rememberMe = false;

  final bool _isEmailControllerEnabled = true;
  final bool _isPasswordControllerEnabled = true;
  final bool _isConfirmPasswordControllerEnabled = true;

  final bool _isNameEnabled = true;
  final bool _isCompanyNameEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors_App().pincodecolor,
      appBar: AppBar(
        leading: BackButton(
          color: Colors_App().whitecolor,
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors_App().pincodecolor,
        elevation: 5.0,
        shadowColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        toolbarHeight: 55,
        title: Text(
          "Registration Form",
          style: TextStyle(
              color: Colors_App().whitecolor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getBody(),
          ],
        ),
      ),
    );
  }

  ///Widgets Section
  Widget _getBody() {
    return _personalDetails();
  }

  Widget _personalDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          //_headings("Register"),
          _personalDetailsWidget(),
        ],
      ),
    );
  }

  Widget _headings(String text) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }

  Widget _personalDetailsWidget() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width / 4,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors_App().whitecolor),
            ),
            color: Colors_App().whitecolor,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _editText(
                      labelText: 'Name',
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                      isMandatory: true,
                      hintText: "Enter your name",
                      isEnabled: _isNameEnabled),
                  _commonSpacing(),
                  _editText(
                      labelText: 'Company Name',
                      controller: _companyNameController,
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                      isMandatory: true,
                      hintText: "Enter your company name",
                      isEnabled: _isCompanyNameEnabled),
                  _commonSpacing(),
                  _editText(
                      labelText: 'Email Address',
                      hintText: "Enter your Email Address",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 30,
                      isMandatory: false,
                      isEnabled: _isEmailControllerEnabled),
                  _commonSpacing(),
                  _editText(
                    labelText: 'Password',
                    hintText: "Enter your password",
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    isMandatory: false,
                    isEnabled: _isPasswordControllerEnabled,
                  ),
                  _commonSpacing(),
                  _editText(
                    labelText: 'Confirm Password',
                    hintText: 'Please Confirm Password',
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    isMandatory: false,
                    isEnabled: _isConfirmPasswordControllerEnabled,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: const Text(
                            'By signing up you are agreeing with the FFE Terms and Conditions and Privacy Policy'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      ElevatedButton(
                        /*onPressed: () => {

                          _validationForm().then(
                            (value) {
                              if (value) {
                                Constants.checkConnectivity()
                                    .then((value) async {
                                  if (value) {
                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text)
                                        .then((value) {
                                      Navigator.pushNamed(
                                          context, Routes().dashboardPage);
                                    }).onError((error, stackTrace) {
                                      print("Error : ${error.toString()}");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Error : ${error.toString()}'),
                                          duration: const Duration(
                                              seconds:
                                                  2), // Adjust the duration as needed
                                        ),
                                      );
                                    });
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'No Internet Connection'),
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
                          )
                        },*/

                        //new one
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
                              Constants.checkConnectivity()
                                  .then((hasInternet) async {
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

                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text);

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
                                          title: const Text(
                                              'Something went wrong'),
                                          content: Text(
                                              'Error: ${error.toString()}'),
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
                                        title: const Text(
                                            'No Internet Connection'),
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

                        },

                        child: const Text("Register"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account ?"),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes().loginPage);
                        },
                        child: Text(
                          "Sign in here",
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
      ],
    );
  }

  Widget _editText({
    required String labelText,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    required int maxLength,
    required isMandatory,
    required String hintText,
    Function? onDataChange,
    bool? isEnabled,
  }) {
    return TextField(
      enabled: isEnabled ?? true,
      onEditingComplete: () => onDataChange != null ? onDataChange() : () {},
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      maxLines: 1,
      inputFormatters: inputFormatters ??
          [
            FilteringTextInputFormatter(RegExp(r'[a-zA-Z0-9_ .!@#$%^&*()]'),
                allow: true)
          ],
      controller: controller,
      decoration: InputDecoration(
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        //labelText: labelText,
        label: RichText(
          text: TextSpan(
            text: labelText,
            style: TextStyle(color: Colors_App().blackcolor),
            children: [
              isMandatory
                  ? TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors_App().redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const TextSpan(),
            ],
          ),
        ),
        hintText: hintText,
      ),
    );
  }

  Widget _commonSpacing() {
    return const SizedBox(height: 10);
  }

  Future<bool> _validationForm() async {
    if (_nameController.text.toString().trim().isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Please enter name.'),
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
    } else if (_companyNameController.text.toString().trim().isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Please enter a company name.'),
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
    } else if (_emailController.text.toString().trim().isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Email can not be empty'),
            content: const Text('Please enter email.'),
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
    } else if (_passwordController.text.toString().trim().isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Please enter password name.'),
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
    } else if (_confirmPasswordController.text.trim().isEmpty) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Please enter a confirm password.'),
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
    } else if (_passwordController != _confirmPasswordController) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password mismatch'),
            content: const Text('Confirm password must be same'),
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
