import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpsbloc/loginpage/view/login_view.dart';
import 'package:rpsbloc/registerpage/bloc/register_bloc.dart';
import 'package:rpsbloc/routes/app_router.gr.dart';
import 'package:rpsbloc/shared/custom_widget.dart';

@RoutePage()
class RegisterPageView extends StatefulWidget {
  const RegisterPageView({super.key});

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  bool isEmailValueChanged = false;
  bool isPasswordValueChanged = false;
  bool isConfirmPasswordValueChanged = false;
  final registerbloc = RegisterBloc();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                      child: Image.asset(
                        'assets/icons/back_arrow.png',
                        height: 40,
                        width: 40,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),

                            //For signup text
                            const Text(
                              'Create',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35),
                            ),
                            const Text(
                              'Account',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35),
                            ),
                            const SizedBox(height: 15),

                            const Text(
                              "Sign up to get started!",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 87, 86, 86),
                                  fontSize: 17),
                            ),
                            const SizedBox(height: 25),

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
                                    return "Email cannot be empty";
                                  } else if (value.isNotEmpty) {
                                    if (!value.contains(RegExp(
                                        r'[A-Za-z0-9!#$%^&*()-+={}:;/|,.~`]+@[A-Za-z0-9]+.[a-zA-z]'))) {
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
                                  } else if (value.isEmpty) {
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
                                    return "Password field shouldn't be empty";
                                  } else if (value.length < 8) {
                                    return 'Password is very short';
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

                            CustomInputFieldwithlabel(
                                onchanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      isConfirmPasswordValueChanged = true;
                                    });
                                  } else if (value.isEmpty) {
                                    setState(() {
                                      isConfirmPasswordValueChanged = false;
                                    });
                                  }
                                },
                                isPassword: true,
                                label: 'Confirm Password',
                                hinttext: 'Confirm Password',
                                controller: confirmpasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Confirm password field shouldn't be empty";
                                  } else if (confirmpasswordController.text !=
                                      passwordController.text) {
                                    return "Password doesn't match";
                                  } else {
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 20),
                            const Text(
                              'Password must have atleast 8 characters, with one number, one lowercase, one uppercase & one special character.',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 78, 77, 77),
                                  fontSize: 13),
                            ),
                            const SizedBox(height: 30),

                            BlocConsumer<RegisterBloc, RegisterState>(
                              bloc: registerbloc,
                              listener: (context, state) {
                                if (state is RegisterSuccess) {
                                  AutoRouter.of(context).push(
                                      EmailVerificationView(
                                          text: emailController.text));
                                } else if (state is RegisterError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)));
                                }
                              },
                              builder: (context, state) {
                                if (state is RegisterInitial) {
                                  if (isEmailValueChanged == true &&
                                      isPasswordValueChanged == true &&
                                      isConfirmPasswordValueChanged == true) {
                                    return CustomButtonwithlabel(
                                      label: 'Register',
                                      color:
                                          const Color.fromARGB(255, 4, 56, 100),
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          registerbloc.add(
                                              RegisterButtonClickedEvent(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  confirmpassword:
                                                      confirmpasswordController
                                                          .text));
                                        }
                                      },
                                    );
                                  }
                                } else if (state is RegisterLoading) {
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
                                } else if (state is RegisterError) {
                                  return CustomButtonwithlabel(
                                    label: 'Register',
                                    onPressed: () {
                                      //if error state ma enter vayo vane it checks validation before triggering event
                                      if (formKey.currentState!.validate()) {
                                        registerbloc.add(
                                            RegisterButtonClickedEvent(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                confirmpassword:
                                                    confirmpasswordController
                                                        .text));
                                      }
                                    },
                                  );
                                }

                                return CustomButtonwithlabel(
                                  label: 'Register',
                                  onPressed: () {},
                                  color: Colors.grey,
                                );
                              },
                            ),

                            const SizedBox(height: 15),

                            const Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                )),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Or SignIn with',
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
                            const SizedBox(height: 20),
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
                                                const LoginPageView()));
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 10, 74, 126),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
