import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/app_cubit.dart';
import 'package:flutter_news_app/bloc/news_cubit.dart';
import 'package:flutter_news_app/ui/science_news_screen.dart';
import 'package:flutter_news_app/ui/search_screen.dart';
import 'package:flutter_news_app/ui/sports_news_screen.dart';
import 'package:flutter_news_app/ui/technology_news_screen.dart';

import 'business_news_sceen.dart';

class NewsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //NewsCubit cubit=NewsCubit.get(context);

    return  BlocConsumer<NewsCubit,NewsStates>(
    listener: (context,state){


    },
    builder: (context,state){
    NewsCubit cubit=NewsCubit.get(context);
    return Scaffold(
    appBar: AppBar(title: Text(cubit.titles[cubit.index]),actions: [
      IconButton(icon:Icon(Icons.search),onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchScreen()));
    },)
      ,IconButton(icon:Icon(Icons.lightbulb),onPressed: (){
        //change theme
        AppCubit.get(context).changeThemeMode();
    },)
      ,

    ],),
    bottomNavigationBar: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: cubit.index,
    onTap: (value) {
    cubit.onBottomNavigationBarChanged(value);
    //setState(() {});
    },
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.add_business),label: 'Business'),
      BottomNavigationBarItem(icon: Icon(Icons.sports_baseball),label: 'Sports'),
      BottomNavigationBarItem(icon: Icon(Icons.biotech),label: 'Technology'),
      BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science'),
      ],
      ),
    body: cubit.screens[cubit.index],
    );
    }
    );
  }
}
