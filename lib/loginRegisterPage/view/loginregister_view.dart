import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rpsbloc/loginRegisterPage/bloc/loginregister_bloc.dart';
import 'package:rpsbloc/registerpage/view/register_view.dart';
import 'package:rpsbloc/shared/custom_widget.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

bool isConversionAmountChanged = false;

String nprconvertedtamount = '0';

NumberFormat myFormat = NumberFormat.decimalPatternDigits(
  locale: 'en_us',
  decimalDigits: 2,
);

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  TextEditingController jpyamountcontroller = TextEditingController();

  final loginregisterbloc = LoginregisterBloc();

  @override
  void initState() {
    super.initState();
    loginregisterbloc.add(LoginregisterSuccessEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 2, 89, 160),
            image: DecorationImage(
                image: AssetImage('assets/icons/splash-bg.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Image.asset(
              'assets/images/splash.png',
              height: 110,
            ),

            //send money container
            BlocBuilder<LoginregisterBloc, LoginregisterState>(
              bloc: loginregisterbloc,
              builder: (context, state) {
                if (state is LoginregisterInitial) {
                  return Center(
                      child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    height: 270,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 246, 244, 244),
                        borderRadius: BorderRadius.circular(15)),
                  ));
                } else if (state is LoginregisterloadingState) {
                  return Center(
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        height: 270,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 246, 244, 244),
                            borderRadius: BorderRadius.circular(15)),
                        child:
                            const Center(child: CircularProgressIndicator())),
                  );
                } else if (state is LoginregisterSuccessState) {
                  final exchangeratedata = state.exchangeratedate;

                  return Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      height: 270,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 246, 244, 244),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  "SEND MONEY",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              CustomContainerWithInputField(
                                maxlength: 15,
                                readonly: false,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Conversion amount',
                                    hintStyle: TextStyle(fontSize: 10)),
                                image: 'assets/icons/Japan Flag.png',
                                label: 'JPY',
                                name: 'You send',
                                controller: jpyamountcontroller,
                                onchanged: (value) {
                                  setState(() {
                                    {
                                      if (jpyamountcontroller.text.isNotEmpty) {
                                        var jpyamountwithoutcomma =
                                            jpyamountcontroller.text
                                                .replaceAll(",", '');
                                        for (var i = 0;
                                            i < exchangeratedata.data.length;
                                            i++) {
                                          // nprconvertedtamount = (num.parse(
                                          //         jpyamountwithoutcomma) *
                                          //     exchangeratedata.data[i].rate).toStringAsFixed(2);
                                          nprconvertedtamount = myFormat.format(
                                              (num.parse(
                                                      jpyamountwithoutcomma) *
                                                  exchangeratedata
                                                      .data[i].rate));
                                        }
                                      } else {
                                        if (jpyamountcontroller.text.isEmpty) {
                                          nprconvertedtamount = '0.00';
                                        }
                                      }
                                    }
                                    isConversionAmountChanged = true;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icons/Group36690.png',
                                        height: 80,
                                        width: 50,
                                      ),
                                      Image.asset(
                                        'assets/icons/Reload100.png',
                                        height: 20,
                                      )
                                    ],
                                  ),
                                  const Column(
                                    children: [
                                      Text(
                                        '1 JPY = 1.010 NPR',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('1 NPY = 0.990 JPY',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              isConversionAmountChanged == false
                                  ? CustomContainerWithInputField(
                                      readonly: true,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(fontSize: 10)),
                                      image: 'assets/icons/Japan Flag.png',
                                      label: 'NPR',
                                      border: Border.all(color: Colors.white),
                                      icon: Icons.arrow_drop_down_outlined,
                                      name: 'Recipient gets',
                                      controller: TextEditingController(
                                          text: nprconvertedtamount),
                                    )
                                  : CustomContainerWithInputField(
                                      readonly: true,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(fontSize: 10)),
                                      image: 'assets/icons/Japan Flag.png',
                                      label: 'NPR',
                                      icon: Icons.arrow_drop_down_outlined,
                                      name: 'Recipient gets',
                                      controller: TextEditingController(
                                          text: nprconvertedtamount),
                                    ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'SERVICE FEE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    'assets/icons/info.png',
                                    height: 15,
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),

            Container(
              height: 185,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  children: [
                    CustomButtonwithlabel(
                        label: 'Create an account',
                        color: const Color.fromARGB(255, 7, 84, 147),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterPageView()));
                        }),
                    const SizedBox(height: 10),
                    CustomButtonwithlabel(
                      label: 'Sign In',
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      color: Colors.white,
                      textstyle:
                          const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    const Expanded(child: SizedBox()),
                    const Text(
                      'APP VERSION V 0.0.0',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
