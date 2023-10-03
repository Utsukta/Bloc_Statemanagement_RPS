import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpsbloc/emailverification_page/bloc/emailverification_bloc.dart';
import 'package:rpsbloc/shared/custom_widget.dart';
import 'package:pinput/pinput.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  final pinController = TextEditingController();
  bool enableResend = false;
  late Timer timer;
  int _secondsRemaining = 120;
  String get formattedTime {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        // Timer completed, perform any desired actions here
        setState(() {
          enableResend = true;
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
      if (!mounted) {
        timer.cancel(); // Cancel the timer when the widget is not mounted
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
            child: Image.asset(
              'assets/icons/back_arrow.png',
              height: 40,
              width: 40,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            'Email',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const Text(
            'Verification',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 15),
          const Text(
            "We have sent code to",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            email.toString(),
            style: const TextStyle(color: Color.fromARGB(255, 7, 92, 162)),
          ),

          const SizedBox(height: 50),

          //OTP Field for Verification
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pinput(
                showCursor: false,
                controller: pinController,
                length: 6,
                focusedPinTheme: PinTheme(
                    height: 60,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 87, 141, 235)))),
                defaultPinTheme: PinTheme(
                    height: 60,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 196, 194, 194)))),
              ),
            ],
          ),

          const SizedBox(
            height: 50,
          ),

          BlocConsumer<EmailverificationBloc, EmailverificationState>(
            listener: (context, state) {
              if (state is EmailverificationSuccess) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialogBox(
                          icon: Icons.check,
                          message: state.message,
                          buttontext: "OK",
                          title: "Verification Successful",
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/numberverificationpage");
                          },
                          color: Colors.green);
                    });
              }
              if (state is ResendCodeSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.data),
                  ),
                );
                setState(() {
                  enableResend = false;
                  _secondsRemaining = 120;
                });
              }

              if (state is EmailverificationErrorState) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialogBox(
                          icon: Icons.close,
                          message: state.error,
                          buttontext: "Retry",
                          title: "Verification Failed",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.red);
                    });
              }
            },
            builder: (context, state) {
              final emailverificationBloc =
                  BlocProvider.of<EmailverificationBloc>(context);

              if (state is EmailverificationInitial ||
                  state is EmailverificationErrorState ||
                  state is ResendCodeSuccessState) {
                return Column(
                  children: [
                    enableResend == false
                        ? CustomButtonwithlabel(
                            label: 'Verify',
                            onPressed: () {
                              emailverificationBloc.add(
                                  VerifyButtonClickedEvent(
                                      email: email.toString(),
                                      code: pinController.text.toString()));
                            },
                            color: const Color.fromARGB(255, 12, 101, 173),
                          )
                        : CustomButtonwithlabel(
                            label: 'Verify',
                            onPressed: () {},
                            color: const Color.fromARGB(255, 121, 121, 123),
                          ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        enableResend == false
                            ? const Text(
                                'Resend OTP',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 18, 89, 148)),
                              )
                            : const Text(
                                'Didnot recevie the code?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        enableResend == false
                            ? Text(
                                formattedTime,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 16),
                              )
                            : const SizedBox(),
                        enableResend == true
                            ? InkWell(
                                onTap: () {
                                  emailverificationBloc.add(
                                      ResendCodeButtonClicked(
                                          email: email.toString()));
                                  setState(() {
                                    enableResend = false;
                                  });
                                },
                                child: const Text(
                                  'Resend Code',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 8, 90, 156),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ))
                            : const SizedBox()
                      ],
                    )
                  ],
                );
              }

              if (state is EmailverificationLoadingState) {
                return Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor:
                                const Color.fromARGB(255, 13, 102, 174),
                          ),
                          onPressed: () {},
                          child: const CircularProgressIndicator()),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        enableResend == false
                            ? const Text(
                                'Resend OTP',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 19, 98, 163)),
                              )
                            : const Text(
                                'Didnot recevie the code?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        enableResend == false
                            ? Text(formattedTime,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 16))
                            : const SizedBox(),
                        enableResend == true
                            ? InkWell(
                                onTap: () {
                                  emailverificationBloc.add(
                                      ResendCodeButtonClicked(
                                          email: email.toString()));
                                  setState(() {
                                    enableResend = false;
                                  });
                                },
                                child: const Text(
                                  'Resend Code',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 8, 90, 156),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ))
                            : const SizedBox()
                      ],
                    )
                  ],
                );
              }

              if (state is ResendCodeLoadingState) {
                return Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor:
                                const Color.fromARGB(255, 13, 102, 174),
                          ),
                          onPressed: () {},
                          child: const CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Didnot recevie the code?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Resend Code',
                          style: TextStyle(
                              color: Color.fromARGB(255, 8, 90, 156),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )
                      ],
                    )
                  ],
                );
              }

              return CustomButtonwithlabel(
                label: 'Verify',
                onPressed: () {},
                color: const Color.fromARGB(255, 12, 101, 173),
              );
            },
          ),

          const SizedBox(
            height: 35,
          ),
        ]),
      ),
    ));
  }
}
