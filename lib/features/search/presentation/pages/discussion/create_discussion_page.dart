import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import '../../widgets/discussion_widgets/discussion_form_field.dart';
import '../../widgets/discussion_widgets/popular_topics_widget.dart';
import '../../widgets/discussion_widgets/submit_discussion_button.dart';

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
        backgroundColor: AppColor.componentColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Buat Diskusi Baru',
          style: AppTextStyle.cardTitle.copyWith(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold
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
              DiscussionFormField(
                label: 'Topik Diskusi',
                controller: _topicController,
                hintText: 'Masukkan topik diskusi',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Topik diskusi harus diisi';
                  }
                  return null;
                },
              ),

              SizedBox(height: mq.size.height * 0.015),

              // Popular Topics
              PopularTopicsWidget(
                topics: _popularTopics,
                onTopicSelected: (topic) {
                  _topicController.text = topic;
                },
              ),

              SizedBox(height: mq.size.height * 0.03),

              // Title Section
              DiscussionFormField(
                label: 'Judul Diskusi',
                controller: _titleController,
                hintText: 'Tulis judul diskusi yang menarik dan deskriptif',
                maxLines: 2,
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
              DiscussionFormField(
                label: 'Deskripsi Diskusi',
                controller: _descriptionController,
                hintText: 'Jelaskan lebih detail tentang topik yang ingin didiskusikan...',
                maxLines: 5,
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

              SubmitDiscussionButton(
                onPressed: _submitDiscussion,
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
