import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/dio_helper/dio_helper.dart';
import '../../shared/sharedprefrence_helper/sharedpreference_helper.dart';
import '../science_news_activity/science_activity.dart';
import '../sports_news_activity/sports_activity.dart';
import '../technology_news_activity/technology_activity.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  static TextEditingController newsSearchController = TextEditingController();
  int currentIndex = 0;
  bool isDark = false;

  Color scaffoldBackgroundColor = Colors.white;
  Color iconsColor = Colors.white;
  Color floatingButtonBackgroundColor = Colors.black;
  Color bottomNavBarColor = Colors.white;
  Color bottomNavBarIconColor = Colors.black;
  Color bottomNavBarBackGroundColor = Colors.redAccent;
  Color textColor = Colors.black;

  IconData darkLightModeToggle = Icons.brightness_2;
  ThemeMode? themeMode;

  List sports = [];
  List technology = [];
  List science = [];
  List search = [];

  List<Widget> bodyActivities = [
    const SportsActivity(),
    const TechnologyActivity(),
    const ScienceActivity(),
  ];

  void changeBottomNavBarState(int index) {
    currentIndex = index;
    emit(NewsChangeBottomNavBarState());
  }

  void changeDarkLightState({bool? booleanFromShared}) {
    if (booleanFromShared != null) {
      isDark = booleanFromShared;
      emit(NewsDarkModeState());
    }
    if (isDark) {
      scaffoldBackgroundColor = Colors.black;
      textColor = Colors.white;
      iconsColor = Colors.black;
      bottomNavBarColor = Colors.black;
      bottomNavBarIconColor = Colors.white;
      bottomNavBarBackGroundColor = Colors.white;
      floatingButtonBackgroundColor = Colors.white;
      darkLightModeToggle = Icons.brightness_2_outlined;
      isDark = false;
    } else {
      scaffoldBackgroundColor = Colors.white;
      textColor = Colors.black;
      iconsColor = Colors.white;
      bottomNavBarColor = Colors.white;
      bottomNavBarIconColor = Colors.black;
      bottomNavBarBackGroundColor = Colors.redAccent;
      floatingButtonBackgroundColor = Colors.black;
      darkLightModeToggle = Icons.brightness_2;
      isDark = true;
    }
    SharedPreferencesHelper.setBooleanData(key: "isDark", value: isDark)
        .then((value) {
      emit(NewsDarkModeState());
    });
  }

  void getSportsNews() {
    emit(NewsLoadingDataState());

    (sports.isEmpty)
        ? DioHelper.getData(url: "v2/top-headlines", query: {
            "country": "us",
            "category": "sports",
            "apiKey": "648aa65dcc7e46a98b2ed4e4224514c0",
          }).then((value) {
            sports = value.data['articles'];

            emit(NewsGetSportsDataState());
          }).catchError((getSportsError) {
            emit(NewsGetSportsDataState());
          })
        : emit(NewsGetSportsDataState());
  }

  void getTechnologyNews() {
    emit(NewsLoadingDataState());

    (technology.isEmpty)
        ? DioHelper.getData(url: "v2/top-headlines", query: {
            "country": "us",
            "category": "technology",
            "apiKey": "648aa65dcc7e46a98b2ed4e4224514c0",
          }).then((value) {
            technology = value.data['articles'];
            emit(NewsGetTechnologyDataState());
          }).catchError((getSportsError) {
            emit(NewsGetTechnologyDataState());
          })
        : emit(NewsGetTechnologyDataState());
  }

  void getScienceNews() {
    emit(NewsLoadingDataState());

    (science.isEmpty)
        ? DioHelper.getData(url: "v2/top-headlines", query: {
            "country": "us",
            "category": "science",
            "apiKey": "648aa65dcc7e46a98b2ed4e4224514c0",
          }).then((value) {
            science = value.data['articles'];
            emit(NewsGetScienceDataState());
          }).catchError((getSportsError) {
            emit(NewsGetScienceDataState());
          })
        : emit(NewsGetScienceDataState());
  }

  void getSearchDataNews({String? value}) {
    emit(NewsLoadingDataState());
    DioHelper.getData(url: "v2/everything", query: {
      "q": "$value",
      "apiKey": "648aa65dcc7e46a98b2ed4e4224514c0",
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchDataState());
    }).catchError((searchError) {
      emit(NewsErrorSearchDataState());
    });
  }
}
