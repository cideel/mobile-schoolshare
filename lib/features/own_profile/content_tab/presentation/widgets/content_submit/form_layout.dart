import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/core/constants/text_styles.dart';

class FormLayout extends StatelessWidget {
  final String title;
  final List<Widget> formSections;
  final Widget actionButtons;
  final VoidCallback? onBackPressed;
  final Widget? floatingActionButton;
  final bool showBackButton;

  const FormLayout({
    super.key,
    required this.title,
    required this.formSections,
    required this.actionButtons,
    this.onBackPressed,
    this.floatingActionButton,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: showBackButton
            ? IconButton(
                onPressed: onBackPressed ?? () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              )
            : null,
        title: Text(
          title,
          style: AppTextStyle.cardTitle.copyWith(
            fontSize: 18.sp,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(mq.size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...formSections.map((section) => [
              section,
              SizedBox(height: mq.size.height * 0.03),
            ]).expand((widgets) => widgets),
            actionButtons,
            SizedBox(height: mq.size.height * 0.02),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

class FormSection extends StatelessWidget {
  final String title;
  final Widget content;
  final String? description;
  final bool isRequired;

  const FormSection({
    super.key,
    required this.title,
    required this.content,
    this.description,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppTextStyle.sectionTitle.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              Text(
                '*',
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
        if (description != null) ...[
          SizedBox(height: mq.size.height * 0.006),
          Text(
            description!,
            style: AppTextStyle.caption.copyWith(
              color: Colors.grey.shade600,
              fontSize: 12.sp,
            ),
          ),
        ],
        SizedBox(height: mq.size.height * 0.012),
        content,
      ],
    );
  }
}
