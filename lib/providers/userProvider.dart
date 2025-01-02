import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:offiql/models/userModel.dart';
import 'package:http/http.dart' as http;

class Userprovider with ChangeNotifier {
  List<UserModel> _users = [];

  List<UserModel> get users {
    return [..._users];
  }                                                                         //return a copy of the users

  int getlength() {
    return _users.length;
  }                                                                         //returns the length of user

  Future<void> fetchAndSet() async {                                         //to get all the users
    final url = 'https://jsonplaceholder.typicode.com/users';
    try {
      final Response = await http.get(Uri.parse(url));                       //fetch the data with a GET request
      final extracted = json.decode(Response.body) as List<dynamic>;                  
      final List<UserModel> loadedUser = [];                                 
      extracted.forEach(
        (element) {
          loadedUser.add(UserModel.fromJson(element));
        },
      );

      _users = loadedUser;                                          // make the fetched users as list of users of this class
    } catch (e) {
      throw e;
    } 
  }

  Future<void> adduser(UserModel user) async {                   //to add new user
    try {
      _users.add(user);
      notifyListeners();                                           //adds new user
    } catch (e) {
      throw e;
    }
  }

/*function to fetch users by name, return the entire list if there is 
 nothing in the search bar*/
 List<UserModel> searchUserByName(String query){                                
    if (query.isEmpty) return [..._users];
    final searchresult = _users.where((element) {
      return element.name!.toLowerCase().contains(query.toLowerCase());
    },).toList();
    return searchresult;
  }
}
