import 'package:coffee_shop/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/screens/home_screen.dart';
import 'package:coffee_shop/models/users.dart';
import 'package:provider/provider.dart';

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
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      //elerjuk a providert
                      final userProvider = context.read<UserProvider>();

                      final result = await userProvider.login(
                        emailController.text,
                        passwordController.text,
                      );

                      if (result && context.mounted) {
                        Users loggedInUser = Users.fromJson(userProvider.user!);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(users: loggedInUser),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Unsuccessful login.Check your server.",
                            ),
                            backgroundColor: primaryRed,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all the fields"),
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
              const SizedBox(height: 20),
              //register button
              TextButton(
                onPressed: () async {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    final userProvider = context.read<UserProvider>();

                    // Meghívjuk a logint
                    final result = await userProvider.login(
                      emailController.text,
                      passwordController.text,
                    );

                    if (result && context.mounted) {
                      Users loggedInUser = Users.fromJson(userProvider.user!);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(users: loggedInUser),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Login failed!"),
                          backgroundColor: primaryRed,
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(color: primaryWhite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
