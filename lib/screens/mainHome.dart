import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelime_oyunu/const/consts.dart';
import 'package:kelime_oyunu/googleAds/reklam.dart';
import 'package:kelime_oyunu/screens/home.dart';
import 'package:kelime_oyunu/screens/istatislik.dart';
import 'package:kelime_oyunu/screens/sozluk.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final Reklam reklam = Reklam();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Consts.reklamGostermeSayisi == 1) {
      reklam.showGecisAd();
      Consts.reklamGostermeSayisi = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    reklam.loadAdGecis();
    print(Consts.user!.toJson());
    return Obx(() {
      return Scaffold(
        body: Consts.selectedIndex.value == 0
            ? Home()
            : Consts.selectedIndex.value == 1
                ? Sozluk()
                : IstatislikScreen(),

        /*   selectedIndex == 2
                  ? GameScreen()
                  : Profil(),*/
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: Consts.selectedIndex.value,
            selectedItemColor: Colors.orange[700],
            unselectedItemColor: const Color(0xff757575),
            type: BottomNavigationBarType.shifting,
            onTap: (index) {
              setState(() {
                Consts.selectedIndex.value = index;
              });
            },
            items: _navBarItems),
      );
    });
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Anasayfa',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.book_outlined),
    activeIcon: Icon(Icons.book_rounded),
    label: 'Sözlük',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.sort_outlined),
    activeIcon: Icon(Icons.sort_rounded),
    label: 'Sıralama',
  ),
  /* BottomNavigationBarItem(
    icon: Icon(Icons.person_outline_rounded),
    activeIcon: Icon(Icons.person_rounded),
    label: 'Hesabım',
  ),*/
];
