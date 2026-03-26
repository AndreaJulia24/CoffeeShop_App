import 'package:coffee_shop/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/models/users.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final Users users;

  const ProfileScreen({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>().currentUser;
    return Scaffold(
      backgroundColor: primaryBrown,
      appBar: AppBar(title: const Text("Profile"), backgroundColor: darkBrown),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: secondaryBrown,
              backgroundImage: ,
            ),
            SizedBox(height: 20),
            Text(
              users.name,
              style: const TextStyle(
                fontSize: 24,
                color: primaryWhite,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              users.email,
              style: const TextStyle(fontSize: 16, color: greyPrimary),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryRed),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              ),
              child: const Text(
                "Log out",
                style: TextStyle(color: primaryWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
