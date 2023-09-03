import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upmatev2/views/register_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final OutlineInputBorder _outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 1),
    borderRadius: BorderRadius.circular(12.0),
  );

  final RxBool _obscureText = true.obs;
  final RxBool _keepMeSignIn = false.obs;

  String email = "";
  String password = "";

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40.0),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign in to UpMate!",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Container(
                      width: 200.0, // Set the width of the container
                      height: 200.0, // Set the height of the container
                      decoration: BoxDecoration(
                        color: Colors.blue, // Set the background color of the container
                        borderRadius: BorderRadius.circular(10.0), // Add rounded corners
                      ),
                      child: Image.asset(
                        'assets/image/login.jpg', // Replace with your image asset path
                        fit: BoxFit.cover, // Set the image fit mode
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: _outlineBorder,
                      focusedBorder: _outlineBorder,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Obx(
                    () => TextField(
                      controller: passwordController,
                      obscureText: _obscureText.value,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: _outlineBorder,
                        focusedBorder: _outlineBorder,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _obscureText.toggle();
                          },
                          child: Icon(
                            _obscureText.value ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 104, 100, 97),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Text("Forgot Password"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            Center(
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: "Sign Up",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 104, 100, 97),
                            ),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle the click event here
                              Get.to(() => RegisterScreen());
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
