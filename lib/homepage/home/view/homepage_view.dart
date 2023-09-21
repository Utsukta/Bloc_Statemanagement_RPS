import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rpsbloc/homepage/barpage.dart/barpage.dart';
import 'package:rpsbloc/homepage/home/bloc/homepage_bloc.dart';
import 'package:rpsbloc/homepage/home/model/homepage_model.dart';
import 'package:rpsbloc/homepage/profile/profile.dart';
import 'package:rpsbloc/loginpage/view/login_view.dart';
import 'package:rpsbloc/recepient.dart';
import 'package:rpsbloc/shared/custom_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    const HomepageWidget(),
    const BarPage(),
    const Recepient(),
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[selectedIndex],
        floatingActionButton: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 9, 95, 164),
            onPressed: () {},
            child: const Icon(
              Icons.send_outlined,
              size: 35,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 6,
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: const Color.fromARGB(255, 100, 98, 98),
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/home/nav/home.svg",
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 0 ? Colors.blue : Colors.grey,
                        BlendMode.srcIn),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/home/nav/bars.svg",
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 1 ? Colors.blue : Colors.grey,
                        BlendMode.srcIn),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home/nav/recepient.svg',
                    colorFilter: ColorFilter.mode(
                        selectedIndex == 2 ? Colors.blue : Colors.grey,
                        BlendMode.srcIn),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: selectedIndex == 3
                      ? SvgPicture.asset(
                          'assets/icons/home/nav/profile_selected.svg',
                        )
                      : SvgPicture.asset(
                          'assets/icons/home/nav/profile.svg',
                        ),
                  label: ''),
            ],
          ),
        ),
      ),
    );
  }
}

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key});

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

final homepagebloc = HomepageBloc();

class _HomepageWidgetState extends State<HomepageWidget> {
  TextEditingController amountcontroller = TextEditingController();

  bool isAllSelected = true;
  bool isSentSelected = false;
  bool isTopupSelected = false;
  bool isConversionAmountChanged = false;

  List<TransactionList> currentTransactionList = [];

