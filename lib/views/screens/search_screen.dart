import 'package:boratok/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: TextFormField(
              decoration: const InputDecoration(
                  filled: false,
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 18, color: Colors.white)),
              onFieldSubmitted: (value) => searchController.searchUser(value),
            ),
          ),
          body: searchController.searchedUsers.isEmpty
              ? const Center(
                  child: Text(
                    'Search for users!',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  itemCount: searchController.searchedUsers.length,
                  itemBuilder: (context, index) {
                    User searchedUser = searchController.searchedUsers[index];
                    return InkWell(
                      onTap: () {},
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage:
                              NetworkImage(searchedUser.profilePhoto),
                        ),
                        title: Text(
                          searchedUser.name,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    );
                  }));
    });
  }
}
