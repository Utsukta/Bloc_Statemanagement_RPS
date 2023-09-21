import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpsbloc/homepage/profile/bloc/profile_bloc.dart';
import 'package:rpsbloc/homepage/repository/homepage_api.dart';
import 'package:rpsbloc/loginpage/bloc/login_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

final homepagerepository = HomePageRepository();

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        color: const Color.fromARGB(255, 243, 241, 241),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 12, 103, 177),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 25,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/icons/Japan Flag.png'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Hello,',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Madan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Icon(
                        Icons.circle_notifications_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'XXXX',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          Text(
                            'RPS Points',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor:
                                const Color.fromARGB(255, 3, 64, 114)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Details',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30)
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 5, 97, 172))),
                      onPressed: () {
                        showDialogBox(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Row(
                          children: [
                            // SvgPicture.asset('assets/profiletest.svg'),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Profile & Settings',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  'Personal info, security',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 5, 97, 172))),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Row(
                          children: [
                            // SvgPicture.asset('assets/profiletest.svg'),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Change Mpin',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  'Personal info, security',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      )
    ]));
  }
}

Future showDialogBox(BuildContext context) {
  final loginBloc = context.read<LoginBloc>();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Builder(builder: (context) {
              return SizedBox(
                height: 250,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Icon(
                      Icons.circle_outlined,
                      size: 80,
                      color: Colors.grey,
                    ),
                    const Text(
                      "Confirm",
                      style: TextStyle(
                          color: Color.fromARGB(255, 6, 63, 110),
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                    const Text(
                      "Are you sure you want to exit page?",
                      style: TextStyle(fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              backgroundColor:
                                  const Color.fromARGB(255, 8, 75, 129)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 13),
                            child: Text(
                              "cancel",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        BlocListener<ProfileBloc, ProfileState>(
                          listener: (context, state) {
                            if (state is ExitbuttonClickedState) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);
                              loginBloc.add(LogoutSuccessEvent());
                            }
                          },
                          child: OutlinedButton(
                            onPressed: () {
                              BlocProvider.of<ProfileBloc>(context)
                                  .add(ExitbuttonClickedEvent());

                              homepagerepository.logoutAccessTokenDelete();
                            },
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor: Colors.green),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 13),
                              child: Text(
                                "Exit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
            actionsAlignment: MainAxisAlignment.center);
      });
}
