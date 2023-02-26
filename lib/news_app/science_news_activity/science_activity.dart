import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/reusable_components/reusable_components.dart';
import '../news_statemanagement/news_cubit.dart';
import '../news_statemanagement/news_states.dart';

class ScienceActivity extends StatelessWidget {
  const ScienceActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List scienceCubit = NewsCubit.get(context).science;

        return (scienceCubit.isEmpty)
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: CircularProgressIndicator(),
                ),
              )
            : newsAppActivitiesDesign(context, newsCubitList: scienceCubit);
      },
    );
  }
}
