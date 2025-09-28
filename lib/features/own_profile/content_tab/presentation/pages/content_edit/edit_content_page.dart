import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolshare/models/publication.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import '../../widgets/content_edit/edit_form_header.dart';
import '../../widgets/content_submit/content_type_bottom_sheet.dart';
import '../../widgets/content_submit/author_bottom_sheet.dart';
import '../../widgets/content_submit/form_components.dart';
import '../../providers/content_utils_provider.dart';

class EditContentPage extends StatefulWidget {
  final Publication publication;

  const EditContentPage({
    super.key,
    required this.publication,
  });

  @override
  State<EditContentPage> createState() => _EditContentPageState();
}

class _EditContentPageState extends State<EditContentPage> {
  // Form controllers and state
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String? _selectedContentType;
  List<String> _selectedAuthors = [];
  List<String> _uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    // Initialize form with existing publication data
    _titleController.text = widget.publication.title;
    _descriptionController.text = widget.publication.description;
    _selectedContentType = widget.publication.type.isEmpty ? null : widget.publication.type;
    _selectedAuthors = List.from(widget.publication.authors);
    _uploadedFiles = [];
  }

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
          child: Column(
            children: [
              // Edit Form Header
              EditFormHeader(
                publication: widget.publication,
                mediaQuery: mq,
              ),
              
              // Edit Form Content (without Expanded wrapper)
              Padding(
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
                    _buildActionButtons(mq),
                    SizedBox(height: mq.size.height * 0.02), // Bottom padding
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        'Edit Konten',
        style: AppTextStyle.cardTitle.copyWith(
          fontSize: 18.sp,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }

  void _handleContentTypeSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ContentTypeBottomSheet(
        contentTypes: ContentHelpers.getContentTypes(),
        selectedContentType: _selectedContentType,
        onContentTypeSelected: (contentType) {
          setState(() {
            _selectedContentType = contentType;
          });
        },
      ),
    );
  }

  void _handleAuthorSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AuthorBottomSheet(
        availableAuthors: ContentHelpers.getAvailableAuthors(),
        selectedAuthors: _selectedAuthors,
        onAuthorsChanged: (authors) {
          setState(() {
            _selectedAuthors = authors;
          });
        },
      ),
    );
  }

  void _handleFileUpload() {
    // Simulate file upload
    setState(() {
      _uploadedFiles.add('dokumen_${_uploadedFiles.length + 1}.pdf');
    });
  }

  void _handleRemoveAuthor(String author) {
    setState(() {
      _selectedAuthors.remove(author);
    });
  }

  void _handleRemoveFile(String fileName) {
    setState(() {
      _uploadedFiles.remove(fileName);
    });
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      _showSaveConfirmationDialog();
    }
  }

  void _handleCancel() {
    Get.back();
  }

  // Form section builders
  Widget _buildTitleSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Judul Konten'),
        SizedBox(height: mq.size.height * 0.012),
        FormComponents.buildTextField(
          controller: _titleController,
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

  Widget _buildContentTypeSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Tipe Konten'),
        SizedBox(height: mq.size.height * 0.012),
        GestureDetector(
          onTap: _handleContentTypeSelection,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(mq.size.width * 0.04),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(mq.size.width * 0.02),
            ),
            child: Row(
              children: [
                if (_selectedContentType != null) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.size.width * 0.03,
                      vertical: mq.size.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: ContentHelpers.getContentTypeColor(_selectedContentType),
                      borderRadius: BorderRadius.circular(mq.size.width * 0.015),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          ContentHelpers.getContentTypeIcon(_selectedContentType),
                          color: Colors.white,
                          size: mq.size.width * 0.04,
                        ),
                        SizedBox(width: mq.size.width * 0.02),
                        Text(
                          ContentHelpers.getContentTypeLabel(_selectedContentType),
                          style: AppTextStyle.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Text(
                    'Pilih tipe konten...',
                    style: AppTextStyle.caption.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
                const Spacer(),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[600],
                ),
              ],
            ),
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
        GestureDetector(
          onTap: _handleAuthorSelection,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(mq.size.width * 0.04),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(mq.size.width * 0.02),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedAuthors.isEmpty) ...[
                  Text(
                    'Pilih pengarang...',
                    style: AppTextStyle.caption.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ] else ...[
                  Wrap(
                    spacing: mq.size.width * 0.02,
                    runSpacing: mq.size.height * 0.01,
                    children: _selectedAuthors.map((author) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: mq.size.width * 0.03,
                          vertical: mq.size.height * 0.008,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.componentColor,
                          borderRadius: BorderRadius.circular(mq.size.width * 0.015),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              author,
                              style: AppTextStyle.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: mq.size.width * 0.015),
                            GestureDetector(
                              onTap: () => _handleRemoveAuthor(author),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: mq.size.width * 0.035,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
                SizedBox(height: mq.size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileUploadSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Upload File'),
        SizedBox(height: mq.size.height * 0.012),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(mq.size.width * 0.06),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(mq.size.width * 0.02),
          ),
          child: Column(
            children: [
              if (_uploadedFiles.isEmpty) ...[
                Icon(
                  Icons.cloud_upload_outlined,
                  size: mq.size.width * 0.12,
                  color: Colors.grey[400],
                ),
                SizedBox(height: mq.size.height * 0.02),
                Text(
                  'Klik untuk upload file',
                  style: AppTextStyle.caption.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: mq.size.height * 0.008),
                Text(
                  'Format yang didukung: PDF, DOC, DOCX, PPT',
                  style: AppTextStyle.caption.copyWith(
                    color: Colors.grey[500],
                    fontSize: mq.size.width * 0.03,
                  ),
                ),
              ] else ...[
                ...(_uploadedFiles.map((file) => Container(
                      margin: EdgeInsets.only(bottom: mq.size.height * 0.01),
                      padding: EdgeInsets.all(mq.size.width * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(mq.size.width * 0.02),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.insert_drive_file,
                            color: AppColor.componentColor,
                            size: mq.size.width * 0.05,
                          ),
                          SizedBox(width: mq.size.width * 0.03),
                          Expanded(
                            child: Text(
                              file,
                              style: AppTextStyle.caption.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _handleRemoveFile(file),
                            child: Icon(
                              Icons.close,
                              color: Colors.grey[600],
                              size: mq.size.width * 0.05,
                            ),
                          ),
                        ],
                      ),
                    )).toList()),
                SizedBox(height: mq.size.height * 0.02),
                GestureDetector(
                  onTap: _handleFileUpload,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: mq.size.height * 0.015,
                      horizontal: mq.size.width * 0.04,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.componentColor),
                      borderRadius: BorderRadius.circular(mq.size.width * 0.02),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColor.componentColor,
                          size: mq.size.width * 0.04,
                        ),
                        SizedBox(width: mq.size.width * 0.02),
                        Text(
                          'Tambah File Lain',
                          style: AppTextStyle.caption.copyWith(
                            color: AppColor.componentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(MediaQueryData mq) {
    return Column(
      children: [
        // Update Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _handleSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.componentColor,
              padding: EdgeInsets.symmetric(
                vertical: mq.size.height * 0.018,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(mq.size.width * 0.02),
              ),
            ),
            child: Text(
              'Update Konten',
              style: AppTextStyle.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: mq.size.width * 0.04,
              ),
            ),
          ),
        ),
        
        SizedBox(height: mq.size.height * 0.02),
        
        // Discard Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _handleCancel,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade400),
              padding: EdgeInsets.symmetric(
                vertical: mq.size.height * 0.018,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(mq.size.width * 0.02),
              ),
            ),
            child: Text(
              'Batal Edit',
              style: AppTextStyle.caption.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
                fontSize: mq.size.width * 0.04,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSaveConfirmationDialog() {
    final mq = MediaQuery.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(mq.size.width * 0.04),
        ),
        title: Text(
          'Simpan Perubahan',
          style: AppTextStyle.cardTitle.copyWith(
            fontSize: mq.size.width * 0.045,
          ),
        ),
        content: Text(
          'Apakah Anda yakin ingin menyimpan perubahan pada konten ini?',
          style: AppTextStyle.bodyText.copyWith(
            fontSize: mq.size.width * 0.035,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Batal',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: mq.size.width * 0.035,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performSave();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.componentColor,
            ),
            child: Text(
              'Simpan',
              style: TextStyle(
                color: Colors.white,
                fontSize: mq.size.width * 0.035,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _performSave() {
    ContentHelpers.showSnackBar(
      context,
      'Konten berhasil diperbarui',
    );
    
    Future.delayed(const Duration(milliseconds: 1500), () {
      Get.back();
    });
  }
}
