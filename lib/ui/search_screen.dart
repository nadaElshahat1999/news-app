import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/news_cubit.dart';
import 'package:flutter_news_app/components/component.dart';
import 'package:flutter_news_app/components/news_list_view.dart';
import 'package:flutter_news_app/models/news_response.dart';

class SearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){

        },
        builder: (context,state){
          NewsCubit cubit=NewsCubit.get(context);
          return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            myTextFormField(textInputAction:TextInputAction.search,
                controller: cubit.searchController, validator: (value){
              if(value!.isEmpty){
                return 'Enter search key !';
              }return null;
            }, label: 'Search', prefixIcon: Icons.search,
              onFieldSubmitted: (value){
              if(value.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter search key !',style: TextStyle(color: Colors.red ,fontWeight: FontWeight.w500),)));
              return;
              }
              cubit.search(value);
              }
            ),
            Visibility(
              visible: cubit.isSearching,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
            Expanded(child: searchBody(cubit.searchList!, cubit.imageUrl)),
          ],
        ),
      )),
   );});
  }


  }

