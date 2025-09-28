import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/content_constants.dart';

// Content validation utilities
class ContentValidators {
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Judul tidak boleh kosong';
    }
    if (value.trim().length < 3) {
      return 'Judul minimal 3 karakter';
    }
    if (value.trim().length > 100) {
      return 'Judul maksimal 100 karakter';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Deskripsi tidak boleh kosong';
    }
    if (value.trim().length < 10) {
      return 'Deskripsi minimal 10 karakter';
    }
    if (value.trim().length > 1000) {
      return 'Deskripsi maksimal 1000 karakter';
    }
    return null;
  }

  static bool validateContentType(String? contentType) {
    return contentType != null && 
           contentType.isNotEmpty && 
           ContentData.contentTypes.contains(contentType);
  }

  static bool validateAuthors(List<String> authors) {
    return authors.isNotEmpty;
  }
}

class ContentHelpers {
  static List<Map<String, dynamic>> getContentTypes() {
    return ContentData.contentTypes.map((type) => {
      'value': type,
      'label': type,
      'icon': getContentTypeIcon(type),
      'color': getContentTypeColor(type),
    }).toList();
  }

  static Color getContentTypeColor(String? contentType) {
    if (contentType == null || !ContentData.contentTypeConfig.containsKey(contentType)) {
      return Colors.grey;
    }
    final colorValue = ContentData.contentTypeConfig[contentType]!['color'];
    
    // Handle both Color object and int format
    if (colorValue is Color) {
      return colorValue;
    } else if (colorValue is int) {
      return Color(colorValue);
    }
    
    return Colors.grey;
  }

  static IconData getContentTypeIcon(String? contentType) {
    if (contentType == null || !ContentData.contentTypeConfig.containsKey(contentType)) {
      return Icons.description;
    }
    
    final iconName = ContentData.contentTypeConfig[contentType]!['icon'] as String;
    switch (iconName) {
      case 'gavel':
        return Icons.gavel;
      case 'menu_book':
        return Icons.menu_book;
      case 'assignment':
        return Icons.assignment;
      case 'assignment_ind':
        return Icons.assignment_ind;
      case 'science':
        return Icons.science;
      case 'lightbulb':
        return Icons.lightbulb;
      case 'psychology':
        return Icons.psychology;
      case 'model_training':
        return Icons.model_training;
      case 'videocam':
        return Icons.videocam;
      case 'slideshow':
        return Icons.slideshow;
      case 'book':
        return Icons.book;
      case 'article':
        return Icons.article;
      case 'image':
        return Icons.image;
      case 'description':
        return Icons.description;
      default:
        return Icons.description;
    }
  }

  static String getContentTypeLabel(String? contentType) {
    if (contentType == null || !ContentData.contentTypeConfig.containsKey(contentType)) {
      return 'Pilih Tipe';
    }
    return ContentData.contentTypeConfig[contentType]!['label'] as String;
  }

  static List<Map<String, String>> getAvailableAuthors() {
    return [
      {'name': 'Dr. Ananda Wijaya', 'institution': 'Universitas Indonesia'},
      {'name': 'Prof. Sari Indrawati', 'institution': 'Institut Teknologi Bandung'},
      {'name': 'Dr. Budi Santoso', 'institution': 'Universitas Gadjah Mada'},
      {'name': 'Dr. Maya Sari', 'institution': 'Universitas Brawijaya'},
      {'name': 'Prof. Ahmad Rahman', 'institution': 'Universitas Airlangga'},
      {'name': 'Dr. Rina Kusuma', 'institution': 'Institut Teknologi Sepuluh Nopember'},
      {'name': 'Dr. Hadi Pranoto', 'institution': 'Universitas Padjadjaran'},
      {'name': 'Prof. Lisa Maharani', 'institution': 'Universitas Diponegoro'},
    ];
  }

  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
