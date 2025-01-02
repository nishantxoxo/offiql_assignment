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

bool isloading = false;                                             //to be used to show loading indicator

class _HomeScreenState extends State<HomeScreen> {
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
            .fetchAndSet();                                                            // fucntion called to get all users from api
        setState(
          () {
            isloading = false;
          },
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("USERS"),
      ),
      body: isloading                                                 // show a loading indicator if users are not finished fetching
          ? Center(
              child: CircularProgressIndicator(),
            )
          : UserList(),
      floatingActionButton: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blue,
        child: IconButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserFormPage(),                         // a floating action button to transfer user to add user page
              )),
          icon: Icon(Icons.add),
          color: Colors.white,
        ),
      ),
    );
  }
}
