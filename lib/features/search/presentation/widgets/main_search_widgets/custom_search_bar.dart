import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onChanged;
  final VoidCallback? onClear;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.hintText = "Cari sesuatu...",
    this.onChanged,
    this.onClear,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    
    return Container(
      height: mq.size.height * 0.048,
      margin: EdgeInsets.only(right: mq.size.width * 0.04),
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: Colors.grey[600],
            size: mq.size.width * 0.045,
          ),
          SizedBox(width: mq.size.width * 0.025),
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: (value) {
                setState(() {});
                widget.onChanged?.call();
              },
              style: AppTextStyle.bodyText.copyWith(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AppTextStyle.caption.copyWith(
                  color: Colors.grey[500],
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: mq.size.height * 0.012),
              ),
            ),
          ),
          if (widget.controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                widget.controller.clear();
                setState(() {});
                widget.onClear?.call();
              },
              child: Icon(
                Icons.clear_rounded,
                color: Colors.grey[500],
                size: mq.size.width * 0.04,
              ),
            ),
        ],
      ),
    );
  }
}
