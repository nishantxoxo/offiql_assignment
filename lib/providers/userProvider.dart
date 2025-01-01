import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:offiql/models/userModel.dart';
import 'package:http/http.dart' as http;

class Userprovider with ChangeNotifier {
  List<UserModel> _users = [];

  List<UserModel> get users {
    return [..._users];
  }                                     //return a copy of the users

  int getlength() {
    return _users.length;
  }                                      //returns the length of user

  Future<void> fetchAndSet() async {                                       //to get all the users
    final url = 'https://jsonplaceholder.typicode.com/users';
    try {
      final Response = await http.get(Uri.parse(url));                       //fetch the data with a GET request
      final extracted = json.decode(Response.body) as List<dynamic>;                  
      final List<UserModel> loadedUser = [];                                 // create a local list
      extracted.forEach(
        (element) {
          loadedUser.add(UserModel.fromJson(element));
        },
      );

      _users = loadedUser;                   
    } catch (e) {}
  }

  Future<void> adduser(UserModel user) async {                   //to add new user
    try {
      _users.add(user);
      notifyListeners();     //adds new user
    } catch (e) {
      throw e;
    }
  }
}
