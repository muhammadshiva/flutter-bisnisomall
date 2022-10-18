import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/data/models/new_models/news_activity.dart';
import 'package:marketplace/ui/screens/new_screens/berita_screen/post_by_tag_screen.dart';
import 'package:marketplace/ui/screens/new_screens/berita_screen/widgets/vertical_category_news.dart';
import 'package:marketplace/ui/screens/new_screens/search/search_screen_news_activity.dart';
import 'package:marketplace/ui/widgets/edit_text.dart';
import 'package:marketplace/utils/images.dart' as AppImg;
import 'package:marketplace/utils/typography.dart' as AppTypo;
import 'package:marketplace/utils/extensions.dart' as AppExt;

class BeritaScreen extends StatefulWidget {
  final List<NewsActivity> news;
  // final List<TagNewsActivity> tagNews;

  const BeritaScreen({
    Key key,
    @required this.news,
  }) : super(key: key);

  @override
  _BeritaScreenState createState() => _BeritaScreenState();
}

class _BeritaScreenState extends State<BeritaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        AppImg.img_arrow,
                        fit: BoxFit.contain,
                        height: 12,
                        width: 12,
                      ),
                    ),
                    Text(
                      "Berita & Kegiatan",
                      style: AppTypo.LatoBold.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(top: 3),
                    child: EditText(
                      hintText: "Cari berita & kegiatan",
                      inputType: InputType.search,
                      readOnly: true,
                      onTap: () => AppExt.pushScreen(
                          context, SearchScreenNewsActivity()),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Expanded(
              //   child: Container(
              //     height: 30,
              //     width: double.infinity,
              //     child: ListView(
              //       children: [
              //         ListView.separated(
              //           shrinkWrap: true,
              //           separatorBuilder: (ctx, idx) => SizedBox(width: 10),
              //           physics: BouncingScrollPhysics(),
              //           scrollDirection: Axis.horizontal,
              //           itemCount: widget.tagNews.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             TagNewsActivity _tagNews = widget.tagNews[index];
              //             return HorizontalCategoryNews(
              //               tagNewsActivity: _tagNews,
              //             );
              //           },
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Container(
              //   width: double.infinity,
              //   height: 30,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       SizedBox(
              //         width: 20,
              //       ),
              //       HorizontalCategoryNews(),
              //       SizedBox(
              //         width: 20,
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Scrollbar(
                    child: ListView(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (ctx, idx) => SizedBox(height: 20),
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: widget.news.length,
                          itemBuilder: (BuildContext context, int index) {
                            NewsActivity _news = widget.news[index];
                            return VerticalCategoryNews(
                              newsActivity: _news,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TagNewsActivityScreen()),
                  );
                },
                child: Text("Tag Screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
