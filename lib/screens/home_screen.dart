import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:offiql/providers/userProvider.dart';
import 'package:offiql/screens/user_form.dart';
import 'package:offiql/widgets/user_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isloading = false; //to be used to show loading indicator

class _HomeScreenState extends State<HomeScreen> {
  String searched = "";                                   // stores the current searched String in the search bar
  final FocusNode searchFocusNode  = FocusNode();

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    unfocus();
  }


  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (_) async {
        setState(
          () {
            isloading = true;
          },
        );
        await Provider.of<Userprovider>(context, listen: false)
            .fetchAndSet(); // fucntion called to get all users from api
        setState(
          () {
            isloading = false;
          },
        );
      },
    );

    super.initState();
  }



void unfocus() {
  if(searchFocusNode.hasFocus){
    searchFocusNode.unfocus();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(  
            focusNode: searchFocusNode,
            decoration: const InputDecoration( 
              floatingLabelBehavior: FloatingLabelBehavior.never, 
              labelText: 'Search by name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                searched = value;
              });
            },
          ),
        ),

       
      ),
      body:
          isloading // show a loading indicator if users are not finished fetching
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : UserList(searched),
      floatingActionButton: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blue,
        child: IconButton(
          onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    UserFormPage(), // a floating action button to transfer user to add user page
              ));
              unfocus();
              },
          icon: Icon(Icons.add),
          color: Colors.white,
        ),
      ),
    );
  }
}
