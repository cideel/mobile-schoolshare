import 'package:flutter/material.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/features/search/presentation/pages/people_search/people_search.dart';
import 'package:schoolshare/features/search/presentation/pages/publication_search/publication_search.dart';
import 'package:schoolshare/features/search/presentation/pages/discussion/discussion_search.dart';
import 'package:schoolshare/features/search/presentation/widgets/main_search_widgets/custom_search_bar.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.componentColor,
        elevation: 1,
        leading: BackButton(color: Colors.white),
        title: CustomSearchBar(
          controller: _searchController,
          onChanged: () => setState(() {}),
        ),
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
}
