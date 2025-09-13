import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Config/text_styles.dart';
import 'package:schoolshare/Pages/auth/register.dart';
import 'package:schoolshare/Pages/auth/widgets/custom_text_field.dart'
    as custom;
import 'package:schoolshare/Services/auth_services.dart';
import 'package:schoolshare/Widgets/navbart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Email dan kata sandi tidak boleh kosong.')),
      );
      return;
    }

    try {
      final response = await AuthService().login(email, password);

      if (response['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', response['token']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavBarScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

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
            custom.CustomTextField(
              controller: _emailController,
              hintText: 'Email',
            ),
            custom.CustomTextField(
              controller: _passwordController,
              hintText: 'Kata Sandi',
              isPassword: true,
              obscureText: _obscurePassword,
              toggleObscure: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Lupa kata sandi?',
                  style: AppTextStyle.caption.copyWith(
                    color: Colors.blue,
                  ),
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
                  padding:
                      EdgeInsets.symmetric(vertical: mq.size.height * 0.018),
                ),
                onPressed: _handleLogin,
                child: Text(
                  'MASUK',
                  style: AppTextStyle.subtitle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: mq.size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun? ", style: AppTextStyle.caption),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                  child: Text(
                    "Daftar",
                    style: AppTextStyle.caption.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
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
