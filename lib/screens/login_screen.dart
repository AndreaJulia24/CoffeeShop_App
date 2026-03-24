import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/screens/home_screen.dart';
import 'package:coffee_shop/models/users.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBrown,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome back!",
                style: TextStyle(
                  color: primaryWhite,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Login to continue your coffee journey",
                style: TextStyle(
                  color: greyPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 50),
              //name
              TextField(
                controller: nameController,
                style: const TextStyle(color: primaryWhite),
                decoration: InputDecoration(
                  hintText: "Full name",
                  hintStyle: const TextStyle(color: greyPrimary),
                  filled: true,
                  fillColor: darkBrown,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.person, color: greyPrimary),
                ),
              ),
              const SizedBox(height: 20),
              //email
              TextField(
                controller: emailController,
                style: const TextStyle(color: primaryWhite),
                decoration: InputDecoration(
                  hintText: "Email address",
                  hintStyle: const TextStyle(color: greyPrimary),
                  filled: true,
                  fillColor: darkBrown,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.email, color: greyPrimary),
                ),
              ),
              const SizedBox(height: 20),
              //password
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: primaryWhite),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: const TextStyle(color: greyPrimary),
                  filled: true,
                  fillColor: darkBrown,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.lock, color: greyPrimary),
                ),
              ),
              const SizedBox(height: 40),
              //login button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryBrown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(16),
                    ),
                  ),
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      Users user = Users(
                        name: nameController.text,
                        email: emailController.text,
                        pasword: passwordController.text,
                        profileImage: '',
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(users: user),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: primaryWhite,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
