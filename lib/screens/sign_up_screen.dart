import 'package:coffee_shop/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final birthDateController = TextEditingController(); // Új vezérlő a dátumnak

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  // Dátumválasztó függvény
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthDateController.text =
            "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBrown,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Create Account",
                  style: TextStyle(
                    color: primaryWhite,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 50),
                // Név mező
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: primaryWhite),
                  decoration: InputDecoration(
                    hintText: "Full Name",
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
                // Email mező
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
                // Születési dátum mező (Kattintható)
                TextField(
                  controller: birthDateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  style: const TextStyle(color: primaryWhite),
                  decoration: InputDecoration(
                    hintText: "Birth Date (YYYY-MM-DD)",
                    hintStyle: const TextStyle(color: greyPrimary),
                    filled: true,
                    fillColor: darkBrown,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.calendar_today,
                      color: greyPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Jelszó mező
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
                // Regisztrációs gomb
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
                          passwordController.text.isNotEmpty &&
                          nameController.text.isNotEmpty &&
                          birthDateController.text.isNotEmpty) {
                        final userProvider = context.read<UserProvider>();

                        final result = await userProvider.register(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          birthDateController.text,
                        );
                        if (result && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Account created! Please login."),
                              backgroundColor: Colors.green,
                            ),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Registration failed!"),
                              backgroundColor: primaryRed,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all fields"),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: primaryWhite,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(color: primaryWhite),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
