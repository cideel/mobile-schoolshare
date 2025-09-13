import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class AuthorBottomSheet extends StatefulWidget {
  final List<Map<String, String>> availableAuthors;
  final List<String> selectedAuthors;
  final Function(List<String>) onAuthorsChanged;

  const AuthorBottomSheet({
    super.key,
    required this.availableAuthors,
    required this.selectedAuthors,
    required this.onAuthorsChanged,
  });

  @override
  State<AuthorBottomSheet> createState() => _AuthorBottomSheetState();
}

class _AuthorBottomSheetState extends State<AuthorBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredAuthors = [];
  List<String> _tempSelectedAuthors = [];

  @override
  void initState() {
    super.initState();
    _filteredAuthors = List.from(widget.availableAuthors);
    _tempSelectedAuthors = List.from(widget.selectedAuthors);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredAuthors.length,
              itemBuilder: (context, index) {
                final author = _filteredAuthors[index];
                final isSelected = _tempSelectedAuthors.contains(author['name']);
                
                return ListTile(
                  leading: _buildAuthorAvatar(author, isSelected),
                  title: Text(
                    author['name'] ?? 'Unknown Author',
                    style: AppTextStyle.bodyText.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 14.sp,
                    ),
                  ),
                  subtitle: Text(
                    author['title'] ?? 'Universitas Pendidikan Indonesia',
                    style: AppTextStyle.caption.copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 12.sp,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: AppColor.componentColor)
                      : Icon(Icons.add_circle_outline, color: Colors.grey.shade400),
                  onTap: () => _toggleAuthorSelection(author['name'] ?? ''),
                );
              },
            ),
          ),
          _buildFooter(),
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
            'Pilih Pengarang',
            style: AppTextStyle.cardTitle.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Anda dapat memilih lebih dari satu pengarang',
            style: AppTextStyle.caption.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          _buildSearchField(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      style: AppTextStyle.bodyText.copyWith(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: 'Cari pengarang...',
        hintStyle: AppTextStyle.caption.copyWith(color: Colors.grey.shade500),
        prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.componentColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onChanged: _filterAuthors,
    );
  }

  Widget _buildAuthorAvatar(Map<String, String> author, bool isSelected) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColor.componentColor : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Image.network(
          author['photo'] ?? '',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: isSelected ? AppColor.componentColor : Colors.grey.shade200,
              child: Icon(
                Icons.person,
                color: isSelected ? Colors.white : Colors.grey.shade600,
                size: 24,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey.shade200,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.componentColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${_tempSelectedAuthors.length} pengarang dipilih',
              style: AppTextStyle.bodyText.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onAuthorsChanged(_tempSelectedAuthors);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.componentColor,
            ),
            child: Text(
              'Selesai', 
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _filterAuthors(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredAuthors = List.from(widget.availableAuthors);
      } else {
        _filteredAuthors = widget.availableAuthors.where((author) {
          return (author['name'] ?? '').toLowerCase().contains(query.toLowerCase()) ||
                 (author['role'] ?? '').toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _toggleAuthorSelection(String authorName) {
    setState(() {
      if (_tempSelectedAuthors.contains(authorName)) {
        _tempSelectedAuthors.remove(authorName);
      } else {
        _tempSelectedAuthors.add(authorName);
      }
    });
  }
}
