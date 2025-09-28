import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';

class NotificationEmptyState extends StatelessWidget {
  final VoidCallback? onRefresh;

  const NotificationEmptyState({
    super.key,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.1,
            vertical: screenSize.height * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Illustration Container
              Container(
                width: screenSize.width * 0.4,
                height: screenSize.width * 0.4,
                decoration: BoxDecoration(
                  color: AppColor.componentColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: screenSize.width * 0.16,
                  color: AppColor.componentColor.withOpacity(0.7),
                ),
              ),
              SizedBox(height: screenSize.height * 0.04),
              
              // Title
              Text(
                'Belum Ada Notifikasi',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenSize.height * 0.015),
              
              // Subtitle
              Text(
                'Notifikasi tentang aktivitas terbaru\nakan muncul di sini',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenSize.height * 0.04),
              
              // Action Button
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: screenSize.width * 0.6,
                ),
                child: ElevatedButton.icon(
                  onPressed: onRefresh,
                  icon: Icon(
                    Icons.refresh_rounded,
                    size: 20,
                  ),
                  label: Text(
                    'Refresh',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.componentColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              
              // Additional Info
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColor.componentColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColor.componentColor.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 16,
                      color: AppColor.componentColor,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Anda akan menerima notifikasi untuk rekomendasi, komentar, dan aktivitas lainnya',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColor.componentColor,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
