import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/autentikasi/add_institution.dart';
import 'package:schoolshare/Pages/autentikasi/widgets/custom_dropdown.dart' as dropdown;
import 'package:schoolshare/Pages/autentikasi/widgets/custom_search_institution.dart';
import 'package:schoolshare/Pages/autentikasi/widgets/custom_text_field.dart' as custom;
import 'package:schoolshare/Widgets/navbart.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agree = false;
  String? _selectedCategory;

  final List<String> _categories = ['SD/MI', 'SMP', 'SMA/SMK/MA', 'Perguruan Tinggi'];

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
            SizedBox(height: mq.size.height * 0.02),
            Center(
              child: Text(
                "Daftar Akun",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: mq.size.height * 0.03),

            const custom.CustomTextField(hintText: 'Nama Lengkap'),
            const custom.CustomTextField(hintText: 'Email'),

            dropdown.CustomDropdown(
              hint: 'Pilih Kategori',
              items: _categories,
              value: _selectedCategory,
              onChanged: (val) => setState(() => _selectedCategory = val),
            ),

            const CustomInstitutionSearchField(),

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: mq.size.height * 0.01),
                child: RichText(
                  text: TextSpan(
                    text: 'Tidak menemukan institusi? ',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    children: [
                      TextSpan(
                        text: 'Daftarkan di sini',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('CEK "Daftarkan di sini"');
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterInstitution(),));
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: mq.size.height * 0.01),

            custom.CustomTextField(
              hintText: 'Kata Sandi',
              isPassword: true,
              obscureText: _obscurePassword,
              toggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
            ),

            custom.CustomTextField(
              hintText: 'Konfirmasi Kata Sandi',
              isPassword: true,
              obscureText: _obscureConfirmPassword,
              toggleObscure: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),

            Row(
              children: [
                Checkbox(
                  value: _agree,
                  onChanged: (val) => setState(() => _agree = val ?? false),
                ),
                Expanded(
                  child: Text(
                    'Saya akan menyetujui syarat dan ketentuan',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),

            SizedBox(height: mq.size.height * 0.02),
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
                  Navigator.push(context,MaterialPageRoute(builder: (context) => NavBarScreen(),));
                },
                child: Text(
                  'DAFTAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: mq.size.height * 0.04),
          ],
        ),
      ),
    );
  }
}
