import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolshare/core/services/api_urls.dart';
import 'package:schoolshare/data/models/institution_model.dart';

typedef InstitutionSelectedCallback = void Function(int id, String name);

class CustomInstitutionSearchField extends StatefulWidget {
  final InstitutionSelectedCallback onInstitutionSelected;
  final String selectedName;

  const CustomInstitutionSearchField({
    super.key,
    required this.onInstitutionSelected,
    required this.selectedName,
  });

  @override
  State<CustomInstitutionSearchField> createState() =>
      _CustomInstitutionSearchFieldState();
}

class _CustomInstitutionSearchFieldState
    extends State<CustomInstitutionSearchField> {
  // State untuk data API
  List<Institution> _institutions = [];
  bool _isLoading = true; // Set true agar loading muncul saat inisialisasi
  String? _errorMessage;

  // State untuk UI Search
  late TextEditingController _controller;
  List<Institution> _filteredInstitutions = [];
  bool _isInstitutionSelected = false; // Flag untuk validasi

  // Penambahan: FocusNode untuk mendeteksi fokus/klik
  final FocusNode _focusNode = FocusNode();

  // Flag baru untuk memastikan refetch hanya 1x per sesi fokus
  bool _hasRefreshedOnFocus = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan nilai yang sudah dipilih dari parent
    _controller = TextEditingController(text: widget.selectedName);
    _controller.addListener(_onSearchChanged);

    // !!! PENAMBAHAN: Listener fokus diaktifkan kembali
    _focusNode.addListener(_onFocusChanged);

    // Asumsi jika selectedName tidak kosong, institusi sudah dianggap terpilih
    _isInstitutionSelected = widget.selectedName.isNotEmpty;

    // Muat data saat widget pertama kali dibuat (HANYA SEKALI untuk initial load)
    _fetchInstitutions();
  }

  // Memastikan controller dan status terpilih disinkronkan dengan parent widget
  @override
  void didUpdateWidget(covariant CustomInstitutionSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedName != oldWidget.selectedName) {
      if (_controller.text != widget.selectedName) {
        // Update controller hanya jika perubahannya berasal dari luar (parent)
        _controller.text = widget.selectedName;
      }
      _isInstitutionSelected = widget.selectedName.isNotEmpty;
    }
  }

  // Logika baru: Panggil _fetchInstitutions() saat field mendapat fokus
  // dan pastikan hanya berjalan 1x per sesi fokus.
  void _onFocusChanged() {
    if (!mounted) return;

    if (_focusNode.hasFocus) {
      // Ketika focused, jika belum refresh DAN tidak sedang loading, lakukan fetch.
      if (!_hasRefreshedOnFocus && !_isLoading) {
        debugPrint(
            'Refetching institutions on focus gain (single shot refresh)...');
        _fetchInstitutions();
        _hasRefreshedOnFocus =
            true; // Set flag agar tidak fetch lagi selama masih fokus
      }
    } else {
      // Ketika unfocused, reset flag agar klik berikutnya bisa memicu refresh
      _hasRefreshedOnFocus = false;
    }
  }

  void _onSearchChanged() {
    // Hanya lakukan pencarian jika data sudah dimuat
    if (_isLoading || _errorMessage != null) return;

    final query = _controller.text.toLowerCase();

    // Reset status terpilih saat pengguna mulai mengetik
    if (_isInstitutionSelected && query != widget.selectedName.toLowerCase()) {
      _isInstitutionSelected = false;
      // Panggil callback dengan ID 0 atau null, menunjukkan pilihan dibatalkan
      widget.onInstitutionSelected(0, '');
    }

    // Terapkan logika filter (minimal 2 karakter)
    if (query.length < 2) {
      setState(() => _filteredInstitutions.clear());
      return;
    }

    setState(() {
      _filteredInstitutions = _institutions
          .where((inst) => inst.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void _selectInstitution(Institution inst) {
    // Set text field
    _controller.text = inst.name;
    // Panggil callback dengan ID dan Nama
    widget.onInstitutionSelected(inst.id, inst.name);

    // Atur status dan tutup saran
    _isInstitutionSelected = true;
    FocusScope.of(context).unfocus();
    setState(() => _filteredInstitutions.clear());
  }

  // Logika pengambilan data API dipertahankan untuk pembaruan data
  Future<void> _fetchInstitutions() async {
    if (!mounted) return;

    // Set loading state
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _institutions = []; // Reset list saat fetch
      _filteredInstitutions = []; // Reset filtered list
    });

    try {
      final response = await http.get(Uri.parse(ApiUrls.fetchInstitution));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List institutionsJson = data['institutions'] ?? data['data'];

        if (!mounted) return;

        setState(() {
          _institutions = institutionsJson
              .map((json) => Institution.fromJson(json))
              .toList();

          // Lakukan filtering ulang jika sudah ada query yang diketik
          _onSearchChanged();
        });
      } else {
        throw Exception(
            'Gagal memuat institusi: Status ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching institutions: $e');
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _institutions = [];
        _filteredInstitutions = [];
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    // !!! PENAMBAHAN: Menghapus listener fokus
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    // Tampilkan pesan error atau loading
    if (_errorMessage != null) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Error: $_errorMessage',
                style: TextStyle(color: Colors.red, fontSize: 12.sp)),
            SizedBox(height: 5.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                // Tombol ini tetap ada untuk memuat ulang data secara manual
                onPressed: _fetchInstitutions,
                child: const Text('Coba Muat Ulang Institusi'),
              ),
            ),
          ],
        ),
      );
    }

    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return Column(
      children: [
        // Input Field (Sesuai gaya UI baru)
        _buildInputField(mq),

        // Suggestion List
        if (_filteredInstitutions.isNotEmpty)
          Container(
            margin: EdgeInsets.only(bottom: mq.size.height * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            constraints: BoxConstraints(
              maxHeight: mq.size.height * 0.25,
            ),
            child: ListView.builder(
              itemCount: _filteredInstitutions.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final inst = _filteredInstitutions[index];
                return ListTile(
                  title: Text(
                      // Hanya tampilkan nama
                      inst.name,
                      style: TextStyle(fontSize: 13.sp, color: Colors.black87)),
                  dense: true,
                  onTap: () => _selectInstitution(inst),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildInputField(MediaQueryData mq) {
    // Gunakan margin yang sama dengan yang Anda minta di template UI
    return Container(
      margin: EdgeInsets.only(
          bottom: _filteredInstitutions.isEmpty ? 10.h : mq.size.height * 0.02),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          // Border selalu abu-abu
          color: Colors.grey.shade300,
        ),
      ),
      child: TextField(
        focusNode: _focusNode, // FocusNode dipertahankan
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Nama Institusi', // Sesuai permintaan
          hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
          contentPadding: EdgeInsets.symmetric(
            horizontal: mq.size.width * 0.03,
            vertical: mq.size.height * 0.015,
          ),
          prefixIcon: null, // Ikon pencarian dihapus
          suffixIcon: _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(strokeWidth: 2)),
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// InstitutionSearchBody Dihapus atau Dikosongkan
class InstitutionSearchBody extends StatefulWidget {
  final List<Institution> allInstitutions;
  final InstitutionSelectedCallback onInstitutionSelected;

  const InstitutionSearchBody({
    super.key,
    required this.allInstitutions,
    required this.onInstitutionSelected,
  });

  @override
  State<InstitutionSearchBody> createState() => _InstitutionSearchBodyState();
}

class _InstitutionSearchBodyState extends State<InstitutionSearchBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
