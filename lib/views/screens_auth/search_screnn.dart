import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tiktok_2/views/screens_auth/profile_screen.dart';

import '../../constants.dart';
import '../../controls/search_controller.dart';
import '../../models/user.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchedController searchController = Get.put(SearchedController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: TextFormField(
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              icon: const Icon(Icons.search),
              border: InputBorder.none,
              hintText: 'Search . . .',
              hintStyle: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w800),
            ),
            onChanged: (value) {
              searchController.searchUser(value);
              setState(() {});
            },
          ),
        ),
        body: searchController.searchedUsers.isEmpty
            ? const Center(
                child: Text('Search for users...'),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedUsers[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ProfileScreen(
                            uid: user.uid,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profilPhoto,
                        ),
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width / 20,
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
