import 'package:currency_converter/src/utils/consts.dart';
import 'package:flutter/material.dart';

import 'converter_page.dart';
import 'home_page.dart';

class HomeBase extends StatefulWidget {
  const HomeBase({super.key});

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Constants.errorMessage(
            description: "Do you want close the app?",
            onPressed: () {
              Constants.closeAppFunction();
            });
        return Future.value(true);
      },
      child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            notchMargin: 5,
            shape: const CircularNotchedRectangle(),
            color: Colors.white,
            child: BottomNavigationBar(
              onTap: (int v) {
                setState(() {
                  _currentIndex = v;
                });
              },
              elevation: 0,
              backgroundColor: Colors.transparent,
              currentIndex: _currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_max_outlined),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_convenience_store),
                  label: "Converter",
                ),
              ],
            ),
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: const [HomeScreen(), ConverterPage()],
          )),
    );
  }
}
