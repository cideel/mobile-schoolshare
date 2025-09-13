import 'package:flutter/material.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Config/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schoolshare/Services/profile_services.dart';
import 'package:schoolshare/Services/api_urls.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool _isLoading = true;
  String _name = 'Nama Pengguna';
  String _role = '';
  String _institution = '';
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        throw Exception('Token otentikasi tidak ditemukan.');
      }

      final profileData = await ProfileServices().getProfile(token: token);

      if (profileData != null) {
        setState(() {
          _name = profileData['name'] ?? 'Nama Pengguna';
          _role = profileData['position']?['name'] ?? 'Peran Tidak Diketahui';
          _institution =
              profileData['institusi']?['name'] ?? 'Institusi Tidak Diketahui';

          final relativeImageUrl = profileData['profile'];
          if (relativeImageUrl != null) {
            _profileImageUrl = '${ApiUrls.storageUrl}/$relativeImageUrl';
          } else {
            _profileImageUrl = null;
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      print('ERROR: Gagal memuat profil: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _isLoading = true; // Tampilkan loading saat mengunggah
      });
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('authToken');

        if (token != null) {
          final isUploaded = await ProfileServices().uploadProfilePicture(
            token: token,
            imagePath: image.path,
          );
          if (isUploaded) {
            // Jika berhasil diunggah, ambil ulang data profil untuk memperbarui UI
            await _fetchProfileData();
          }
        }
      } catch (e) {
        print('ERROR: Gagal mengunggah gambar profil: $e');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _pickProfileImage,
            child: _isLoading
                ? CircleAvatar(
                    radius: mq.size.width * 0.1,
                    backgroundColor: AppColor.componentColor,
                    child: const CircularProgressIndicator(
                      color: AppColor.bgColor,
                    ),
                  )
                : CircleAvatar(
                    radius: mq.size.width * 0.1,
                    backgroundColor: AppColor.componentColor,
                    backgroundImage: _profileImageUrl != null
                        ? NetworkImage(_profileImageUrl!)
                        : null,
                    child: _profileImageUrl == null
                        ? Icon(
                            Icons.person,
                            color: AppColor.bgColor,
                            size: mq.size.width * 0.08,
                          )
                        : null,
                  ),
          ),
          SizedBox(height: mq.size.height * 0.018),
          Text(
            _name,
            style: AppTextStyle.titleLarge,
          ),
          SizedBox(height: mq.size.height * 0.012),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: AppTextStyle.bodyText,
              children: [
                TextSpan(text: _role),
                const TextSpan(text: ' | '),
                TextSpan(text: _institution),
                const TextSpan(text: ' | '),
              ],
            ),
          ),
          SizedBox(height: mq.size.height * 0.024),
        ],
      ),
    );
  }
}
