import 'package:flutter/material.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Pages/search/widgets/people_search.dart';
import 'package:schoolshare/Pages/search/widgets/publication_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        
        backgroundColor: AppColor.componentColor,
        elevation: 1,
        leading: BackButton(color: Colors.white),
        title: _buildSearchBar(mq),

      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColor.componentColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "Orang"),
                Tab(text: "Publikasi"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PeopleSearchResult(),
                PublicationSearchResult(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(MediaQueryData mq) {
    return Container(
      height: mq.size.height * 0.055,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Icon(Icons.search_outlined, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                // TODO: trigger search logic
              },
              decoration: const InputDecoration(
                hintText: "Cari sesuatu...",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
