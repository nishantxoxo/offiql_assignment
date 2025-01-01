import 'package:flutter/material.dart';
import 'package:offiql/models/userModel.dart';
import 'package:offiql/screens/user_detail_screen.dart';
import 'package:provider/provider.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final mediaQuery = MediaQuery.of(context); 

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => UserDetailScreen(user: user,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); 
      const end = Offset.zero;       
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ), 
        elevation: 4, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.width * 0.03, 
            vertical: mediaQuery.size.height * 0.01, 
          ),
          child: Text(
            user.name!,
            style: TextStyle(
              fontSize: mediaQuery.size.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
