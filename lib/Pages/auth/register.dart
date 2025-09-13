import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/auth/add_institution.dart';
import 'package:schoolshare/Pages/auth/widgets/custom_dropdown.dart'
    as dropdown;
import 'package:schoolshare/Pages/auth/widgets/custom_search_institution.dart';
import 'package:schoolshare/Pages/auth/widgets/custom_text_field.dart'
    as custom;
import 'package:schoolshare/Services/auth_services.dart';
import 'package:schoolshare/Widgets/navbart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agree = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _positionController =
      TextEditingController(); // Menambahkan controller untuk posisi

  String? _selectedCategory;
  int? _selectedInstitutionId;
  String? _selectedInstitutionName;

  final List<String> _categories = [
    'SD/MI',
    'SMP',
    'SMA/SMK/MA',
    'Perguruan Tinggi'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _positionController.dispose(); // Membuang controller posisi
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konfirmasi kata sandi tidak cocok.')),
      );
      return;
    }

    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Anda harus menyetujui syarat dan ketentuan.')),
      );
      return;
    }

    if (_selectedInstitutionId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda harus memilih institusi.')),
      );
      return;
    }

    if (_positionController.text.trim().isEmpty) {
      // Menambahkan validasi untuk posisi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda harus memasukkan posisi.')),
      );
      return;
    }

    try {
      final response = await AuthService().register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        institusiId: _selectedInstitutionId!,
        position: _positionController.text.trim(), // Mengirimkan posisi
        password: _passwordController.text.trim(),
        passwordConfirmation: _confirmPasswordController.text.trim(),
      );

      if (response['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', response['token']);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi berhasil!')),
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavBarScreen(),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(response['message'] ?? 'Registrasi gagal. Coba lagi.')),
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
            SizedBox(height: mq.size.height * 0.02),
            Center(
              child: Text(
                "Daftar Akun",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: mq.size.height * 0.03),
            custom.CustomTextField(
              controller: _nameController,
              hintText: 'Nama Lengkap',
            ),
            custom.CustomTextField(
              controller: _emailController,
              hintText: 'Email',
            ),
            custom.CustomTextField(
              controller: _phoneController,
              hintText: 'Nomor Telepon',
            ),
            dropdown.CustomDropdown(
              hint: 'Pilih Kategori',
              items: _categories,
              value: _selectedCategory,
              onChanged: (val) => setState(() => _selectedCategory = val),
            ),
            CustomInstitutionSearchField(
              onInstitutionSelected: (id, name) {
                setState(() {
                  _selectedInstitutionId = id;
                  _selectedInstitutionName = name;
                });
              },
            ),
            // Inputan baru untuk posisi
            custom.CustomTextField(
              controller: _positionController,
              hintText: 'Posisi Anda',
            ),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterInstitution(),
                                ));
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: mq.size.height * 0.01),
            custom.CustomTextField(
              controller: _passwordController,
              hintText: 'Kata Sandi',
              isPassword: true,
              obscureText: _obscurePassword,
              toggleObscure: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
            custom.CustomTextField(
              controller: _confirmPasswordController,
              hintText: 'Konfirmasi Kata Sandi',
              isPassword: true,
              obscureText: _obscureConfirmPassword,
              toggleObscure: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword),
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
                  padding:
                      EdgeInsets.symmetric(vertical: mq.size.height * 0.018),
                ),
                onPressed: _handleRegister,
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
