import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/core/services/user_content/content_submission_service.dart';

class SimpleVideoSubmitPage extends StatefulWidget {
  const SimpleVideoSubmitPage({super.key});

  @override
  State<SimpleVideoSubmitPage> createState() => _SimpleVideoSubmitPageState();
}

class _SimpleVideoSubmitPageState extends State<SimpleVideoSubmitPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _videoUrlController = TextEditingController();
  
  bool _isSubmitting = false;
  String _errorMessage = '';

  final ContentSubmissionService _submissionService = ContentSubmissionService();

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
      appBar: AppBar(
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
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(mq.size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_errorMessage.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
              ],
              
              _buildTitleSection(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildDescriptionSection(mq),
              SizedBox(height: mq.size.height * 0.03),
              _buildVideoUrlSection(mq),
              SizedBox(height: mq.size.height * 0.04),
              _buildSubmitButton(mq),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection(MediaQueryData mq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Judul Video *',
          style: AppTextStyle.cardTitle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: mq.size.height * 0.012),
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(
            hintText: 'Masukkan judul video yang menarik...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.componentColor),
            ),
          ),
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
        Text(
          'Deskripsi Video *',
          style: AppTextStyle.cardTitle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: mq.size.height * 0.012),
        TextFormField(
          controller: _descriptionController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Jelaskan isi dan tujuan video...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.componentColor),
            ),
          ),
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
        Text(
          'URL Video *',
          style: AppTextStyle.cardTitle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: mq.size.height * 0.012),
        TextFormField(
          controller: _videoUrlController,
          decoration: InputDecoration(
            hintText: 'https://www.youtube.com/watch?v=...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.componentColor),
            ),
          ),
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

  Widget _buildSubmitButton(MediaQueryData mq) {
    return SizedBox(
      width: double.infinity,
      height: mq.size.height * 0.065,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submitContent,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.componentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isSubmitting
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
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Future<void> _submitContent() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = '';
    });

    try {
      // For testing, use hardcoded author ID (current user)
      // In real implementation, this should be dynamic
      await _submissionService.submitVideoContent(
        name: _titleController.text,
        description: _descriptionController.text,
        videoUrl: _videoUrlController.text,
        authorIds: ['2'], // Hardcoded for testing - should be dynamic
        metadata: {
          'duration': '',
          'language': 'Indonesian',
          'category': 'Educational',
        },
      );

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Video berhasil disubmit!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() {
        _isSubmitting = false;
      });
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
