import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import '../../widgets/content_submit/content_type_bottom_sheet.dart';
import '../../widgets/content_submit/author_bottom_sheet.dart';
import '../../widgets/content_submit/form_components.dart';
import '../../../data/datasources/content_constants.dart';
import '../../providers/content_utils_provider.dart';

class SubmitContentPage extends StatefulWidget {
  const SubmitContentPage({super.key});

  @override
  State<SubmitContentPage> createState() => _SubmitContentPageState();
}

class _SubmitContentPageState extends State<SubmitContentPage> {
  // Form controllers and state
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String? _selectedContentType;
  List<String> _selectedAuthors = [];
  List<String> _uploadedFiles = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(mq.size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleSection(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildDescriptionSection(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildContentTypeSection(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildAuthorSection(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildFileUploadSection(mq),
              SizedBox(height: mq.size.height * 0.04),
              FormComponents.buildSubmitButton(
                onPressed: _submitContent,
                mediaQuery: mq,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        'Submit Konten Baru',
        style: AppTextStyle.cardTitle.copyWith(
          fontSize: 18.sp,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }

  // Form Sections
  Widget _buildTitleSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Judul Konten'),
        SizedBox(height: mq.size.height * 0.012),
        FormComponents.buildTextField(
          controller: _titleController,
          hintText: 'Masukkan judul yang menarik dan deskriptif...',
          validator: ContentValidators.validateTitle,
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Deskripsi Konten'),
        SizedBox(height: mq.size.height * 0.012),
        FormComponents.buildTextField(
          controller: _descriptionController,
          hintText: 'Jelaskan detail konten yang akan Anda bagikan...',
          maxLines: 4,
          validator: ContentValidators.validateDescription,
        ),
      ],
    );
  }

  Widget _buildContentTypeSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Tipe Konten'),
        SizedBox(height: mq.size.height * 0.012),
        FormComponents.buildSelector(
          onTap: _showContentTypeBottomSheet,
          child: Row(
            children: [
              if (_selectedContentType != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ContentHelpers.getContentTypeColor(_selectedContentType),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    ContentHelpers.getContentTypeIcon(_selectedContentType),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    ContentHelpers.getContentTypeLabel(_selectedContentType),
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

  Widget _buildAuthorSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Pilih Pengarang'),
        SizedBox(height: mq.size.height * 0.012),
        FormComponents.buildSelector(
          onTap: _showAuthorBottomSheet,
          child: Row(
            children: [
              Icon(Icons.people_outline, color: Colors.grey.shade600),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _selectedAuthors.isEmpty
                      ? 'Pilih pengarang...'
                      : '${_selectedAuthors.length} pengarang dipilih',
                  style: _selectedAuthors.isEmpty
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
        if (_selectedAuthors.isNotEmpty) ...[
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
      children: _selectedAuthors.map((author) {
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
                onTap: () => _removeAuthor(author),
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

  Widget _buildFileUploadSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Upload File'),
        SizedBox(height: mq.size.height * 0.012),
        FormComponents.buildFileUploadArea(onTap: _addFile),
        if (_uploadedFiles.isNotEmpty) ...[
          SizedBox(height: mq.size.height * 0.015),
          FormComponents.buildUploadedFilesList(
            files: _uploadedFiles,
            onRemoveFile: _removeFile,
          ),
        ],
      ],
    );
  }

  // Actions and Event Handlers
  void _submitContent() {
    if (!_formKey.currentState!.validate()) return;

    if (!ContentValidators.validateContentType(_selectedContentType)) {
      ContentHelpers.showSnackBar(context, 'Silakan pilih tipe konten', isError: true);
      return;
    }

    if (!ContentValidators.validateAuthors(_selectedAuthors)) {
      ContentHelpers.showSnackBar(context, 'Silakan pilih minimal satu pengarang', isError: true);
      return;
    }

    ContentHelpers.showSnackBar(context, 'Konten berhasil disubmit!');
    _clearForm();
    Navigator.pop(context);
  }

  void _showContentTypeBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ContentTypeBottomSheet(
        contentTypes: ContentHelpers.getContentTypes(),
        selectedContentType: _selectedContentType,
        onContentTypeSelected: (contentType) {
          setState(() => _selectedContentType = contentType);
        },
      ),
    );
  }

  void _showAuthorBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AuthorBottomSheet(
        availableAuthors: ContentData.availableAuthors,
        selectedAuthors: _selectedAuthors,
        onAuthorsChanged: (authors) {
          setState(() => _selectedAuthors = authors);
        },
      ),
    );
  }

  void _addFile() {
    final fileName = 'document_${_uploadedFiles.length + 1}.pdf';
    setState(() => _uploadedFiles.add(fileName));
    ContentHelpers.showSnackBar(context, 'File berhasil ditambahkan!');
  }

  void _removeFile(String file) {
    setState(() => _uploadedFiles.remove(file));
  }

  void _removeAuthor(String author) {
    setState(() => _selectedAuthors.remove(author));
  }

  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedContentType = null;
      _selectedAuthors.clear();
      _uploadedFiles.clear();
    });
  }
}
