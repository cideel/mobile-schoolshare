import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;
  final VoidCallback? onRemove;

  const SelectableChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColor.componentColor.withOpacity(0.1) 
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected 
                ? AppColor.componentColor 
                : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected 
                    ? AppColor.componentColor 
                    : Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppTextStyle.caption.copyWith(
                color: isSelected 
                    ? AppColor.componentColor 
                    : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 13.sp,
              ),
            ),
            if (onRemove != null && isSelected) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: AppColor.componentColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ChipSelector extends StatelessWidget {
  final List<String> items;
  final List<String> selectedItems;
  final Function(String) onItemToggle;
  final bool multiSelect;
  final String emptyText;

  const ChipSelector({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onItemToggle,
    this.multiSelect = true,
    this.emptyText = 'Tidak ada item dipilih',
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          emptyText,
          style: AppTextStyle.caption.copyWith(
            color: Colors.grey.shade500,
            fontSize: 13.sp,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedItems.contains(item);
        return SelectableChip(
          label: item,
          isSelected: isSelected,
          onTap: () => onItemToggle(item),
          onRemove: isSelected ? () => onItemToggle(item) : null,
        );
      }).toList(),
    );
  }
}
