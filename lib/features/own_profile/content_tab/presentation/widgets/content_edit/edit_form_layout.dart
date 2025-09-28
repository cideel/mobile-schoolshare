import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import '../content_submit/form_components.dart';
import '../../providers/content_utils_provider.dart';

class EditFormLayout extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String? selectedContentType;
  final List<String> selectedAuthors;
  final List<String> uploadedFiles;
  final VoidCallback onContentTypePressed;
  final VoidCallback onAuthorPressed;
  final VoidCallback onFileUploadPressed;
  final Function(String) onRemoveAuthor;
  final Function(String) onRemoveFile;
  final VoidCallback onUpdatePressed;
  final VoidCallback onDiscardPressed;
  final MediaQueryData mediaQuery;

  const EditFormLayout({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.selectedContentType,
    required this.selectedAuthors,
    required this.uploadedFiles,
    required this.onContentTypePressed,
    required this.onAuthorPressed,
    required this.onFileUploadPressed,
    required this.onRemoveAuthor,
    required this.onRemoveFile,
    required this.onUpdatePressed,
    required this.onDiscardPressed,
    required this.mediaQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleSection(),
            SizedBox(height: mediaQuery.size.height * 0.03),
            _buildDescriptionSection(),
            SizedBox(height: mediaQuery.size.height * 0.03),
            _buildContentTypeSection(),
            SizedBox(height: mediaQuery.size.height * 0.03),
            _buildAuthorSection(),
            SizedBox(height: mediaQuery.size.height * 0.03),
            _buildFileUploadSection(),
            SizedBox(height: mediaQuery.size.height * 0.04),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Judul Konten'),
        SizedBox(height: mediaQuery.size.height * 0.012),
        FormComponents.buildTextField(
          controller: titleController,
          hintText: 'Masukkan judul yang menarik dan deskriptif...',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Judul tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Deskripsi Konten'),
        SizedBox(height: mediaQuery.size.height * 0.012),
        FormComponents.buildTextField(
          controller: descriptionController,
          hintText: 'Jelaskan detail konten yang akan Anda bagikan...',
          maxLines: 4,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Deskripsi tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildContentTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Tipe Konten'),
        SizedBox(height: mediaQuery.size.height * 0.012),
        FormComponents.buildSelector(
          onTap: onContentTypePressed,
          child: Row(
            children: [
              if (selectedContentType != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ContentHelpers.getContentTypeColor(selectedContentType),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    ContentHelpers.getContentTypeIcon(selectedContentType),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    ContentHelpers.getContentTypeLabel(selectedContentType),
                    style: AppTextStyle.bodyText.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ] else ...[
                Icon(Icons.category_outlined, color: Colors.grey.shade600),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Pilih tipe konten...',
                    style: AppTextStyle.caption.copyWith(
                      color: Colors.grey.shade500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
              Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuthorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Pilih Pengarang'),
        SizedBox(height: mediaQuery.size.height * 0.012),
        FormComponents.buildSelector(
          onTap: onAuthorPressed,
          child: Row(
            children: [
              Icon(Icons.people_outline, color: Colors.grey.shade600),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  selectedAuthors.isEmpty
                      ? 'Pilih pengarang...'
                      : '${selectedAuthors.length} pengarang dipilih',
                  style: selectedAuthors.isEmpty
                      ? AppTextStyle.caption.copyWith(
                          color: Colors.grey.shade500,
                          fontSize: 14.sp,
                        )
                      : AppTextStyle.bodyText.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
            ],
          ),
        ),
        if (selectedAuthors.isNotEmpty) ...[
          const SizedBox(height: 12),
          _buildSelectedAuthorTags(),
        ],
      ],
    );
  }

  Widget _buildSelectedAuthorTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: selectedAuthors.map((author) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.componentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.componentColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                author,
                style: AppTextStyle.caption.copyWith(
                  color: AppColor.componentColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => onRemoveAuthor(author),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: AppColor.componentColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFileUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Upload File'),
        SizedBox(height: mediaQuery.size.height * 0.012),
        FormComponents.buildFileUploadArea(onTap: onFileUploadPressed),
        if (uploadedFiles.isNotEmpty) ...[
          SizedBox(height: mediaQuery.size.height * 0.015),
          FormComponents.buildUploadedFilesList(
            files: uploadedFiles,
            onRemoveFile: onRemoveFile,
          ),
        ],
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: onUpdatePressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.componentColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Perbarui Konten',
              style: AppTextStyle.bodyText.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: OutlinedButton(
            onPressed: onDiscardPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey.shade700,
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Batalkan Perubahan',
              style: AppTextStyle.bodyText.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
