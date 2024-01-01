import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rpsbloc/homepage/barpage.dart/barpage.dart';
import 'package:rpsbloc/homepage/home/view/homepage_view.dart';
import 'package:rpsbloc/homepage/profile/profile.dart';
import 'package:rpsbloc/homepage/recepient.dart';

@RoutePage()
class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int selectedIndex = 0;
  final List pages = [
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
