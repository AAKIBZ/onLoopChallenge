import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/API/ResponseModelForContentModel.dart';
import 'package:flutter_app_test/API/ResponseModelForTage.dart';
import 'package:flutter_app_test/browserpage.dart';
import 'package:flutter_app_test/color.dart';
import 'package:flutter_app_test/savedFeeds.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'API/Apiclass.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'On Loop Challenge',
      home: FilterChipDisplay(),
    );
  }
}

class FilterChipDisplay extends StatefulWidget {
  @override
  _FilterChipDisplayState createState() => _FilterChipDisplayState();
}

class _FilterChipDisplayState extends State<FilterChipDisplay> {
  String chipValue = "";

  // List<Tags_Chip> tagChipList= new List(grow);
  List<Tags_Chip> tagChipList = List<Tags_Chip>.empty(growable: true);
  List<LearnContent> feedsList = List<LearnContent>.empty(growable: true);

  Future<List<Tags_Chip>> fetchTagsList() async {
    List<Tags_Chip> chips = await API_DATA().fetchTagsData();
    return chips;
  }

  Future<List<LearnContent>> fetchFeedsList() async {
    List<LearnContent> filteredFeeds = List<LearnContent>.empty(growable: true);
    List<LearnContent> feedsData = await API_DATA().fetchContentData();
    if (feedsData.isNotEmpty && feedsData.length > 0) {
      // _AnimatedMovies = AllMovies.where((i) => i.isAnimated).toList();
      filteredFeeds =
          feedsData.where((i) => i.tags[0].name.contains(chipValue)).toList();
      // for (int i = 0; i < feedsData.length; i++) {
      //   LearnContent data = feedsData
      //       .where(elementAt(i).tags[0].name.contains(chipValue));
      //   filteredFeeds.add(data);
      // }
    }
    return filteredFeeds;
  }

  void _returnTagList() async {
    tagChipList = await fetchTagsList();
    setState(() {});
  }

