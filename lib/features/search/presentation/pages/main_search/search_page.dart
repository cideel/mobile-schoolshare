import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/core/constants/color.dart';
import 'package:schoolshare/core/constants/text_styles.dart';
import 'package:schoolshare/features/search/presentation/pages/people_search/people_search.dart';
import 'package:schoolshare/features/search/presentation/pages/publication_search/publication_search.dart';
import 'package:schoolshare/features/search/presentation/pages/discussion/discussion_search.dart';
import 'package:schoolshare/features/search/presentation/widgets/main_search_widgets/custom_search_bar.dart';
import 'package:schoolshare/features/search/presentation/controllers/people_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _tabController = TabController(length: 3, vsync: this);

    // Reload tab aktif saat tab berpindah
    _tabController.addListener(() {
      if (_tabController.indexIsChanging)
        return; // tunggu tab selesai berpindah
      _reloadCurrentTab();
    });

    // Reload data tab pertama saat init
    _reloadCurrentTab();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Trigger reload saat app kembali ke foreground
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _reloadCurrentTab();
    }
    super.didChangeAppLifecycleState(state);
  }

  void _reloadCurrentTab() {
    final query = _searchController.text;
    switch (_tabController.index) {
      case 0:
        Get.find<PeopleController>().fetchItems(query: query);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.componentColor,
        elevation: 1,
        leading: const BackButton(color: Colors.white),
        title: CustomSearchBar(
          controller: _searchController,
          searchType: SearchType.people, // bisa ubah saat tab berganti jika mau
          onSearch: (query) => _reloadCurrentTab(),
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
