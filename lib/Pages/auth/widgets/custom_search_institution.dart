import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolshare/Services/institution_service.dart';

class CustomInstitutionSearchField extends StatefulWidget {
  final Function(int id, String name) onInstitutionSelected;

  const CustomInstitutionSearchField({
    super.key,
    required this.onInstitutionSelected,
  });

  @override
  State<CustomInstitutionSearchField> createState() =>
      _CustomInstitutionSearchFieldState();
}

class _CustomInstitutionSearchFieldState
    extends State<CustomInstitutionSearchField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<dynamic> allInstitutions = [];
  List<dynamic> filteredInstitutions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchInstitutions();
    _controller.addListener(_onSearchChanged);
  }

  Future<void> _fetchInstitutions() async {
    try {
      final institutions = await InstitutionService().getInstitutions();
      setState(() {
        allInstitutions = institutions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      // Menampilkan error di konsol untuk debugging
      debugPrint('ERROR: Gagal mengambil data institusi: $e');
    }
  }

  void _onSearchChanged() {
    final query = _controller.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredInstitutions = [];
      } else {
        filteredInstitutions = allInstitutions
            .where((inst) => inst['name'].toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _selectInstitution(dynamic institution) {
    _controller.text = institution['name'];
    widget.onInstitutionSelected(institution['id'], institution['name']);
    FocusScope.of(context).unfocus();
    setState(() => filteredInstitutions = []);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Column(
      children: [
        _buildInputField(mq),
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (filteredInstitutions.isNotEmpty)
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
                  title: Text(inst['name'], style: TextStyle(fontSize: 13.sp)),
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
        focusNode: _focusNode,
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
