import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Services/profile_services.dart';
import 'package:schoolshare/Services/api_urls.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool _isLoading = true;
  String _institutionName = 'Nama Institusi';
  String _location = 'Lokasi';
  String _department = 'Departemen';
  String _positionName = 'Posisi';
  String? _institutionImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchAffiliationData();
  }

  Future<void> _fetchAffiliationData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) {
        throw Exception('Token otentikasi tidak ditemukan.');
      }

      final profileData = await ProfileServices().getProfile(token: token);

      if (profileData != null) {
        setState(() {
          _institutionName =
              profileData['institusi']?['name'] ?? 'Tidak Diketahui';
          _location =
              profileData['institusi']?['location'] ?? 'Tidak Diketahui';
          _department =
              profileData['institusi']?['departemen'] ?? 'Tidak Diketahui';
          _positionName = profileData['position']?['name'] ?? 'Tidak Diketahui';

          final relativeImageUrl =
              profileData['institusi']?['profile_institusi'];
          if (relativeImageUrl != null) {
            _institutionImageUrl = '${ApiUrls.storageUrl}/$relativeImageUrl';
          } else {
            _institutionImageUrl = null;
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      print('ERROR: Gagal memuat data afiliasi: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColor.componentColor),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 20),
              child: ListView(
                children: [
                  Text(
                    "Afiliasi",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: _institutionImageUrl != null
                            ? Image.network(
                                _institutionImageUrl!,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/example-logo-univ.png',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/example-logo-univ.png',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle(_institutionName),
                            _buildSubTitle("Lokasi"),
                            _buildSubValue(_location),
                            _buildSubTitle("Departemen"),
                            _buildSubValue(_department),
                            _buildSubTitle("Posisi"),
                            _buildSubValue(_positionName),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.grey, thickness: 0.5),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSubTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildSubValue(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
    );
  }
}
