import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../news_app/news_statemanagement/news_cubit.dart';
import '../news_app/news_statemanagement/news_states.dart';
import '../news_app/search_news_activity/search_activity.dart';

class NewsActivity extends StatelessWidget {
  const NewsActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getSportsNews()
        ..getTechnologyNews()
        ..getScienceNews()
        ..changeDarkLightState(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit newsCubit = NewsCubit.get(context);

          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: newsCubit.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(
                "NEWS APP",
                style: TextStyle(
                  color: NewsCubit.get(context).textColor,
                ),
              ),
              backgroundColor: newsCubit.scaffoldBackgroundColor,
              actions: [
                IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  tooltip: "Search",
                  icon: Icon(
                    Icons.search,
                    color: newsCubit.bottomNavBarIconColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchActivity()));
                  },
                ),
              ],
            ),
            body: newsCubit.bodyActivities[newsCubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              items: [
                Icon(
                  Icons.sports,
                  color: newsCubit.bottomNavBarIconColor,
                ),
                Icon(
                  Icons.computer,
                  color: newsCubit.bottomNavBarIconColor,
                ),
                Icon(
                  Icons.science,
                  color: newsCubit.bottomNavBarIconColor,
                ),
              ],
              backgroundColor: newsCubit.bottomNavBarBackGroundColor,
              color: newsCubit.bottomNavBarColor,
              animationDuration: const Duration(milliseconds: 500),
              index: newsCubit.currentIndex,
              onTap: (index) {
                newsCubit.changeBottomNavBarState(index);
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: newsCubit.floatingButtonBackgroundColor,
              onPressed: () {
                newsCubit.changeDarkLightState();
              },
              child: Icon(
                newsCubit.darkLightModeToggle,
                color: newsCubit.iconsColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
