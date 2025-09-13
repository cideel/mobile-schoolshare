import 'package:flutter/material.dart';
import '../../data/datasources/content_constants.dart';

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
    final colorInt = ContentData.contentTypeConfig[contentType]!['color'] as int;
    return Color(colorInt);
  }

  static IconData getContentTypeIcon(String? contentType) {
    if (contentType == null || !ContentData.contentTypeConfig.containsKey(contentType)) {
      return Icons.description;
    }
    
    final iconName = ContentData.contentTypeConfig[contentType]!['icon'] as String;
    switch (iconName) {
      case 'article':
        return Icons.article;
      case 'book':
        return Icons.book;
      case 'menu_book':
        return Icons.menu_book;
      case 'school':
        return Icons.school;
      case 'psychology':
        return Icons.psychology;
      case 'workspace_premium':
        return Icons.workspace_premium;
      case 'description':
        return Icons.description;
      case 'slideshow':
        return Icons.slideshow;
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
