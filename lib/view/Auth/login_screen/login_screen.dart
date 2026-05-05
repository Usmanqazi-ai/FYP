import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_taking_application/controller/login_provider.dart';
import '../../../resources/constants/app_Colors.dart';
import '../../../resources/widgets/custom_text_fields.dart';
import '../../../resources/widgets/image_container.dart';
import '../../main_screen.dart';
import 'components/forget_button.dart';
import 'components/sign_up_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // Gradient background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2e4c37),
              Color(0xFF3f5c4a),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 38, color: Colors.white),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Sign in to continue to your stock taking application',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.1,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Inputs container with white background and rounded corners
                Consumer<LoginProvider>(
                  builder: (context, controller, child) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: loginFormKey,
                        child: Column(
                          children: [
                            CustomTextFields(
                              label: 'Email',
                              icon: Icons.email,
                              obscureText: false,
                              controller: controller.emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextFields(
                              label: 'Password',
                              icon: Icons.lock,
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.primaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ), controller: controller.passwordController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            // Forgot password
                            const ForgetButton(),
                            const SizedBox(height: 10),
                            // Login button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 6,
                                ),
                                onPressed: () async{
                                  if(loginFormKey.currentState!.validate()){
                                    final user = await controller.login(context);
                                    if (user != null) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (_) => const MainScreen()),
                                            (route) => false,
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),

                const SizedBox(height: 30),

                // Sign up prompt
                const SignUpButton(),
                const SizedBox(height: 30),
                // Your image bigger and with shadow
                ImageContainer(size: size),

                // Gradient Title
              ],
            ),
          ),
        ),
      ),
    );
  }
}
