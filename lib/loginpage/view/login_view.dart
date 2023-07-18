import 'package:flutter/material.dart';
import 'package:rpsbloc/homepage/home/view/homepage_view.dart';
import 'package:rpsbloc/loginpage/bloc/login_bloc.dart';
import 'package:rpsbloc/registerpage/view/register_view.dart';
import 'package:rpsbloc/shared/custom_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // final loginBloc = LoginBloc();
  bool isEmailValueChanged = false;
  bool isPasswordValueChanged = false;
  @override
  Widget build(BuildContext context) {
    return Form(
        //Used to establish connection between form and key
        key: formKey,
        child: Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/icons/rps_logo.png',
                  height: 40,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset('assets/images/remittance.jpg'),
                      const SizedBox(
                        height: 10,
                      ),

                      //Email section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        child: Column(
                          children: [
                            CustomInputFieldwithlabel(
                                onchanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      isEmailValueChanged = true;
                                    });
                                  } else if (value.isEmpty) {
                                    setState(() {
                                      isEmailValueChanged = false;
                                    });
                                  }
                                },
                                label: 'Email',
                                hinttext: 'Enter you email',
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "*Required";
                                  } else if (value.isNotEmpty) {
                                    if (!value.contains(RegExp(
                                        r'[A-Za-z0-9!#$%^&*()-+={}:;/|,.~`]+@[A-Za-z0-9]+\.[a-zA-z]'))) {
                                      return 'Enter valid email';
                                    }
                                  } else {
                                    return null;
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 20),
                            CustomInputFieldwithlabel(
                                onchanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      isPasswordValueChanged = true;
                                    });
                                  } else {
                                    setState(() {
                                      isPasswordValueChanged = false;
                                    });
                                  }
                                },
                                isPassword: true,
                                label: 'Password',
                                hinttext: 'Enter your password',
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "*Required";
                                  } else if (value.contains(RegExp(r'(\s)'))) {
                                    return 'Shouldnot contain white space';
                                  } else if (!value.contains(RegExp(
                                      r'((?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_=+""'
                                      ':;><?/~`]).{8,})'))) {
                                    return 'Password should contain Uppercase, lowercase, number and special character';
                                  } else {
                                    return null;
                                  }
                                }),

                            const SizedBox(height: 20),
                            const Align(
                                alignment: Alignment.bottomRight,
                                child: Text('Forgot password?')),
                            const SizedBox(
                              height: 30,
                            ),

                            ///test
                            BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is LoginSuccessState) {
                                  {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePageView()));
                                  }
                                }

                                if (state is LoginErrorState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                final loginBloc = context.read<LoginBloc>();
                                if (state is LoginInitial) {
                                  if (isPasswordValueChanged == true &&
                                      isEmailValueChanged == true) {
                                    return CustomButtonwithlabel(
                                        label: 'Login',
                                        onPressed: () {
                                          //this if - doesn't allow to trigger the event at very initial.
                                          if (formKey.currentState!
                                              .validate()) {
                                            loginBloc.add(
                                                LoginButtonCLickedEvent(
                                                    email: emailController.text,
                                                    password: passwordController
                                                        .text));
                                          }
                                        });
                                  }
                                }

                                if (state is LoginLoadingState) {
                                  return SizedBox(
                                    height: 55,
                                    width: MediaQuery.of(context).size.width,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          backgroundColor: const Color.fromARGB(
                                              255, 13, 102, 174),
                                        ),
                                        onPressed: () {},
                                        child:
                                            const CircularProgressIndicator()),
                                  );
                                }
                                if (state is LoginErrorState) {
                                  return CustomButtonwithlabel(
                                    label: 'Login',
                                    onPressed: () {
                                      //if error state ma enter vayo vane it checks validation before triggering event
                                      if (formKey.currentState!.validate()) {
                                        loginBloc.add(LoginButtonCLickedEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ));
                                      }
                                    },
                                  );
                                }
                                if (state is LoginSuccessState) {
                                  return CustomButtonwithlabel(
                                      label: 'Log In', onPressed: () {});
                                }

                                return CustomButtonwithlabel(
                                    color: Colors.grey,
                                    label: 'Login',
                                    onPressed: () {});
                              },
                            ),

                            const SizedBox(height: 30),
                            Row(
                              children: const [
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                )),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Or continue with',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 62, 61, 61),
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                )),
                              ],
                            ),
                            const SizedBox(height: 30),
                            const CustomButtonWithImageAndLabel(
                              image: 'assets/icons/google_logo.png',
                              label: 'Sign in with Google',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const CustomButtonWithImageAndLabel(
                              image: 'assets/icons/facebook_logo.png',
                              label: 'Sign in with Facebook',
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have and account? ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPageView()));
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 10, 74, 126),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
