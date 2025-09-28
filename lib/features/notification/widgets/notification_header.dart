import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/color.dart';

class NotificationHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onRefresh;

  const NotificationHeader({
    super.key,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppBar(
      leading: Icon(
        Icons.notifications,
        color: Colors.white,
        size: 24,
      ),
      title: Text(
        'Notifikasi',
        style: theme.appBarTheme.titleTextStyle?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: false,
      elevation: 0,
      backgroundColor: AppColor.componentColor,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: theme.dividerColor.withOpacity(0.3),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
