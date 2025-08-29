import 'package:flutter/material.dart';
import 'package:schoolshare/Config/color.dart';
import 'package:schoolshare/Config/text_styles.dart';
import 'package:schoolshare/Pages/search/tabs/people_search.dart';
import 'package:schoolshare/Pages/search/tabs/publication_search.dart';
import 'package:schoolshare/Pages/search/tabs/discussion_search.dart';

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
    _tabController = TabController(length: 3, vsync: this); // Updated to 3 tabs
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
              labelStyle: AppTextStyle.tabLabel,
              tabs: const [
                Tab(text: "Orang"),
                Tab(text: "Publikasi"),
                Tab(text: "Diskusi"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PeopleSearchResult(),
                PublicationSearchResult(),
                DiscussionSearchResult(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(MediaQueryData mq) {
    return Container(
      height: mq.size.height * 0.048,
      margin: EdgeInsets.only(right: mq.size.width * 0.04),
      padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white, // Solid white background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: Colors.grey[600],
            size: mq.size.width * 0.045,
          ),
          SizedBox(width: mq.size.width * 0.025),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              style: AppTextStyle.bodyText.copyWith(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              decoration: InputDecoration(
                hintText: "Cari sesuatu...",
                hintStyle: AppTextStyle.caption.copyWith(
                  color: Colors.grey[500],
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: mq.size.height * 0.012),
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() {});
              },
              child: Icon(
                Icons.clear_rounded,
                color: Colors.grey[500],
                size: mq.size.width * 0.04,
              ),
            ),
        ],
      ),
    );
  }

}