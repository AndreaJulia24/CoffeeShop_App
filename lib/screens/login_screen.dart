import 'package:coffee_shop/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
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
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
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
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryBrown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: userProvider.isLoading
                          ? null
                          : () async {
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Fill all the fields."),
                                    backgroundColor: primaryRed,
                                  ),
                                );
                                return;
                              }

                              final result = await userProvider.login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );

                              if (!context.mounted) return;

                              if (result == true &&
                                  userProvider.currentUser != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                      users: userProvider.currentUser!,
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Incorrect email or password",
                                    ),
                                    backgroundColor: primaryRed,
                                  ),
                                );
                              }
                            },
                      child: userProvider.isLoading
                          ? const CircularProgressIndicator(
                              color: primaryWhite,
                              strokeWidth: 2,
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                color: primaryWhite,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
