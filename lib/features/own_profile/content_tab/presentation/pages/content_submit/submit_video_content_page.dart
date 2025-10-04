import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import '../../widgets/content_submit/content_type_bottom_sheet.dart';
import '../../widgets/content_submit/author_bottom_sheet.dart';
import '../../widgets/content_submit/form_components.dart';
import '../../../data/datasources/content_constants.dart';
import '../../../data/models/content_form_config.dart';
import '../../providers/content_utils_provider.dart';
import '../../controllers/content_submission_controller.dart';

class SubmitVideoContentPage extends StatefulWidget {
  const SubmitVideoContentPage({super.key});

  @override
  State<SubmitVideoContentPage> createState() => _SubmitVideoContentPageState();
}

class _SubmitVideoContentPageState extends State<SubmitVideoContentPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _videoUrlController = TextEditingController();
  
  late ContentSubmissionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ContentSubmissionController());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _videoUrlController.dispose();
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
              _buildVideoUrlSection(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildAuthorSection(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildMetadataSection(mq),
              SizedBox(height: mq.size.height * 0.04),
              _buildSubmitButton(mq),
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
        'Submit Video Content',
        style: AppTextStyle.cardTitle.copyWith(
          fontSize: 18.sp,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildTitleSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Judul Video'),
        SizedBox(height: mq.size.height * 0.012),
        FormComponents.buildTextField(
          controller: _titleController,
          hintText: 'Masukkan judul video yang menarik...',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Judul video wajib diisi';
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
        FormComponents.buildSectionTitle('Deskripsi Video'),
        SizedBox(height: mq.size.height * 0.012),
        FormComponents.buildTextField(
          controller: _descriptionController,
          hintText: 'Jelaskan isi dan tujuan video...',
          maxLines: 4,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Deskripsi video wajib diisi';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildVideoUrlSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('URL Video'),
        SizedBox(height: mq.size.height * 0.012),
        FormComponents.buildTextField(
          controller: _videoUrlController,
          hintText: 'https://www.youtube.com/watch?v=...',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'URL video wajib diisi';
            }
            if (!_isValidUrl(value)) {
              return 'Format URL tidak valid';
            }
            return null;
          },
        ),
        SizedBox(height: 8),
        Text(
          'Supported: YouTube, Vimeo, dan platform video lainnya',
          style: AppTextStyle.caption.copyWith(
            color: Colors.grey.shade600,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthorSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Pengarang/Pembuat'),
        SizedBox(height: mq.size.height * 0.012),
        GetX<ContentSubmissionController>(
          builder: (controller) {
            return FormComponents.buildSelector(
              onTap: _showAuthorBottomSheet,
              child: Row(
                children: [
                  Icon(Icons.people_outline, color: Colors.grey.shade600),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      controller.selectedAuthors.isEmpty
                          ? 'Pilih pengarang...'
                          : '${controller.selectedAuthors.length} pengarang dipilih',
                      style: controller.selectedAuthors.isEmpty
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
            );
          },
        ),
        GetX<ContentSubmissionController>(
          builder: (controller) {
            if (controller.selectedAuthors.isNotEmpty) {
              return Column(
                children: [
                  const SizedBox(height: 12),
                  _buildSelectedAuthorTags(controller.selectedAuthors),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildSelectedAuthorTags(List<Map<String, dynamic>> authors) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: authors.map((author) {
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
                author['name'] ?? 'Unknown',
                style: AppTextStyle.caption.copyWith(
                  color: AppColor.componentColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => _controller.removeAuthor(author['id']),
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

  Widget _buildMetadataSection(MediaQueryData mq) {
    final metadataFields = ContentFormConfig.getMetadataFields('Video');
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormComponents.buildSectionTitle('Informasi Tambahan (Opsional)'),
        SizedBox(height: mq.size.height * 0.012),
        
        // Duration field
        FormComponents.buildTextField(
          hintText: 'Durasi video (dalam menit)...',
          keyboardType: TextInputType.number,
          onChanged: (value) => _controller.updateMetadata('duration', value),
        ),
        SizedBox(height: mq.size.height * 0.02),
        
        // Language field
        FormComponents.buildTextField(
          hintText: 'Bahasa video (default: Indonesian)...',
          onChanged: (value) => _controller.updateMetadata('language', value.isEmpty ? 'Indonesian' : value),
        ),
        SizedBox(height: mq.size.height * 0.02),
        
        // Category field
        FormComponents.buildTextField(
          hintText: 'Kategori/topik video...',
          onChanged: (value) => _controller.updateMetadata('category', value),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(MediaQueryData mq) {
    return GetX<ContentSubmissionController>(
      builder: (controller) {
        return SizedBox(
          width: double.infinity,
          height: mq.size.height * 0.065,
          child: ElevatedButton(
            onPressed: controller.isSubmitting ? null : _submitContent,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.componentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: controller.isSubmitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Submit Video',
                    style: AppTextStyle.buttonText.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }

  // Event Handlers
  void _showAuthorBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AuthorBottomSheet(
        availableAuthors: _controller.availableAuthors.map((author) => {
          'id': author['id'] ?? '',
          'name': author['name'] ?? '',
          'institution': author['institution'] ?? '',
        }).toList(),
        selectedAuthors: _controller.selectedAuthors.map((author) => author['name'] ?? '').toList(),
        onAuthorsChanged: (selectedNames) {
          // Update selected authors based on names
          for (String name in selectedNames) {
            final author = _controller.availableAuthors.firstWhereOrNull(
              (a) => a['name'] == name,
            );
            if (author != null) {
              _controller.addAuthor(author);
            }
          }
        },
      ),
    );
  }

  Future<void> _submitContent() async {
    if (!_formKey.currentState!.validate()) return;

    if (_controller.selectedAuthors.isEmpty) {
      Get.snackbar(
        'Error',
        'Silakan pilih minimal satu pengarang',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final success = await _controller.submitVideoContent(
      name: _titleController.text,
      description: _descriptionController.text,
      videoUrl: _videoUrlController.text,
    );

    if (success) {
      Get.snackbar(
        'Success',
        'Video berhasil disubmit!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Navigator.pop(context);
    } else {
      Get.snackbar(
        'Error',
        _controller.error.isNotEmpty ? _controller.error : 'Gagal submit video',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}
