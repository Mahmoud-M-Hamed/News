import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/reusable_components/reusable_components.dart';
import '../news_statemanagement/news_cubit.dart';
import '../news_statemanagement/news_states.dart';

// ignore: must_be_immutable
class SearchActivity extends StatelessWidget {
  TextEditingController newsSearchController = TextEditingController();

  SearchActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getSearchDataNews()
        ..changeDarkLightState(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit newsCubit = NewsCubit.get(context);
          List searchCubit = NewsCubit.get(context).search;

          return Scaffold(
            backgroundColor: newsCubit.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(
                "NEWS APP",
                style: TextStyle(
                  color: NewsCubit.get(context).textColor,
                ),
              ),
              backgroundColor: newsCubit.scaffoldBackgroundColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: newsCubit.bottomNavBarIconColor,
                ),
              ),
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: defaultTextField(
                    labelText: "Search",
                    contentPaddingHorizontal: 0,
                    textEditingController: newsSearchController,
                    onChanged: (String value) {
                      newsCubit.getSearchDataNews(value: value);
                    },
                    suffixIcon: Icons.search,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                (newsCubit.search.isEmpty)
                    ? Container()
                    : Expanded(
                        child: newsAppActivitiesDesign(context,
                            newsCubitList: searchCubit)),
              ],
            ),
          );
        },
      ),
    );
  }
}
