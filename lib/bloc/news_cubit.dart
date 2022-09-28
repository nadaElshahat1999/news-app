import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/models/news_response.dart';
import 'package:flutter_news_app/ui/business_news_sceen.dart';
import 'package:flutter_news_app/ui/science_news_screen.dart';
import 'package:flutter_news_app/ui/sports_news_screen.dart';
import 'package:flutter_news_app/ui/technology_news_screen.dart';

class NewsStates{

}
class InitNewsState extends NewsStates{

}
class OnBottomNavigationChanged extends NewsStates{

}
class GetNewsState extends NewsStates{

}
class OnSearchingStateChanged extends NewsStates{

}
class NewsCubit extends Cubit<NewsStates>{
  bool isSearching=false;
  List<Articles>? searchList=[];
  TextEditingController searchController =TextEditingController();
  NewsCubit(NewsStates initialState) : super(initialState);
  static NewsCubit get(context) => BlocProvider.of(context);
  List<Articles> businessArticles = [];
  List<Articles> sportsArticles = [];
  List<Articles> technologyArticles = [];
  List<Articles> scienceArticles = [];

  String imageUrl = "https://aqaarplus.com/assets/uploads/default.png";
  List<String> titles=["Business", "Sports", "Technology", "Science"];
  int index=0;

  List<Widget> screens = [
    BusinessNewsScreen(),
    SportsNewsScreen(),
    TechnologyNewsScreen(),
    ScienceNewsScreen(),
  ];
  onBottomNavigationBarChanged(int value){
    index = value;
    emit(OnBottomNavigationChanged());

  }
  onSearchingStateChanged(bool value){
    isSearching = value;
    emit(OnSearchingStateChanged());
  }
  void search(String value) async {
    /*setState(() {
      isSearching = true;
    });*/
    onSearchingStateChanged(true);
    try {
      var  day=DateTime.now().day;
      var  month=DateTime.now().month;
      var  year=DateTime.now().year;
      print(day);
      var response = await Dio().get(
        'https://newsapi.org/v2/everything',
        queryParameters: {
          "q": "$value",
          "from": "$year-$month-$day",
          "sortBy": "publishedAt",
          "apiKey": "2d3a6047e5a34e0885639cb8c690aa08",
        },
      );

      News_response news = News_response.fromJson(response.data);
      searchList = news.articles;
     /* setState(() {
        isSearching = false;
      });*/
      onSearchingStateChanged(false);

    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('catched');
        print(e.response!.data['message']);
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        return;
      }
      print(e);
    } catch (e) {
      print(e);
    }
  }
  getHttpNews() async {
    try{
      var sportsResponse=await Dio().get('https://newsapi.org/v2/top-headlines',
        queryParameters: {
          "country":"eg",
          "category": 'sports',
          "apiKey":"2d3a6047e5a34e0885639cb8c690aa08",
        },);
      News_response sportsNews = News_response.fromJson(sportsResponse.data);
      sportsArticles = sportsNews.articles!;

      var scienceResponse=await Dio().get('https://newsapi.org/v2/top-headlines',
        queryParameters: {
          "country":"eg",
          "category": 'science',
          "apiKey":"2d3a6047e5a34e0885639cb8c690aa08",
        },);
      News_response scienceNews = News_response.fromJson(scienceResponse.data);
      scienceArticles = scienceNews.articles!;

      var businessResponse=await Dio().get('https://newsapi.org/v2/top-headlines',
        queryParameters: {
          "country":"eg",
          "category": 'business',
          "apiKey":"2d3a6047e5a34e0885639cb8c690aa08",
        },);
      News_response businessNews = News_response.fromJson(businessResponse.data);
      businessArticles = businessNews.articles!;
      //setState(() {});


      var technologyResponse=await Dio().get('https://newsapi.org/v2/top-headlines',
        queryParameters: {
          "country":"eg",
          "category": 'technology',
          "apiKey":"2d3a6047e5a34e0885639cb8c690aa08",
        },);
      News_response techNews = News_response.fromJson(technologyResponse.data);
      technologyArticles = techNews.articles!;
      //setState(() {});
      emit(GetNewsState());

    }
    catch(e){
      print(e);
    }
  }
  /*
  getNews(){
    Dio().get('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fa72aea7f1af46a6a45be8aa23e21b64')
        .then((value) {
      News_response news_response=News_response.fromJson(value.data);
      articles=news_response.articles!;
      // setState(() {});
      emit(GetNewsState());
    }).catchError((error){
      print('Error => $error');
    });

  }*/
}