  void _returnFeedsList() async {
    feedsList = await fetchFeedsList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _returnTagList();
    _returnFeedsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Learn",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SavedFeeds()));
              },
              child: Container(
                height: 20,
                width: 20,
                child: Image.asset('assets/images/save-white-icon.png'),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            ChipsWithColor(),
            feeds(context),
          ],
        ),
      ),
    );
  }

  Widget ChipsWithColor() {
    //List<Tags_Chip> chips = [];
    bool _selected = false;
    return Container(
      alignment: Alignment.topLeft,
      height: 190,
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tagChipList.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(25.0),
          itemBuilder: (context, position) {
            return
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: FilterChip(

                    elevation: 9.0,
                    selected: _selected,
                    label: Text(tagChipList[position].name),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                    // selected: _isSelected,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: chooseColor(tagChipList[position].color),
                    onSelected: (isSelected) {
                      print('chip is presses');
                      chipValue = tagChipList[position].name.toString();
                      setState(() {
                        _returnFeedsList();
                      });

                      _selected = isSelected;
                      print(tagChipList[position].name.toString());
                    },
                    selectedColor: Color(0xffeadffd),
                  ),
                );
          }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    ));
  }

  Widget feeds(BuildContext contextAction) {
    // filterList(contentData);
    return Flexible(
      flex: 1,
      child: Container(
        height: MediaQuery.of(contextAction).size.height * 0.7,
        width: MediaQuery.of(contextAction).size.width,
        child: ListView.builder(
            itemCount: feedsList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, position) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Image.network(
                              feedsList[position].thumbnailUrl,
                              height: 100.0,
                              width: 100.0,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebViewExample(
                                          feedsList[position].contentUrl)));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 20,
                                      child: Image.asset(
                                          'assets/images/article-icon.png'),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      feedsList[position].type,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    InkWell(
                                      child: Container(
                                        height: 20,
                                        child: Image.asset(
                                            'assets/images/save-white-icon.png'),
                                      ),
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString(
                                            'title', feedsList[position].title);
                                        prefs.setString('createdAt',
                                            feedsList[position].createdAt);
                                        prefs.setString('description',
                                            feedsList[position].description);
                                        prefs.setString(
                                            'thumbnailUrl', feedsList[position].thumbnailUrl);
                                        prefs.setString(
                                            'contentUrl', feedsList[position].contentUrl);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text("Saved!"),
                                        ));
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  feedsList[position].createdAt,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.caption,
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 200,
                                  child: Text(
                                    feedsList[position].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 200,
                                  child: Text(
                                    feedsList[position].description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Shared by OnLoop',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Flexible(
                                    // padding: const EdgeInsets.all(8.0),
                                    // child: Center(child: Text(feedsList[position].tags[0].name,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,),),),
                                    child: FilterChip(
                                      backgroundColor: Colors.white10,
                                      selected: false,
                                      label: Text(
                                        feedsList[position].tags[0].name,
                                        style: TextStyle(
                                            color: chooseColor(
                                                feedsList[position]
                                                    .tags[0]
                                                    .color)),
                                      ),

                                      // selected: _isSelected,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),

                                      onSelected: (isSelected) {},
                                      selectedColor: Color(0xffeadffd),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 30,
                                          child: Image.asset(
                                              'assets/images/thumbs-up.png')),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          height: 30,
                                          child: Image.asset(
                                              'assets/images/thumbs-down.png')),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

// class ChipChoice extends StatelessWidget {
//   const ChipChoice({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Iterable>(
//         future: API_DATA().fetchTagsData(),
//         builder: (context, snapshot) {
//           return snapshot.data != null
//               ? CHIPSCOLOR()
//               : Center(child: CircularProgressIndicator());
//         });
//   }
// }

// class CHIPSCOLOR extends StatefulWidget {
//    CHIPSCOLOR(String chipValue, {Key? key}) : super(key: key);
//
// final String chipValue;
//   @override
//   _CHIPSCOLORState createState() => _CHIPSCOLORState();
// }
//
// class _CHIPSCOLORState extends State<CHIPSCOLOR> {
//   List<Tags_Chip> chips = [];
//
//   @override
//   void initState() {
//     returnList();
//
//     super.initState();
//   }
//
//   void returnList() async {
//     chips = await getTags();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool _selected = false;
//
//     if (chips.length > 0) {
//       return Container(
//         alignment: Alignment.topLeft,
//         height: 200,
//         child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: chips.length,
//             shrinkWrap: true,
//             padding: EdgeInsets.all(20.0),
//             itemBuilder: (context, position) {
//               return FilterChip(
//                 selected: _selected,
//                 label: Text(chips[position].name),
//                 labelStyle: TextStyle(
//                     color: Colors.black,
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.bold),
//                 // selected: _isSelected,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 backgroundColor: chooseColor(chips[position].color),
//                 onSelected: (isSelected) {
//                   print('chip is presses');
//                   _selected = isSelected;
//                   print(chips[position].name.toString());
//
//                   setState(() {
//                     //Feeds(ChipValue: chips[position].name.toString());
//                   });
//                 },
//                 selectedColor: Color(0xffeadffd),
//               );
//             }),
//       );
//     } else {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//   }
// }

Color chooseColor(String colour) {
  switch (colour) {
    case "red":
      return color.red;

    case "yellow":
      return color.yellow;

    case "green":
      return color.green;

    case "blue":
      return color.blue;

    default:
      return color.orange;
  }
}

// class Feeds extends StatelessWidget {
//   String ChipValue;
//
//   Feeds({Key? key, required this.ChipValue}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Iterable>(
//         future: API_DATA().fetchContentData(ChipValue),
//         builder: (context, snapshot) {
//           return snapshot.data != null
//               ? feeds(List<LearnContent>.from(snapshot.data!), context)
//               : Center(child: CircularProgressIndicator());
//         });
//   }
// }

// filterList(List<LearnContent> contentData) {
//   for (int i = 0; i < contentData.length; i++) {
//     print('TRUJ${contentData[i].tags[i].name}');
//     return contentData[i].tags[i].name;
//   }
//   return "";
// }

// filteredFeed(String feed, List<LearnContent> contentData) {
//   for (int i = 0; i < contentData.length; i++) {
//     if (feed == contentData[i].tags[i].name) {
//       return contentData.where((tag) => feed == contentData[i].tags[i].name);
//     }
//     return contentData;
//   }
// }

// Future<List<Tags_Chip>> getTags() async {
//   List<Tags_Chip> options = await API_DATA().fetchTagsData();
//   return options;
// }
