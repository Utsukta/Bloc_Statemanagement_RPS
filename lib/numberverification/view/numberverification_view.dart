import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:rpsbloc/numberverification/bloc/number_verification_bloc.dart';
import 'package:rpsbloc/routes/app_router.gr.dart';
import 'package:rpsbloc/shared/custom_widget.dart';

@RoutePage()
class NumberVerificationPage extends StatefulWidget {
  const NumberVerificationPage({
    super.key,
  });

  @override
  State<NumberVerificationPage> createState() => _NumberVerificationPageState();
}

class _NumberVerificationPageState extends State<NumberVerificationPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController numberverificationcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).pop();
            },
            child: Image.asset(
              'assets/icons/back_arrow.png',
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            "Mobile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const Text("Number Verification",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Please enter your mobile number to verify.",
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 60,
          ),
          const Text("Country Code"),
          const SizedBox(
            height: 10,
          ),
          Row(children: [
            Container(
              height: 50,
              width: 100,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 147, 145, 145)))),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/Japan Flag.png',
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    '+81',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
                child: TextFormField(
              key: formKey,
              autofocus: false,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                MaskedInputFormatter('###-####-####'),
                LengthLimitingTextInputFormatter(13)
              ],
              controller: numberverificationcontroller,
              decoration: const InputDecoration(
                  hintText: "Enter your mobile number",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 174, 173, 173), fontSize: 15)),
            )),
          ]),
          const SizedBox(
            height: 50,
          ),
          BlocConsumer<NumberVerificationBloc, NumberVerificationState>(
            listener: (context, state) {
              if (state is NumberVerificationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.mobile.toString()),
                  ),
                );
                //auto route ma different banaunu parxa - ambiguity vairaxa so comment gareko
                AutoRouter.of(context).push(MobileOTPVerification(
                    number: numberverificationcontroller.text
                        .replaceAll("-", "")
                        .toString()));
              }
              if (state is NumberVerificationErrorState) {
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
              final numberverificationBloc =
                  BlocProvider.of<NumberVerificationBloc>(context);

              if (state is NumberVerificationInitial ||
                  state is NumberVerificationErrorState) {
                return CustomButtonwithlabel(
                    label: 'Send OTP',
                    onPressed: () {
                      numberverificationBloc.add(SentOTPButtonCLickedEvent(
                          numberverificationcontroller.text
                              .replaceAll("-", "")
                              .toString()));
                    });
              }
              if (state is NumberVerificationLoadingState) {
                return SizedBox(
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
                );
              }

              return CustomButtonwithlabel(label: 'Send OTP', onPressed: () {});
            },
          )
        ],
      ),
    ));
  }
}


// onchanged: (value) {
//                                   if (value.isNotEmpty) {
//                                     setState(() {
//                                       isEmailValueChanged = true;
//                                     });
//                                   } else if (value.isEmpty) {
//                                     setState(() {
//                                       isEmailValueChanged = false;
//                                     });
//                                   }
//                                 },
//                                 label: 'Email',
//                                 hinttext: 'Enter you email',
//                                 controller: emailController,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "*Required";
//                                   } else if (value.isNotEmpty) {
//                                     if (!value.contains(RegExp(
//                                         r'[A-Za-z0-9!#$%^&*()-+={}:;/|,.~`]+@[A-Za-z0-9]+\.[a-zA-z]'))) {
//                                       return 'Enter valid email';
//                                     }
//                                   } else {
//                                     return null;
//                                   }
//                                   return null;
//                                 }),



