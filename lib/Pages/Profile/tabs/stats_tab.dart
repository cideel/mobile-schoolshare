import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schoolshare/Services/profile_services.dart';

class StatsTab extends StatefulWidget {
  const StatsTab({super.key});

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {
  bool _isLoading = true;
  String _riScore = '0';
  int _readDocs = 0;
  int _totalRecommendation = 0;
  int _totalSitasi = 0;

  @override
  void initState() {
    super.initState();
    _fetchStatsData();
  }

  Future<void> _fetchStatsData() async {
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
          _riScore = profileData['ri_score'] ?? '0';
          _readDocs = profileData['read_docs'] ?? 0;
          _totalRecommendation = profileData['total_recommendation'] ?? 0;
          _totalSitasi = profileData['total_sitasi'] ?? 0;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('ERROR: Gagal memuat data statistik: $e');
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
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Overview",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InfoBox(score: _riScore, title: "RI Score"),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InfoBox(
                            score: _readDocs.toString(), title: "Dibaca"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: InfoBox(
                            score: _totalRecommendation.toString(),
                            title: "Rekomendasi"),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InfoBox(
                            score: _totalSitasi.toString(), title: "Sitasi"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.componentColor),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Aksi jika diklik
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.trending_up,
                              color: AppColor.componentColor),
                          const SizedBox(width: 8),
                          Text(
                            "Lihat laporan status mingguan",
                            style: TextStyle(color: AppColor.componentColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 0.5, color: Colors.grey),
                ],
              ),
            ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String score;
  final String title;
  final VoidCallback? onInfoPressed;

  const InfoBox({
    super.key,
    required this.score,
    required this.title,
    this.onInfoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 133, 129, 129)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              score,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 17.sp),
                ),
                if (onInfoPressed != null)
                  IconButton(
                    icon: const Icon(Icons.info_outline, size: 18),
                    onPressed: onInfoPressed,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
