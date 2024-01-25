import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/model/art_mod.dart';
import 'package:news/model/slider_mod.dart';
import 'package:news/pages/article_veiw.dart';
import 'package:news/service/news.dart';
import 'package:news/service/slider_data.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews ({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {

  List<sliderModel> sliders = [];
  List<ArtMod> article = [];

  void initState() {
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async{
    News newsclass = News();
    await newsclass.getNews();
    article = newsclass.news;
    setState(() {
      
    });
  }

  getSlider() async{
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders; 
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 
         Text(widget.news+" News", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
        
        centerTitle: true,
        elevation: 0.0,
        ),

      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: widget.news == "Breaking"? sliders.length: article.length,
          itemBuilder: (context, index) {
            return AllNewsSection(
              url: widget.news == "Breaking"? sliders[index].url!: article[index].url!,
              desc: widget.news == "Breaking"? sliders[index].description!: article[index].description!,
              Image: widget.news == "Breaking"? sliders[index].urlToImage!: article[index].urlToImage!,
              title: widget.news == "Breaking"? sliders[index].title!: article[index].title!);
          }),
        
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String Image, desc, title, url;
  AllNewsSection({required this.Image, required this.desc, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArtViw(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: Image,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,),
            ),
      
            SizedBox(height: 5,),
            Text(title,
            maxLines: 2,
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
      
            Text(desc,
            maxLines: 3,
            style: TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.normal),),
      
            SizedBox(height: 20,),
              
          ],
        ),
      ),
    );
  }
}