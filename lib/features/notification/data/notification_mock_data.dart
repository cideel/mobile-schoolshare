import 'package:schoolshare/models/notification_model.dart';


class NotificationMockData {
  static List<NotificationModel> getSampleNotifications() {
    return [
      // Recent notifications
      NotificationModel(
        id: '1',
        title: 'Rekomendasi Baru',
        message: 'Dr. Sarah Wilson merekomendasikan "Metode Pembelajaran Aktif" untuk Anda',
        type: NotificationType.recommendation,
        priority: NotificationPriority.medium,
        senderName: 'Dr. Sarah Wilson',
        contentTitle: 'Metode Pembelajaran Aktif',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: false,
      ),

      NotificationModel(
        id: '2',
        title: 'Konten Dibagikan',
        message: 'Ahmad Fauzan membagikan penelitian Anda "AI dalam Pendidikan" ke grup Teknologi Pendidikan',
        type: NotificationType.contentShared,
        priority: NotificationPriority.low,
        senderName: 'Ahmad Fauzan',
        contentTitle: 'AI dalam Pendidikan',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        isRead: false,
      ),

      NotificationModel(
        id: '3',
        title: 'Komentar Baru',
        message: 'Prof. Maria Santos berkomentar di forum "Strategi Pembelajaran Online" yang Anda buat',
        type: NotificationType.forumComment,
        priority: NotificationPriority.medium,
        senderName: 'Prof. Maria Santos',
        contentTitle: 'Strategi Pembelajaran Online',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: false,
      ),

      NotificationModel(
        id: '4',
        title: 'Sitasi Baru',
        message: 'Penelitian Anda "Model Pembelajaran Hybrid" disitasi dalam paper terbaru oleh Universitas Indonesia',
        type: NotificationType.citation,
        priority: NotificationPriority.high,
        senderName: 'Universitas Indonesia',
        contentTitle: 'Model Pembelajaran Hybrid',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),

      NotificationModel(
        id: '5',
        title: 'Balasan Diskusi',
        message: 'Lisa Maharani membalas komentar Anda di diskusi "Evaluasi Pembelajaran"',
        type: NotificationType.forumReply,
        priority: NotificationPriority.medium,
        senderName: 'Lisa Maharani',
        contentTitle: 'Evaluasi Pembelajaran',
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        isRead: false,
      ),

      NotificationModel(
        id: '6',
        title: 'Konten Dipublikasikan',
        message: 'Konten "Rencana Pembelajaran Matematika" Anda telah berhasil dipublikasikan',
        type: NotificationType.contentPublished,
        priority: NotificationPriority.low,
        contentTitle: 'Rencana Pembelajaran Matematika',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: false,
      ),
    ];
  }

  static List<NotificationModel> getUnreadNotifications() {
    return getSampleNotifications();
  }

  static List<NotificationModel> getNotificationsByType(NotificationType type) {
    return getSampleNotifications().where((n) => n.type == type).toList();
  }

  static List<NotificationModel> getRecentNotifications() {
    final now = DateTime.now();
    return getSampleNotifications()
        .where((n) => now.difference(n.timestamp).inDays < 7)
        .toList();
  }

  // For testing empty state
  static List<NotificationModel> getEmptyNotifications() {
    return [];
  }
}
