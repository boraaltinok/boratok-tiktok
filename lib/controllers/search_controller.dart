import 'package:boratok/constants.dart';
import 'package:boratok/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(
        firestore.collection('users').where(
            'name', isGreaterThanOrEqualTo: typedUser).snapshots().map((
            QuerySnapshot query){
              List<User> retVal = [];
              for(var user in query.docs){
                retVal.add(User.fromSnap(user));
              }
              return retVal;
        })
    );
  }
}