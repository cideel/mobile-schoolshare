import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/features/search/presentation/controllers/discussion_controller.dart';
import 'package:schoolshare/features/search/presentation/controllers/people_controller.dart';
import 'package:schoolshare/features/search/presentation/controllers/publication_controller.dart';
// nanti tambahin juga publication_controller & discussion_controller

enum SearchType { people, publication, discussion }

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final SearchType searchType;
  final VoidCallback? onClear;
  final ValueChanged<String>? onSearch;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.hintText = "Cari sesuatu...",
    required this.searchType,
    this.onClear,
    this.onSearch,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  Timer? _debounce;

  void _handleSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      switch (widget.searchType) {
        case SearchType.people:
          Get.find<PeopleController>().fetchItems(query: value);
          break;
        case SearchType.publication:
          Get.find<PublicationController>().fetchItems(query: value);
          break;
        case SearchType.discussion:
          if (Get.isRegistered<DiscussionController>()) {
            // ⬅️ Perubahan di sini
            Get.find<DiscussionController>().fetchItems(query: value);
          }
          break;
      }
      // trigger callback tambahan jika ada
      if (widget.onSearch != null) widget.onSearch!(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

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
            color: Colors.black.withOpacity(0.08),
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
                _handleSearch(value);
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: mq.size.height * 0.012),
              ),
            ),
          ),
          if (widget.controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                widget.controller.clear();
                setState(() {});
                widget.onClear?.call();
                _handleSearch(""); // reset search ketika clear
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
