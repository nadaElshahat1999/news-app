import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/news_cubit.dart';
import 'package:flutter_news_app/components/news_list_view.dart';

import '../models/news_response.dart';


class ScienceNewsScreen extends StatelessWidget {

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHttpNews();
  }*/
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){

      },
      builder: (context,state){
        NewsCubit cubit=NewsCubit.get(context);
        return Scaffold(
            body: newsBody(cubit.scienceArticles, cubit.imageUrl)
        );
      },
    );

  }


}
