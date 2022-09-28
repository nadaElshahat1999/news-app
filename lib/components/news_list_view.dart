import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_news_app/models/news_response.dart';
import 'package:flutter_news_app/ui/web_screen.dart';

Widget newsBody(List<Articles> articles, String imageUrl){
return articles.isEmpty?Center(
  child: CircularProgressIndicator.adaptive(),
):
ListView.builder(itemBuilder: (context,index){
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return InkWell(
onTap: (){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NewsWebViewScreen(articles[index].url)));
}
,child: Container(

    margin: EdgeInsets.all(10),

    padding: EdgeInsets.all(10),

    decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),

        color: isDarkMode?Colors.black : Colors.grey[300]),

    child: Column(

      children: [

        Image.network(articles[index].urlToImage??imageUrl),

        SizedBox(

          height: 10,

        ),

        Text(

          articles[index].title.toString(),

          textAlign: TextAlign.center,

        ),

      ],

    ),

  ),
);
}, itemCount: articles.length,);
}
Widget searchBody(List<Articles> articles, String imageUrl){

  return ListView.builder(itemBuilder: (context,index){
    //to check dark or light mode
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    //
    return InkWell(
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NewsWebViewScreen(articles[index].url)));
    }
    ,child: Container(

    margin: EdgeInsets.all(10),

    padding: EdgeInsets.all(10),

    decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),

        color: isDarkMode ? Colors.black:Colors.grey[300]),

    child: Column(

      children: [
        Image.network(articles[index].urlToImage??imageUrl),
        SizedBox(
          height: 10,
        ),

        Text(
          articles[index].title.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),

      ],

    ),

  ),
  );
  }, itemCount: articles.length,);
}