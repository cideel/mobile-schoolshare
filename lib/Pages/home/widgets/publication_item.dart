import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Config/text_styles.dart';
import 'package:schoolshare/Models/content.dart';
import 'package:schoolshare/Pages/home/widgets/action_icon.dart';
import 'package:schoolshare/Services/api_urls.dart';
import 'author_name.dart';
import 'package:collection/collection.dart';

class PublicationItem extends StatelessWidget {
  final Content content;
  final VoidCallback? onTap;

  const PublicationItem({super.key, required this.content, this.onTap});

  String _getFormattedDate(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);
      final DateFormat formatter = DateFormat('d MMMM yyyy', 'id_ID');
      return formatter.format(date);
    } catch (e) {
      return dateString; // Fallback jika format tanggal tidak valid
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    // Mendapatkan author utama dari objek user
    final mainAuthor = content.user;

    // Menentukan daftar pengguna yang akan ditampilkan (penulis atau penerbit)
    final List<dynamic>? displayUsers =
        content.type == 'book' ? content.publisherBookData : content.authors;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mq.size.height * 0.02),
        child: Column(
          children: [
            const Divider(thickness: 0.5, color: Colors.grey),
            SizedBox(height: mq.size.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: mq.size.width * 0.065, // Responsive avatar size
                    backgroundImage: mainAuthor?.profile != null
                        ? NetworkImage(
                            '${ApiUrls.storageUrl}/${mainAuthor!.profile!}')
                        : const AssetImage(
                                "assets/images/placeholder_profile.jpg")
                            as ImageProvider,
                  ),
                  SizedBox(width: mq.size.width * 0.025), // Responsive spacing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mainAuthor?.name ?? 'Anonim',
                          style:
                              AppTextStyle.cardTitle.copyWith(fontSize: 15.sp),
                        ),
                        Text(
                          mainAuthor?.institusi?.name ?? 'Tidak Ada Institusi',
                          style: AppTextStyle.caption.copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: mq.size.height * 0.015),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Colors.grey, width: 0.3),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                      mq.size.width * 0.03), // Responsive padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content.name,
                        style:
                            AppTextStyle.titleLarge.copyWith(fontSize: 18.sp),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: mq.size.height * 0.008),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: mq.size.width * 0.015,
                            vertical: mq.size.height * 0.004),
                        color: AppColor.componentColor,
                        child: Text(
                          content.type.isNotEmpty
                              ? '${content.type[0].toUpperCase()}${content.type.substring(1)}'
                              : '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: mq.size.height * 0.008),
                      Text(
                        _getFormattedDate(content.createdAt),
                        style: AppTextStyle.dateText,
                      ),
                      SizedBox(height: mq.size.height * 0.012),
                      // Logika untuk menampilkan penulis atau penerbit tambahan
                      if (displayUsers != null && displayUsers.isNotEmpty) ...[
                        if (displayUsers.length <= 2)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: displayUsers.map((user) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: AuthorName(
                                  img: user.profile != null
                                      ? NetworkImage(
                                          '${ApiUrls.storageUrl}/${user.profile!}')
                                      : const AssetImage(
                                              "assets/images/placeholder_profile.jpg")
                                          as ImageProvider,
                                  name: user.name,
                                ),
                              );
                            }).toList(),
                          )
                        else
                          Row(
                            children: [
                              SizedBox(
                                width: (mq.size.width * 0.065 * 2) +
                                    15.0, // Ukuran untuk 2 avatar + counter
                                height: mq.size.width * 0.065,
                                child: Stack(
                                  children: [
                                    // Avatar pengguna pertama
                                    Positioned(
                                      left: 0,
                                      child: CircleAvatar(
                                        radius: mq.size.width * 0.035,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: mq.size.width * 0.032,
                                          backgroundImage: displayUsers[0]
                                                      .profile !=
                                                  null
                                              ? NetworkImage(
                                                  '${ApiUrls.storageUrl}/${displayUsers[0].profile!}')
                                              : const AssetImage(
                                                      "assets/images/placeholder_profile.jpg")
                                                  as ImageProvider,
                                        ),
                                      ),
                                    ),
                                    // Avatar pengguna kedua
                                    Positioned(
                                      left: (mq.size.width * 0.065) * 0.5,
                                      child: CircleAvatar(
                                        radius: mq.size.width * 0.035,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: mq.size.width * 0.032,
                                          backgroundImage: displayUsers[1]
                                                      .profile !=
                                                  null
                                              ? NetworkImage(
                                                  '${ApiUrls.storageUrl}/${displayUsers[1].profile!}')
                                              : const AssetImage(
                                                      "assets/images/placeholder_profile.jpg")
                                                  as ImageProvider,
                                        ),
                                      ),
                                    ),
                                    // Avatar dengan jumlah sisa
                                    Positioned(
                                      left: (mq.size.width * 0.065) * 1,
                                      child: CircleAvatar(
                                        radius: mq.size.width * 0.035,
                                        backgroundColor:
                                            AppColor.componentColor,
                                        child: Text(
                                          '+${displayUsers.length - 2}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.sp),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                      SizedBox(height: mq.size.height * 0.012),
                      Row(
                        children: [
                          Text("${content.totalReadings} Dibaca",
                              style: AppTextStyle.readCount),
                          const Text("  •  "),
                          Text("${content.totalRecommendations} Rekomendasi",
                              style: AppTextStyle.readCount),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: mq.size.height * 0.015),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.05),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionIcon(icon: Icons.bookmark_outline, label: "Simpan"),
                  ActionIcon(
                      icon: Icons.thumb_up_outlined, label: "Rekomendasi"),
                  ActionIcon(icon: Icons.share_outlined, label: "Bagikan"),
                ],
              ),
            ),
            const Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}
