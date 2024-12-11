import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Widgets/custom_textfield.dart';

final emailErrorProvider = StateProvider<String?>((ref) => null);
final passwordErrorProvider = StateProvider<String?>((ref) => null);
final passwordVisibilityProvider = StateProvider<bool>((ref) => true);

class Login extends ConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final emailError = ref.watch(emailErrorProvider);
    final passwordError = ref.watch(passwordErrorProvider);
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);

    return SafeArea(
      child: ScreenUtilInit(
        designSize: const Size(375, 854),
        builder: (context, child) => Scaffold(
          backgroundColor: AppColor.bgColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              Padding(padding: EdgeInsets.symmetric(vertical: 5.h)),
              
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.h),

                      // Email Input
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            controller: emailController,
                            labelText: "Email",
                            icon: Icons.email_rounded,
                            obscureText: false,
                          ),
                          if (emailError != null)
                            Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: Text(
                                emailError,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                        ],
                      ),

                      SizedBox(height: 40.h),

                      // Password Input
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            controller: passwordController,
                            labelText: "Password",
                            icon: Icons.lock,
                            obscureText: isPasswordVisible,
                            suffixIcon: IconButton(
                              icon: Icon(isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                ref
                                    .read(passwordVisibilityProvider.notifier)
                                    .state = !isPasswordVisible;
                              },
                            ),
                          ),
                          if (passwordError != null)
                            Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: Text(
                                passwordError,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                        ],
                      ),

                      SizedBox(height: 15.h),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Lupa password?",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),

                      SizedBox(height: 25.h),

                      // Login Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(335.w, 55.h),
                          backgroundColor: AppColor.componentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        onPressed: () {
                          bool hasError = false;

                          // Email validation
                          if (emailController.text.isEmpty) {
                            ref.read(emailErrorProvider.notifier).state =
                                "Email tidak boleh kosong";
                            hasError = true;
                          } else if (!RegExp(r"^[^@]+@[^@]+\.[^@]+")
                              .hasMatch(emailController.text)) {
                            ref.read(emailErrorProvider.notifier).state =
                                "Format email tidak valid";
                            hasError = true;
                          } else {
                            ref.read(emailErrorProvider.notifier).state = null;
                          }

                          // Password validation
                          if (passwordController.text.isEmpty) {
                            ref.read(passwordErrorProvider.notifier).state =
                                "Password tidak boleh kosong";
                            hasError = true;
                          } else if (passwordController.text.length < 6) {
                            ref.read(passwordErrorProvider.notifier).state =
                                "Password minimal 6 karakter";
                            hasError = true;
                          } else {
                            ref.read(passwordErrorProvider.notifier).state =
                                null;
                          }

                          // Login Berhasil
                          if (!hasError) {
                    
                            print("Login berhasil");
                          }
                        },
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Sign Up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Belum punya akun? ",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          Text(
                            "Daftar",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              color: AppColor.componentColor,
                            ),
                          ),
                        ],
                      ),
                    ],
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

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 250.h,
      decoration: BoxDecoration(color: AppColor.componentColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SchoolShare",
            style: TextStyle(
              fontFamily: 'Shipori',
              color: Colors.white,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Menghubungkan pengetahuan tanpa batas",
            style: TextStyle(
              fontFamily: 'Shipori',
              color: Colors.white,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
