import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static const String _fontFamily = 'Roboto';

  static TextStyle titleLarge = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
  );

  static TextStyle subtitle = TextStyle(
    fontSize: 14.sp,
    color: Colors.grey[800],
    fontFamily: _fontFamily,
  );

  static TextStyle caption = TextStyle(
    fontSize: 13.sp,
    color: Colors.grey[600],
    fontFamily: _fontFamily,
  );

  static TextStyle bodyText = TextStyle(
    fontSize: 13.sp,
    height: 1.5,
    color: Colors.black87,
    fontFamily: _fontFamily,
  );

  static TextStyle sectionTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15.sp,
    fontFamily: _fontFamily,
  );

  static TextStyle tabLabel = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle cardTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle badge = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontFamily: _fontFamily,
  );

  static TextStyle authorName = TextStyle(
    fontSize: 12.sp,
    color: Colors.grey[700],
    fontFamily: _fontFamily,
  );

  static TextStyle dateText = TextStyle(
    fontSize: 12.sp,
    color: Colors.grey[600],
    fontFamily: _fontFamily,
  );

  static TextStyle readCount = TextStyle(
    fontSize: 12.sp,
    color: Colors.grey[600],
    fontFamily: _fontFamily,
  );

  static TextStyle labelStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    fontFamily: _fontFamily,
  );
}

// Alias for backward compatibility
class AppTextStyles {
  static TextStyle get labelStyle => AppTextStyle.labelStyle;
}
