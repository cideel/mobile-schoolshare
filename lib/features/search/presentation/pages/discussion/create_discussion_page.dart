// lib/features/discussion/presentation/pages/create_discussion_page.dart (FINAL REVISION)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/core/services/forum/forum_service.dart';
import 'package:schoolshare/data/repositories/create_forum_repository_impl.dart';
import 'package:schoolshare/features/search/presentation/controllers/create_discussion_controller.dart';
import '../../widgets/discussion_widgets/discussion_form_field.dart';
import '../../widgets/discussion_widgets/popular_topics_widget.dart';
import '../../widgets/discussion_widgets/submit_discussion_button.dart';


class CreateDiscussionPage extends StatefulWidget {
  const CreateDiscussionPage({super.key});

  @override
  State<CreateDiscussionPage> createState() => _CreateDiscussionPageState();
}

class _CreateDiscussionPageState extends State<CreateDiscussionPage> {
  late final CreateDiscussionController _controller;

  // Topic sekarang diketik manual atau dipilih, jadi harus punya controller
  final _topicController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      CreateDiscussionController(
        repository: CreateForumRepositoryImpl(service: ForumService()),
      ),
    );

    // Sinkronisasi input topic dengan selectedCategory (untuk tampilan awal)
    _topicController.addListener(_clearSelectedCategoryOnType);
  }

  void _clearSelectedCategoryOnType() {
    // Kosongkan selectedCategory jika pengguna mulai mengetik
    if (_controller.selectedCategory.value != null &&
        _controller.selectedCategory.value!.name != _topicController.text) {
      _controller.selectedCategory.value = null;
    }
  }

  @override
  void dispose() {
    _topicController.removeListener(_clearSelectedCategoryOnType);
    _topicController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    Get.delete<CreateDiscussionController>();
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
      body: Obx(
        () => Form(
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
                  hintText:
                      'Masukkan topik diskusi atau pilih dari yang populer',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Topik diskusi harus diisi';
                    }
                    return null;
                  },
                  errorText: _controller.errorMessage.value.contains('topik')
                      ? _controller.errorMessage.value
                      : null,
                ),

                SizedBox(height: mq.size.height * 0.015),

                // Popular Topics
                _buildPopularTopicsWidget(mq),

                SizedBox(height: mq.size.height * 0.03),

                // Title Section (tetap sama)
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

                // Description Section (tetap sama)
                DiscussionFormField(
                  label: 'Deskripsi Diskusi',
                  controller: _descriptionController,
                  hintText:
                      'Jelaskan lebih detail tentang topik yang ingin didiskusikan...',
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
                  isLoading: _controller.isLoading.value,
                ),

                // Tampilkan error umum
                if (_controller.errorMessage.isNotEmpty &&
                    !_controller.errorMessage.value.contains('topik'))
                  Padding(
                    padding: EdgeInsets.only(top: mq.size.height * 0.01),
                    child: Text(
                      'Gagal: ${_controller.errorMessage.value}',
                      style: AppTextStyle.caption.copyWith(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopularTopicsWidget(MediaQueryData mq) {
    if (_controller.isCategoryLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    final topicNames = _controller.categories.map((c) => c.name).toList();

    return PopularTopicsWidget(
      topics: topicNames,
      onTopicSelected: (topicName) {
        // Ketika topik populer dipilih, set nilai di controller dan text field
        _topicController.text = topicName;
        // Kita perlu mencari objek kategori lengkap untuk di-set di controller
        final selected = _controller.categories
            .firstWhereOrNull((cat) => cat.name == topicName);
        if (selected != null) {
          _controller.selectExistingCategory(selected);
        }
        _formKey.currentState?.validate();
      },
    );
  }

  void _submitDiscussion() async {
    // Validasi form lokal
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Clear error message sebelum submit
    _controller.errorMessage.value = '';

    final newForum = await _controller.submitForum(
      title: _titleController.text.trim(),
      body: _descriptionController.text.trim(),
      topicText: _topicController.text.trim(), // Kirim teks topik
    );

    if (newForum != null) {
      // Sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Diskusi "${newForum.title}" berhasil dibuat!',
            style: AppTextStyle.bodyText.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else if (_controller.errorMessage.isNotEmpty) {
      // Gagal, error sudah ditangani dan ditampilkan di Obx atau SnackBar di atas.
    }
  }
}
