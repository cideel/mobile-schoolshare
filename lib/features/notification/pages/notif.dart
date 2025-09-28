import 'package:flutter/material.dart';
import 'package:schoolshare/models/notification_model.dart';
import '../../../core/constants/color.dart';
import '../data/notification_mock_data.dart';
import '../widgets/notification_header.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_empty_state.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({super.key});

  @override
  State<NotifPage> createState() => _NotifState();
}

class _NotifState extends State<NotifPage> with SingleTickerProviderStateMixin {
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NotificationHeader(
        
        onRefresh: _refreshNotifications,
      ),
      body: _buildNotificationList(screenSize),
    );
  }

  Widget _buildNotificationList(Size screenSize) {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_notifications.isEmpty) {
      return NotificationEmptyState(
        onRefresh: _refreshNotifications,
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshNotifications,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.01,
        ),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return NotificationCard(
            notification: notification,
            onTap: () => _onNotificationTap(notification),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.componentColor),
              strokeWidth: 3,
            ),
          ),
          SizedBox(height: screenSize.height * 0.03),
          Text(
            'Memuat notifikasi...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _loadNotifications() {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          // Use this to test empty state: NotificationMockData.getEmptyNotifications()
          // Use this for normal data: NotificationMockData.getSampleNotifications()
          _notifications = NotificationMockData.getSampleNotifications(); // Normal data
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _refreshNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (mounted) {
      setState(() {
        // In a real app, this would fetch from API
        // For demo, refresh will load actual data
        _notifications = NotificationMockData.getSampleNotifications();
      });
    }

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text('Notifikasi diperbarui')),
            ],
          ),
          backgroundColor: AppColor.componentColor,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  void _onNotificationTap(NotificationModel notification) {
    // Handle navigation based on notification type
    switch (notification.type) {
      case NotificationType.recommendation:
      case NotificationType.contentShared:
      case NotificationType.citation:
        // Navigate to content detail
        _showNotificationDetail(notification, 'Mengarah ke detail konten...');
        break;
      case NotificationType.forumComment:
      case NotificationType.forumReply:
        // Navigate to forum discussion
        _showNotificationDetail(notification, 'Membuka diskusi forum...');
        break;
      case NotificationType.contentPublished:
        // Show notification detail
        _showNotificationDetail(notification, 'Menampilkan detail notifikasi...');
        break;
    }
  }

  void _showNotificationDetail(NotificationModel notification, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(notification.typeIcon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColor.componentColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
