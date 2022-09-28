import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStates{}
class InitAppState extends AppStates{}
class AppThemeChangeState extends AppStates{}
class AppCubit extends Cubit<AppStates>{
  AppCubit(AppStates initialState) : super(initialState);
  static AppCubit get(context)=> BlocProvider.of(context);

  ThemeMode themeMode=ThemeMode.light;

  Future<void> changeThemeMode() async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      preferences.setString('themeMode', 'dark');

    } else {
      themeMode = ThemeMode.light;
      preferences.setString('themeMode', 'light');

    }
   emit(AppThemeChangeState());
  }
  void getThemeMode()async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    String theme=preferences.getString('themeMode')?? 'light';
    if(theme=='light'){
      themeMode=ThemeMode.light;
    }
    else{
      themeMode=ThemeMode.dark;
    }
    emit(AppThemeChangeState());
  }
}
