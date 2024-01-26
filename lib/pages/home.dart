import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/model/art_mod.dart';
import 'package:news/model/cat_mod.dart';
import 'package:news/model/slider_mod.dart';
import 'package:news/pages/all_news.dart';
import 'package:news/pages/article_veiw.dart';
import 'package:news/pages/category_news.dart';
import 'package:news/service/data.dart';
import 'package:news/service/news.dart';
import 'package:news/service/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CatMod> catergories = [];
  List<sliderModel> sliders = [];
  List<ArtMod> article = [];
  bool _loading = true;
  
  int activeIndex = 0;
  @override
  void initState() {
  catergories = getCategories();
  getSlider();
  getNews();
    super.initState();
  }

  getNews() async{
    News newsclass = News();
    await newsclass.getNews();
    article = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  getSlider() async{
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders; 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Flutter"), Text("News", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)],
        ),
        centerTitle: true,
        elevation: 0.0,
        ),


      body: _loading? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              margin: EdgeInsets.only(left: 10.0),
              height: 70,
              child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: catergories.length,
              itemBuilder: (context, index){
                return CategoryTile(
                  image: catergories[index].image,
                  categoryName: catergories[index].categoryName,
                );
              }),
              ),
        
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Breaking News!",
                      style: TextStyle(
                        color: Colors.black, 
                        fontWeight: FontWeight.bold, 
                        fontSize: 18),),


                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: "Breaking")));
                      },
                      child: Text(
                        "Veiw All", 
                        style: TextStyle(
                          color: Colors.green, 
                          fontWeight: FontWeight.w400, 
                          fontSize: 14),),
                    ),
                  ],
                ),
              ),
        
              SizedBox(height: 20.0,),
              CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (context, index, realIndex){
              String? res = sliders[index].urlToImage;
              String? res1 = sliders[index].title;
              return buildImage(res!, index, res1!);
              }, options: CarouselOptions(
        
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                height: 250,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
                )
              ),
              SizedBox(height: 30,),
              Center(child: buildIndicator()),
        
              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Trending News!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                    
                    
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: "Trending")));
                      },
                      child: Text(
                        "Veiw All", 
                        style: TextStyle(
                          color: Colors.green, 
                          fontWeight: FontWeight.w400, 
                          fontSize: 14),),
                    ),
                  ],
                ),
              ),
        
              SizedBox(height: 10,),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: article.length,
                  itemBuilder: (context, index) {
                  return BlogTile(
                    url: article[index].url!,
                    desc: article[index].description!,
                    imageUrl: article[index].urlToImage!,
                    title: article[index].title!);
                }),
              )
              
        
          ],),
        ),
      ),
    );
      
  }

  Widget buildImage(String image, int index, String name) => Container(
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    child: Stack(
      children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: image,
          height: 250,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,)),

        Container(
          height: 250,
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.only(top: 130.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration (color: Colors.black26, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
          child: Text(
            name,
            maxLines: 2,
            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),

        )
    ],),
  );

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: 5,
    effect: SlideEffect(dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blueGrey),);
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryNews(name: categoryName)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(image, 
            width: 120, 
            height: 60, fit: BoxFit.cover,),
          ),
      
      
          Container(
            width: 120, 
            height: 60,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.black38,),
            
            child: Center(child: Text(categoryName, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)),
          )
        ],),
      ),
    );
  }
}

class BlogT
ile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile({required this.desc, required this.imageUrl, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtViw(blogUrl: url)));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(imageUrl: imageUrl, height: 150, width: 150, fit: BoxFit.cover,))
                          ),
                        
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/1.7,
                                child: Text(
                                title, maxLines: 2, style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14
                                ),
                                ),
                              ),
                        
                              SizedBox(width: 7,),
                              Container(
                                width: MediaQuery.of(context).size.width/1.7,
                                child: Text(
                                desc, maxLines: 3, style: TextStyle(
                                  color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 12,
                                ),
                                ),
                              ),
                        
                            ],
                          ),
                        ],),
                      ),
                    ),
                  ),
                ),
              );
  }
}

