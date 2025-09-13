import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class ContentTypeBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> contentTypes;
  final String? selectedContentType;
  final Function(String) onContentTypeSelected;

  const ContentTypeBottomSheet({
    super.key,
    required this.contentTypes,
    this.selectedContentType,
    required this.onContentTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: contentTypes.length,
              itemBuilder: (context, index) {
                final contentType = contentTypes[index];
                final value = contentType['value'] as String?;
                final isSelected = selectedContentType != null && 
                                 selectedContentType == value;
                
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? contentType['color'] 
                          : contentType['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      contentType['icon'],
                      color: isSelected ? Colors.white : contentType['color'],
                      size: 20,
                    ),
                  ),
                  title: Text(
                    contentType['label'],
                    style: AppTextStyle.bodyText.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 14.sp,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: AppColor.componentColor)
                      : null,
                  onTap: () {
                    final value = contentType['value'] as String?;
                    if (value != null) {
                      onContentTypeSelected(value);
                      Navigator.pop(context);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Pilih Tipe Konten',
            style: AppTextStyle.cardTitle.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
