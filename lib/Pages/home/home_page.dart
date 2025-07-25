import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schoolshare/Pages/detail_content/detail_content.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/publication_item.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const HomeAppBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>  PublicationItem(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailContent()));
              },),
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
