import 'package:flutter/material.dart';
import 'package:offiql/providers/userProvider.dart';
import 'package:offiql/widgets/user_item.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Userprovider>(context).users;

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: users[index],
        child: UserItem(),
      ),
    );
  }
}
