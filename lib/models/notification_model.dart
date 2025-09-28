import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';

enum NotificationType {
  recommendation,
  contentShared,
  forumComment,
  forumReply,
  citation,
  contentPublished,
}

enum NotificationPriority {
  high,
  medium,
  low
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final NotificationPriority priority;
  final String? senderName;
  final String? senderAvatar;
  final String? contentTitle;
  final String? actionUrl;
  final DateTime timestamp;
  final bool isRead;
  final Map<String, dynamic>? metadata;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.priority,
    this.senderName,
    this.senderAvatar,
    this.contentTitle,
    this.actionUrl,
    required this.timestamp,
    this.isRead = false,
    this.metadata,
  });

  // Get icon for notification type
  IconData get typeIcon {
    switch (type) {
      case NotificationType.recommendation:
        return Icons.recommend;
      case NotificationType.contentShared:
        return Icons.share;
      case NotificationType.forumComment:
        return Icons.comment;
      case NotificationType.forumReply:
        return Icons.reply;
      case NotificationType.citation:
        return Icons.format_quote;
      case NotificationType.contentPublished:
        return Icons.publish;
    }
  }

  // Get color for notification type
  Color get typeColor {
    return AppColor.componentColor;
  }

  // Get formatted time
  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit yang lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari yang lalu';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  // Create copy with updated fields
  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    NotificationPriority? priority,
    String? senderName,
    String? senderAvatar,
    String? contentTitle,
    String? actionUrl,
    DateTime? timestamp,
    bool? isRead,
    Map<String, dynamic>? metadata,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      contentTitle: contentTitle ?? this.contentTitle,
      actionUrl: actionUrl ?? this.actionUrl,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      metadata: metadata ?? this.metadata,
    );
  }
}
