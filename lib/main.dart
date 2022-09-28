import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/app_cubit.dart';
import 'package:flutter_news_app/ui/main_news_screen.dart';

import 'bloc/news_cubit.dart';



void main() {
runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
        BlocProvider(create: (context)
    =>
    NewsCubit(InitNewsState())..getHttpNews()),
      BlocProvider(create: (context)=> AppCubit(InitAppState())..getThemeMode()),
    ],
        child: BlocConsumer<AppCubit,AppStates>(
            builder: (context,state){
              return MaterialApp(
                theme: lightTheme(),
                darkTheme: darkTheme(),
                themeMode: AppCubit.get(context).themeMode,
                debugShowCheckedModeBanner: false,
                home: NewsScreen(),
              );
            },
            listener: (context,state){

            }
        )
    );

    /*BlocProvider(create: (context)
    =>
    NewsCubit(InitNewsState())..getHttpNews()
    ,
    child: );*/
  }
  ThemeData lightTheme(){
    return ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.blue[700],
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        )
    );
  }
  ThemeData darkTheme(){
    return ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
          ),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        )
    );
  }

}
