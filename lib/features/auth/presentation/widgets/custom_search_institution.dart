import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInstitutionSearchField extends StatefulWidget {
  const CustomInstitutionSearchField({super.key});

  @override
  State<CustomInstitutionSearchField> createState() => _CustomInstitutionSearchFieldState();
}

class _CustomInstitutionSearchFieldState extends State<CustomInstitutionSearchField> {
  final TextEditingController _controller = TextEditingController();

  final List<String> allInstitutions = [
    'SDN Solo 1',
    'SDN Solo Barat',
    'SMP Negeri 2 Solo',
    'SMA Nasional Surakarta',
    'Universitas Sebelas Maret',
    'Universitas Muhammadiyah Surakarta',
    'SDN 1 Jepang Barat',
    'SDN 2 Rusia Tengah'
  ];

  List<String> filteredInstitutions = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _controller.text.toLowerCase();
    if (query.length < 2) {
      setState(() => filteredInstitutions.clear());
      return;
    }

    try {
      setState(() {
        filteredInstitutions = allInstitutions
            .where((inst) => inst.toLowerCase().contains(query))
            .toList();
      });
    } catch (e) {
      // Handle search error gracefully
      debugPrint('Search error: $e');
      setState(() => filteredInstitutions.clear());
    }
  }

  void _selectInstitution(String name) {
    _controller.text = name;
    FocusScope.of(context).unfocus();
    setState(() => filteredInstitutions.clear());
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Column(
      children: [
        _buildInputField(mq),
        if (filteredInstitutions.isNotEmpty)
          Container(
            margin: EdgeInsets.only(bottom: mq.size.height * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: BoxConstraints(
              maxHeight: mq.size.height * 0.25,
            ),
            child: ListView.builder(
              itemCount: filteredInstitutions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final inst = filteredInstitutions[index];
                return ListTile(
                  title: Text(inst, style: TextStyle(fontSize: 13.sp)),
                  onTap: () => _selectInstitution(inst),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildInputField(MediaQueryData mq) {
    return Container(
      margin: EdgeInsets.only(bottom: mq.size.height * 0.02),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Nama Institusi',
          hintStyle: TextStyle(fontSize: 13.sp),
          contentPadding: EdgeInsets.symmetric(
            horizontal: mq.size.width * 0.03,
            vertical: mq.size.height * 0.015,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
