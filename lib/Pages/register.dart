import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/login.dart';
import 'package:schoolshare/Widgets/custom_textfield.dart';

final emailErrorProvider = StateProvider<String?>((ref) => null);
final passwordErrorProvider = StateProvider<String?>((ref) => null);
final passwordVisibilityProvider = StateProvider<bool>((ref) => true);
final selectedSchoolProvider = StateProvider<String?>((ref) => null);

class Register extends ConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final emailError = ref.watch(emailErrorProvider);
    final passwordError = ref.watch(passwordErrorProvider);
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    final selectedSchool = ref.watch(selectedSchoolProvider);

    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(375, 854),
        builder: (context, child) => Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.bgColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.h)),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 35.h,
                      ),
                      CustomTextField(
                          controller: usernameController,
                          labelText: "Nama",
                          icon: Icons.person_2_rounded,
                          obscureText: false),
                      Padding(padding: EdgeInsets.symmetric(vertical: 20.h)),
                      CustomTextField(
                          controller: emailController,
                          labelText: "Email",
                          icon: Icons.email_rounded,
                          obscureText: false),
                      Padding(padding: EdgeInsets.symmetric(vertical: 20.h)),
                      CustomTextField(
                        controller: passwordController,
                        labelText: "Password",
                        icon: Icons.lock,
                        obscureText: isPasswordVisible,
                        suffixIcon: IconButton(
                            onPressed: () {
                              ref
                                  .read(passwordVisibilityProvider.notifier)
                                  .state = !isPasswordVisible;
                            },
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility)),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 20.h)),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5.r)),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text("Pilih sekolah"),
                          value: selectedSchool,
                          underline: SizedBox(),
                          items: [
                            "SMAN 1 Karanganyar",
                            "SMAN 2 Solo",
                            "SMK Gus Miftah",
                          ]
                              .map((school) => DropdownMenuItem(
                                    value: school,
                                    child: Text(school),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            ref.read(selectedSchoolProvider.notifier).state =
                                value;
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 15.h)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(335.w, 55.h),
                          backgroundColor: AppColor.componentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10.h)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sudah punya akun? ",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w100
                            ),
                          ),
                          Text("Masuk",style: TextStyle(fontFamily: 'Roboto',fontWeight:FontWeight.w600),)
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
