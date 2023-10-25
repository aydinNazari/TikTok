import 'package:flutter/material.dart';

import '../../constants.dart';
import '../widgets/custom_icon.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('/////////////////////////////');
    print(currentUserCallBack());
    print(firebaseAuth.currentUser!.email);
    print('--------------------------------');
  }
  int pageIdx=0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (idx){
            pageIdx=idx;
            setState(() {

            });
          },
          currentIndex: pageIdx,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: size.width / 15,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: size.width / 15,
                ),
                label: 'Search'),
             const BottomNavigationBarItem(
              label: '',
              icon: CustomIcon(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.inbox,

                size: size.width / 15,
              ),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.
                  person,
                  size: size.width / 15,
                ),
                label: 'Profile'),
          ],
        ),
        body: pageList[pageIdx],
      ),
    );
  }
}