  @override
  void initState() {
    homepagebloc.add(HomePageDataFetchedEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomepageBloc, HomepageState>(
      bloc: homepagebloc,
      listener: (context, state) {
        if (state is RefreshTokenExpiredState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPageView()));
        }
      },
      builder: (context, state) {
        if (state is HomepageLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomepageError) {
          return Text(state.message);
        } else if (state is HomepageSuccess) {
          final services = state.services;
          final userdetails = state.userdetails;
          final transaction = state.transaction;
          final quicksend = state.quicksend;

          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                homepagebloc.add(HomePageDataFetchedEvent());
              },
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 243, 241, 241)),
                  child: Column(
                    children: [
                      Container(
                        height: 170,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 12, 103, 177),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 25),
                                SvgPicture.network(userdetails.data.avatar),
                                const SizedBox(width: 10),
                                Text(
                                  ' ${userdetails.data.greeting},',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  userdetails.data.firstname,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white),
                                ),
                                const Expanded(child: SizedBox()),
                                Stack(
                                  children: [
                                    const Icon(Icons.notifications_none,
                                        color: Colors.white, size: 30),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Text(
                                        userdetails.data.notification
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.red, fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: const [
                                    SizedBox(width: 65),
                                    Text(
                                      'Available balance',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 65,
                                    ),
                                    const Text(
                                      '¥1525.25',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                    const SizedBox(width: 7),
                                    Image.asset(
                                      'assets/icons/hide.png',
                                      height: 25,
                                      width: 25,
                                      color: Colors.white,
                                    ),
                                    const Expanded(child: SizedBox()),
                                    const Icon(Icons.sync,
                                        color: Colors.white, size: 30),
                                    const SizedBox(width: 15)
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // Services
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var i = 0; i < services.data.length; i++)
                            CustomButtonWithImage(
                                image: services.data[i].image,
                                label: services.data[i].name),
                          Column(
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  onPressed: () {},
                                  child: SvgPicture.asset(
                                      'assets/icons/home/services/more.svg')),
                              const SizedBox(height: 7),
                              const Text(
                                'More',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      //Send Money

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        height: 180,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 209, 208, 208),
                                  blurRadius: 2,
                                  offset: Offset(0, 1)),
                              BoxShadow(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  offset: Offset(-1, 0)),
                              BoxShadow(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  offset: Offset(1, 0)),
                            ],
                            color: const Color.fromARGB(255, 250, 249, 249),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomContainerWithInputField(
                                  readonly: false,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Conversion amount',
                                      hintStyle: TextStyle(fontSize: 10)),
                                  image: 'assets/icons/Japan Flag.png',
                                  label: 'JPY',
                                  name: 'You send',
                                  controller: amountcontroller,
                                  onchanged: (value) {
                                    setState(() {
                                      isConversionAmountChanged = true;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
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
                                        icon: Icons.arrow_drop_down_outlined,
                                        name: 'Recipient gets',
                                        border: Border.all(color: Colors.white),
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
                                      ),
                                const SizedBox(height: 10),
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

                      const SizedBox(
                        height: 20,
                      ),

                      // Quicksendpart
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 224, 222, 222),
                                  blurRadius: 5),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(22, 15, 0, 13),
                              child: Text(
                                'Quick Send',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: quicksend.data.length + 1,
                                itemBuilder: (context, int index) {
                                  if (index == 0) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 5),
                                          child: Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              180,
                                                              208,
                                                              231)),
                                                  color: const Color.fromARGB(
                                                      255, 241, 240, 240),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: SvgPicture.asset(
                                                'assets/icons/home/ADD.svg',
                                                fit: BoxFit.none,
                                              )),
                                        ),
                                        const SizedBox(height: 10),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 5),
                                          child: Text(
                                            'add',
                                          ),
                                        )
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 243, 241, 241),
                                                  backgroundImage: NetworkImage(
                                                      quicksend.data[index - 1]
                                                          .image)),
                                              Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: SvgPicture.network(
                                                  quicksend.data[index - 1]
                                                      .nationality,
                                                  width: 20,
                                                  height: 20,
                                                ),
                                              ),
                                            ]),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            quicksend.data[index - 1].name,
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // //Recent Transactions

                      Container(
                        margin: const EdgeInsets.all(21),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Recent Transactions',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  'See all',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 8, 88, 153),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      side: isAllSelected == true
                                          ? const BorderSide(
                                              width: 2,
                                              color: Color.fromARGB(
                                                  255, 35, 93, 140))
                                          : const BorderSide(
                                              color: Colors.white),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isAllSelected = true;
                                        isSentSelected = false;
                                        isTopupSelected = false;
                                        currentTransactionList =
                                            transaction.data;
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 9),
                                      child: Text(
                                        'All',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      side: isSentSelected == true
                                          ? const BorderSide(
                                              width: 2,
                                              color: Color.fromARGB(
                                                  255, 35, 93, 140))
                                          : const BorderSide(
                                              color: Colors.white),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      isAllSelected = false;
                                      isSentSelected = true;
                                      isTopupSelected = false;
                                      currentTransactionList = transaction.data
                                          .where((element) =>
                                              element.type == "sent")
                                          .toList();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.blue,
                                  ),
                                  label: const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 9, 15, 9),
                                    child: Text(
                                      'Sent',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                  ),
                                ),
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        side: isTopupSelected == true
                                            ? const BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(
                                                    255, 35, 93, 140))
                                            : const BorderSide(
                                                color: Colors.white),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        backgroundColor: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        isAllSelected = false;
                                        isSentSelected = false;
                                        isTopupSelected = true;
                                        currentTransactionList = transaction
                                            .data
                                            .where((element) =>
                                                element.type == "top-up")
                                            .toList();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.blue,
                                    ),
                                    label: const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 9, 5, 9),
                                      child: Text(
                                        'TopUp',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: isAllSelected
                                  ? min(5, transaction.data.length)
                                  : min(5, currentTransactionList.length),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                TransactionList transactionlist;
                                if (isAllSelected) {
                                  // transaction = transactionmodel!.data[index];
                                  transactionlist = transaction.data.reversed
                                      .elementAt(index);
                                } else {
                                  transactionlist = currentTransactionList
                                      .reversed
                                      .elementAt(index);
                                }
                                var formattedDate = DateFormat('hh:mm d-MM-yyy')
                                    .format(transactionlist.createdAt);

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Container(
                                    height: 75,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 209, 208, 208),
                                              blurRadius: 2,
                                              offset: Offset(0, 1)),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: ListTile(
                                        leading: Stack(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 233, 232, 232),
                                              radius: 25,
                                              child: transactionlist.image == ""
                                                  ? Text(
                                                      transactionlist
                                                          .placeholder,
                                                    )
                                                  : Image.network(
                                                      transactionlist.image
                                                          .toString()),
                                            ),
                                            Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: SvgPicture.network(
                                                  transactionlist.nationality,
                                                  height: 20,
                                                ))
                                          ],
                                        ),
                                        title: Text(
                                          transactionlist.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        subtitle: Text(formattedDate),
                                        trailing: Wrap(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  transactionlist.amount,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      transactionlist.type,
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    transactionlist.type ==
                                                            "top-up"
                                                        ? const Icon(
                                                            Icons
                                                                .keyboard_arrow_down_sharp,
                                                            color: Colors.blue,
                                                            size: 20)
                                                        : const Icon(
                                                            Icons
                                                                .keyboard_arrow_up_sharp,
                                                            color: Colors.blue,
                                                            size: 20)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),

                      //Utility Payments
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    'Utility Payments',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  CustomButtonWithIcon(
                                    icon: Icons.light_outlined,
                                    label: 'Electricity',
                                  ),
                                  CustomButtonWithIcon(
                                    icon: Icons.water_drop_outlined,
                                    label: 'Water',
                                  ),
                                  CustomButtonWithIcon(
                                    icon: Icons.cell_tower_rounded,
                                    label: 'Internet',
                                  ),
                                  CustomButtonWithIcon(
                                    icon:
                                        Icons.indeterminate_check_box_outlined,
                                    label: 'TV',
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  CustomButtonWithIcon(
                                    icon: Icons.clean_hands_outlined,
                                    label: 'EMI',
                                  ),
                                  CustomButtonWithIcon(
                                    icon: Icons.savings_outlined,
                                    label: 'Savings',
                                  ),
                                  CustomButtonWithIcon(
                                    icon: Icons.devices_other_outlined,
                                    label: 'Others',
                                  ),
                                  CustomButtonWithIcon(
                                    icon: Icons.umbrella_outlined,
                                    label: 'Insurance',
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
