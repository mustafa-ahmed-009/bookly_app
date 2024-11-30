import 'package:bookly/constants.dart';
import 'package:bookly/features/home/presenation/views/widgets/home_view/home_view_grid_view.dart';
import 'package:bookly/features/search/presentation/views/widgets/search_view_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchViewDeskopLayout extends StatelessWidget {
  const SearchViewDeskopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          SearchViewAppBar(),
          Expanded(child: HomeViewGridView(crossAxisCount: 2))
        ],
      ),
    );
  }
}
