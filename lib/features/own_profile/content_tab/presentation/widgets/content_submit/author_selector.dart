import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class AuthorSelector extends StatefulWidget {
  final List<String> selectedAuthors;
  final ValueChanged<List<String>> onAuthorsChanged;

  const AuthorSelector({
    super.key,
    required this.selectedAuthors,
    required this.onAuthorsChanged,
  });

  @override
  State<AuthorSelector> createState() => _AuthorSelectorState();
}

class _AuthorSelectorState extends State<AuthorSelector> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _availableAuthors = [
    'Johan Liebert',
    'Rizky Maulana',
    'Jean de La Fontaine',
    'Pep Guardiola',
    'Sir Alex Ferguson',
    'Dan Brown',
    'Doctor Strange',
    'Bruce Wayne',
    'Besok Besi Baja',
    'Prof. Andi Sucipto',
  ];
  List<String> _filteredAuthors = [];

  @override
  void initState() {
    super.initState();
    _filteredAuthors = List.from(_availableAuthors);
    _searchController.addListener(_filterAuthors);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterAuthors() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAuthors = _availableAuthors
          .where((author) => author.toLowerCase().contains(query))
          .toList();
    });
  }

  void _addAuthor(String author) {
    if (!widget.selectedAuthors.contains(author)) {
      final updatedAuthors = List<String>.from(widget.selectedAuthors)..add(author);
      widget.onAuthorsChanged(updatedAuthors);
    }
  }

  void _removeAuthor(String author) {
    final updatedAuthors = List<String>.from(widget.selectedAuthors)..remove(author);
    widget.onAuthorsChanged(updatedAuthors);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Field
        TextFormField(
          controller: _searchController,
          style: AppTextStyle.bodyText,
          decoration: InputDecoration(
            hintText: 'Cari nama pengarang...',
            hintStyle: AppTextStyle.caption,
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColor.componentColor),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: mq.size.width * 0.04,
              vertical: mq.size.height * 0.015,
            ),
          ),
        ),

        SizedBox(height: mq.size.height * 0.015),

        // Selected Authors Chips
        if (widget.selectedAuthors.isNotEmpty) ...[
          Text(
            'Pengarang Terpilih:',
            style: AppTextStyle.caption.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: mq.size.height * 0.008),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.selectedAuthors.map((author) {
              return Chip(
                label: Text(
                  author,
                  style: AppTextStyle.caption.copyWith(color: Colors.white),
                ),
                backgroundColor: AppColor.componentColor,
                deleteIcon: const Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.white,
                ),
                onDeleted: () => _removeAuthor(author),
              );
            }).toList(),
          ),
          SizedBox(height: mq.size.height * 0.015),
        ],

        // Available Authors List
        Container(
          height: mq.size.height * 0.2,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _filteredAuthors.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada pengarang ditemukan',
                    style: AppTextStyle.caption,
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _filteredAuthors.length,
                  itemBuilder: (context, index) {
                    final author = _filteredAuthors[index];
                    final isSelected = widget.selectedAuthors.contains(author);

                    return ListTile(
                      dense: true,
                      title: Text(
                        author,
                        style: AppTextStyle.bodyText.copyWith(
                          color: isSelected ? AppColor.componentColor : Colors.black,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle,
                              color: AppColor.componentColor,
                            )
                          : const Icon(
                              Icons.add_circle_outline,
                              color: Colors.grey,
                            ),
                      onTap: () {
                        if (isSelected) {
                          _removeAuthor(author);
                        } else {
                          _addAuthor(author);
                        }
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
