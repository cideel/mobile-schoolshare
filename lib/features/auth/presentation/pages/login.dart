import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import '../widgets/custom_text_field.dart' as custom;
import 'package:schoolshare/controllers/auth_controller.dart';
import 'register.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _LoginPageContent();
  }
}

class _LoginPageContent extends StatefulWidget {
  @override
  _LoginPageContentState createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<_LoginPageContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _hasNavigated = false; // Track navigation to prevent multiple calls
  
  // Lazy getter for AuthController
  AuthController get authController => Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Reset navigation flag for new login attempt
    _hasNavigated = false;

    authController.login(
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.white,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String userName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Selamat datang, $userName!',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.06;

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        return Obx(() {
          final authState = controller.authState;
          
          // Listen for authentication success
          if (authState.isAuthenticated && authState.user != null && !_hasNavigated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _hasNavigated = true;
              _showSuccessSnackBar(context, authState.user!.name);
              Get.offAllNamed('/home');
            });
          }
          
          // Listen for authentication errors
          if (authState.hasError && authState.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showErrorSnackBar(context, authState.errorMessage!);
              controller.clearError(); // Clear error after showing
            });
          }
      
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: mq.size.height * 0.12),

                Center(
                  child: Text(
                    "SchoolShare",
                    style: AppTextStyle.titleLarge.copyWith(
                      fontFamily: 'Shipori',
                      fontSize: 40.sp,
                    ),
                  ),
                ),
                SizedBox(height: mq.size.height * 0.01),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Menghubungkan pengetahuan tanpa batas",
                    style: AppTextStyle.subtitle.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(height: mq.size.height * 0.03),

                // Email field
                custom.CustomTextField(
                  controller: _emailController,
                  hintText: "Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),

                SizedBox(height: mq.size.height * 0.015),

                // Password field
                custom.CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  isPassword: true,
                  obscureText: _obscurePassword,
                  toggleObscure: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    if (value.length < 6) {
                      return 'Password minimal 6 karakter';
                    }
                    return null;
                  },
                ),

                SizedBox(height: mq.size.height * 0.015),

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: authState.isLoading ? null : () {
                      // TODO: Implement forgot password
                    },
                    child: Text(
                      "Lupa Password?",
                      style: AppTextStyle.bodyText.copyWith(
                        color: AppColor.componentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: mq.size.height * 0.01),

                // Login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.componentColor,
                      disabledBackgroundColor: AppColor.componentColor.withOpacity(0.6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(mq.size.width * 0.02),
                      ),
                      padding: EdgeInsets.symmetric(vertical: mq.size.height * 0.018),
                    ),
                    onPressed: authState.isLoading ? null : _handleLogin,
                    child: authState.isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "MASUK",
                            style: AppTextStyle.bodyText.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: mq.size.height * 0.03),

                // Register text
                Center(
                  child: GestureDetector(
                    onTap: authState.isLoading ? null : () {
                      Get.to(() => const Register());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Belum punya akun? ",
                        style: AppTextStyle.bodyText.copyWith(color: Colors.grey[600]),
                        children: [
                          TextSpan(
                            text: "Daftar",
                            style: AppTextStyle.bodyText.copyWith(
                              color: AppColor.componentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: mq.size.height * 0.04),
              ],
            ),
          ),
        ),
      );
    });
      }
    );
  }
}
