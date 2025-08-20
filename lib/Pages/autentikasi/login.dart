import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/autentikasi/register.dart';
import 'package:schoolshare/Pages/autentikasi/widgets/custom_text_field.dart' as custom;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: mq.size.height * 0.12),

            Center(
              child: Text(
                "SchoolShare",
                style: TextStyle(fontFamily:'Shipori',fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: mq.size.height * 0.01),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "Menghubungkan pengetahuan tanpa batas",
                style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w200),
              ),
            ),
             SizedBox(height: mq.size.height * 0.03),
      
            const custom.CustomTextField(hintText: 'Email'),
      
            custom.CustomTextField(
              hintText: 'Kata Sandi',
              isPassword: true,
              obscureText: _obscurePassword,
              toggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
      
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                },
                child: Text(
                  'Lupa kata sandi?',
                  style: TextStyle(fontSize: 12.sp, color: Colors.blue),
                ),
              ),
            ),
      
            SizedBox(height: mq.size.height * 0.01),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.componentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(mq.size.width * 0.02),
                  ),
                  padding: EdgeInsets.symmetric(vertical: mq.size.height * 0.018),
                ),
                onPressed: () {
                  print("Login ditekan");
                },
                child: Text(
                  'MASUK',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
      
            SizedBox(height: mq.size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun? ", style: TextStyle(fontSize: 12.sp)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Register(),));
                  },
                  child: Text(
                    "Daftar",
                    style: TextStyle(fontSize: 12.sp, color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: mq.size.height * 0.04),
          ],
        ),
      ),
    );
  }
}
