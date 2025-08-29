import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Config/text_styles.dart';

class CreateDiscussionPage extends StatefulWidget {
  const CreateDiscussionPage({super.key});

  @override
  State<CreateDiscussionPage> createState() => _CreateDiscussionPageState();
}

class _CreateDiscussionPageState extends State<CreateDiscussionPage> {
  final _topicController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _popularTopics = [
    'Teknologi',
    'Pendidikan',
    'Penelitian',
    'AI & Machine Learning',
    'Flutter Development',
    'Data Science',
    'Web Development',
    'Mobile Development',
    'UI/UX Design',
    'Cybersecurity',
    // tergantung permintaan 
  ];

  @override
  void dispose() {
    _topicController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
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
          'Buat Diskusi Baru',
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
              // Topic Section
              Text(
                'Topik Diskusi',
                style: AppTextStyle.sectionTitle,
              ),
              SizedBox(height: mq.size.height * 0.012),
              
              // Topic Input
              TextFormField(
                controller: _topicController,
                style: AppTextStyle.bodyText,
                decoration: InputDecoration(
                  hintText: 'Masukkan topik diskusi',
                  hintStyle: AppTextStyle.caption,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Topik diskusi harus diisi';
                  }
                  return null;
                },
              ),

              SizedBox(height: mq.size.height * 0.015),

              // Popular Topics
              Text(
                'Topik Populer',
                style: AppTextStyle.caption.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: mq.size.height * 0.008),
              
              Wrap(
                spacing: mq.size.width * 0.02,
                runSpacing: mq.size.height * 0.008,
                children: _popularTopics.map((topic) => GestureDetector(
                  onTap: () {
                    _topicController.text = topic;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.size.width * 0.03,
                      vertical: mq.size.height * 0.006,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      topic,
                      style: AppTextStyle.caption.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                )).toList(),
              ),

              SizedBox(height: mq.size.height * 0.03),

              // Title Section
              Text(
                'Judul Diskusi',
                style: AppTextStyle.sectionTitle,
              ),
              SizedBox(height: mq.size.height * 0.012),
              
              TextFormField(
                controller: _titleController,
                style: AppTextStyle.bodyText,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Tulis judul diskusi yang menarik dan deskriptif',
                  hintStyle: AppTextStyle.caption,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul diskusi harus diisi';
                  }
                  if (value.trim().length < 10) {
                    return 'Judul diskusi minimal 10 karakter';
                  }
                  return null;
                },
              ),

              SizedBox(height: mq.size.height * 0.03),

              // Description Section
              Text(
                'Deskripsi Diskusi',
                style: AppTextStyle.sectionTitle,
              ),
              SizedBox(height: mq.size.height * 0.012),
              
              TextFormField(
                controller: _descriptionController,
                style: AppTextStyle.bodyText,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Jelaskan lebih detail tentang topik yang ingin didiskusikan...',
                  hintStyle: AppTextStyle.caption,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi diskusi harus diisi';
                  }
                  if (value.trim().length < 20) {
                    return 'Deskripsi diskusi minimal 20 karakter';
                  }
                  return null;
                },
              ),

              SizedBox(height: mq.size.height * 0.04),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitDiscussion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.componentColor,
                    minimumSize: Size(double.infinity, mq.size.height * 0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Buat Diskusi',
                    style: AppTextStyle.badge.copyWith(fontSize: 16.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitDiscussion() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Diskusi berhasil dibuat!',
            style: AppTextStyle.bodyText.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
      
      Navigator.pop(context);
    }
  }
}
