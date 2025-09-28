import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/models/models.dart';
import 'content_card.dart';
import 'content_list_header.dart';

class ContentListView extends StatelessWidget {
  final List<Publication> content;
  final VoidCallback onAddPressed;
  final Function(Publication) onContentTap;
  final Function(Publication)? onContentEdit;
  final Function(Publication)? onContentDelete;

  const ContentListView({
    super.key,
    required this.content,
    required this.onAddPressed,
    required this.onContentTap,
    this.onContentEdit,
    this.onContentDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContentListHeader(
          contentCount: content.length,
          onAddPressed: onAddPressed,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: content.length,
            itemBuilder: (context, index) => ContentCard(
              content: _publicationToMap(content[index]),
              onTap: () => onContentTap(content[index]),
              onEdit: onContentEdit != null 
                  ? () => onContentEdit!(content[index])
                  : null,
              onDelete: onContentDelete != null 
                  ? () => _showDeleteConfirmation(context, content[index])
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to convert Publication to Map for ContentCard
  Map<String, dynamic> _publicationToMap(Publication publication) {
    return {
      'title': publication.title,
      'type': publication.type,
      'typeLabel': publication.type,
      'category': publication.category,
      'authors': publication.authors,
      'publishedDate': _formatDate(publication.publishedDate),
      'dibaca': publication.readCount,
      'diunduh': publication.downloadCount,
      'dibagikan': 0, // Default value, can be added to Publication model later
      'rekomendasi': publication.likeCount,
    };
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _showDeleteConfirmation(BuildContext context, Publication publication) {
    final mq = MediaQuery.of(context);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          contentPadding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 8.h),
          titlePadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade600,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Hapus Konten',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apakah Anda yakin ingin menghapus konten berikut?',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        publication.type,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        publication.title,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Tindakan ini tidak dapat dibatalkan.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.red.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          actionsPadding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                minimumSize: Size(80.w, 44.h),
              ),
              child: Text(
                'Batal',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onContentDelete!(publication);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Konten "${publication.title}" berhasil dihapus',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.green.shade600,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    duration: const Duration(seconds: 3),
                    margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: 0,
                minimumSize: Size(80.w, 44.h),
              ),
              child: Text(
                'Hapus',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
