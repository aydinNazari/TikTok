import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_2/constants.dart';

import '../models/user.dart';

class SearchedController extends GetxController {
  final Rx<List<User>> _searchedUser = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUser.value;

  searchUser(String typedUser) async {
    _searchedUser.bindStream(
      firebaseFireStore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<User> retVal = [];
          if (typedUser == '') {
            return retVal;
          } else {
            for (var elem in query.docs) {
              retVal.add(
                User.fromSnap(
                  elem,
                ),
              );
            }
            return retVal;
          }
        },
      ),
    );
  }
}
