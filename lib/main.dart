import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_app/news_statemanagement/bloc_observer.dart';
import 'news_app/news_statemanagement/news_cubit.dart';
import 'news_app/news_statemanagement/news_states.dart';
import 'news_home_layout/news_home_activity.dart';
import 'shared/dio_helper/dio_helper.dart';
import 'shared/sharedprefrence_helper/sharedpreference_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await SharedPreferencesHelper.init();
  bool? isDark = SharedPreferencesHelper.getBooleanData(key: "isDark");
  Bloc.observer = MyBlocObserver();

  runApp(MyApp(isDark: isDark));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool? isDark;

  MyApp({super.key, this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewsCubit()..changeDarkLightState(booleanFromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          NewsCubit newsCubit = NewsCubit.get(context);
          return MaterialApp(
            title: 'News App',
            debugShowCheckedModeBanner: false,
            themeMode: (newsCubit.isDark) ? ThemeMode.light : ThemeMode.dark,
            theme: ThemeData(
              primarySwatch: Colors.red,
              scaffoldBackgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              appBarTheme: const AppBarTheme(
                actionsIconTheme:
                    IconThemeData(color: Colors.black, opacity: 0.5),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )),
                elevation: 10,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                titleSpacing: 30,
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.black,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.red,
              scaffoldBackgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white),
              appBarTheme: const AppBarTheme(
                actionsIconTheme:
                    IconThemeData(color: Colors.white, opacity: 0.5),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )),
                elevation: 10,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarIconBrightness: Brightness.light),
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                titleSpacing: 30,
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.white,
              ),
            ),
            home: const NewsActivity(),
          );
        },
      ),
    );
  }
}
