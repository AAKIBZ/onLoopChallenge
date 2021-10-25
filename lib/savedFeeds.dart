import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'browserpage.dart';

class SavedFeeds extends StatefulWidget {
  const SavedFeeds({Key? key}) : super(key: key);

  @override
  _SavedFeedsState createState() => _SavedFeedsState();
}

class _SavedFeedsState extends State<SavedFeeds> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {});
      getPrefs();
    });
  }

  String title = "";
  String createdAt = "";
  String description = "";
  String thumbnailUrl = "";
  String contentUrl = "";

  @override
  Widget build(BuildContext context) {
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
            feeds(context),
          ],
        ),
      ),
    );
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    title = prefs.get('title').toString();
    createdAt = prefs.get('createdAt').toString();
    description = prefs.get('description').toString();
    contentUrl = prefs.get('contentUrl').toString();
    thumbnailUrl = prefs.get('thumbnailUrl').toString();
  }

  Widget feeds(BuildContext contextAction) {
    // filterList(contentData);
    return Flexible(
      flex: 1,
      child: Container(
        height: MediaQuery.of(contextAction).size.height * 0.7,
        width: MediaQuery.of(contextAction).size.width,
        child: ListView.builder(
            itemCount: 1,
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
                              thumbnailUrl,
                              height: 100.0,
                              width: 100.0,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(

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
                                      title,
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

                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  description,
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
                                    title,
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
                                    description,
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
                                        title,
                                        style: TextStyle(),
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
