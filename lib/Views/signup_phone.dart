// ignore_for_file: library_private_types_in_public_api

import 'package:cam/Widget/process_indicationg_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'phone_number_verification.dart';

class SignUpWithPhoneNumber extends StatefulWidget {
  const SignUpWithPhoneNumber({Key? key}) : super(key: key);

  @override
  _SignUpWithPhoneNumberState createState() => _SignUpWithPhoneNumberState();
}

class _SignUpWithPhoneNumberState extends State<SignUpWithPhoneNumber> {
  final _focusNode = FocusNode();
  Color _strokeColor = Colors.black;
  String? _phoneNumber;
  bool _isErrorVisible = false;
  String _errorMessage = 'Invalid Phone Number';
  bool _isProgressVisible = false;

  var responsiveButtonState = GlobalKey<ProgressIndicatingButtonState>();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
      () {
        if (kDebugMode) {
          print('Focus: ${_focusNode.hasFocus}');
        }
        if (_focusNode.hasFocus) {
          setState(() {
            _strokeColor = Colors.blue;
          });
        } else {
          setState(() {
            if (_isErrorVisible) {
              _strokeColor = Colors.red;
            } else {
              _strokeColor = Colors.black;
            }
          });
        }
      },
    );
  }

  Future<bool> _willPopScope() async {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
    if (_isProgressVisible) {
      setState(
        () {
          _isProgressVisible = false;
        },
      );
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopScope,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            //When clicked anywhere else on the screen
            if (_focusNode.hasFocus) _focusNode.unfocus();
          },
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Back Button
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('< Back'),
                    ),
                  ),
                ),
                //Enter Phone Number
                Container(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter Your Phone',
                        ),
                        const Text(
                            'We will send a confirmation code to your phone'),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: _strokeColor,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                ' +91 | ',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              ),
                              Expanded(
                                child: TextField(
                                  focusNode: _focusNode,
                                  onChanged: (value) {
                                    _phoneNumber = value;
                                    setState(() {
                                      _isErrorVisible = false;
                                    });
                                  },
                                  style: const TextStyle(
                                      fontSize: 20, letterSpacing: 10),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    counterStyle: TextStyle(
                                      height: double.minPositive,
                                    ),
                                    counterText: "",
                                  ),
                                  maxLines: 1,
                                  maxLength: 10,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _isErrorVisible,
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Next button

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ProgressIndicatingButton(
                    key: responsiveButtonState,
                    title: 'Next',
                    onTap: _nextOnClick,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _nextOnClick() {
    setState(() {
      _isErrorVisible = false;
    });

    if (_phoneNumber == null ||
        _phoneNumber!.isEmpty ||
        _phoneNumber!.length < 10) {
      setState(() {
        _isErrorVisible = true;
        _errorMessage = "Please provide a valid phone number";
      });
      return;
    }
    _sendCode();
    return;
  }

  void _sendCode() {
    responsiveButtonState.currentState!.setProgressState();
    FirebaseAuth.instance.verifyPhoneNumber(
      // phoneNumber: _tempTestPhoneNumber,
      phoneNumber: '+91${_phoneNumber!}',
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        if (kDebugMode) {
          print('Verification Completed: ${phoneAuthCredential.asMap()}');
        }
      },
      verificationFailed: (FirebaseAuthException error) {
        if (kDebugMode) {
          print('Verification Failed: ${error.message}');
        }

        setState(() {
          _isErrorVisible = true;
          _errorMessage = error.message!;
          responsiveButtonState.currentState!.setNormalState();
        });
      },
      codeSent: (String? verificationId, int? forceResendingToken) {
        if (kDebugMode) {
          print('Code sent with verification ID: $verificationId');
        }
        setState(() {
          responsiveButtonState.currentState!.setNormalState();
        });
        _gotoVerificationScreen(verificationId!);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (kDebugMode) {
          print(
              'CodeAutoRetrievalTimeout with verification ID: $verificationId');
        }
      },
    );
  }

  void _gotoVerificationScreen(String verificationId) {
    responsiveButtonState.currentState!.setDoneState();

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhoneNumberVerification(
            verificationId: verificationId,
            phoneNumber: '+91${_phoneNumber!}',
          ),
        ),
      );
    });
  }
}
