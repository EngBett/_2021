import 'package:aylf/services/db_service.dart';
import 'package:aylf/services/models/Notification.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:aylf/constants.dart';
import 'package:sqflite/sqflite.dart';

import '../../../size_config.dart';
import 'notification_ui_view.dart';

class Body extends StatefulWidget {
  final List<dynamic> members;

  const Body({Key key, this.members}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {

  AnimationController animationController;

  final ScrollController _scrollController = ScrollController();

  String searchQuery;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Notif> noteList;
  int count = 0;

  @override
  void initState() {

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(noteList == null){
      noteList = <Notif>[];
      updateListView();
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: noteList !=null ? NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[

                SliverList(

                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                    return Column(
                      children: <Widget>[

                        searchUI(context),

                      ],
                    );
                  }, childCount: 1),

                ),

              ];
            },

            body: Container(
              color: Color(0xFFFFFFFF),
              child: ListView.builder(

                itemCount: widget.members.length,

                padding: const EdgeInsets.only(top: 8),

                scrollDirection: Axis.vertical,

                physics: const BouncingScrollPhysics(),

                itemBuilder: (BuildContext context, int index) {

                  final int count = noteList.length > 10 ? 10 : noteList.length;
                  final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(

                      CurvedAnimation(
                          parent: animationController,
                          curve: Interval(
                              (1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn
                          )
                      )

                  );

                  animationController.forward();
                  return noteList.length > 0 ? NotificationUIView(
                    animation: animation,
                    animationController: animationController,
                    title: noteList[index].title,
                    description: noteList[index].description,
                    date: noteList[index].date,
                    seen: noteList[index].priority,
                    id: noteList[index].id,
                  ) : SizedBox();

                },
              ),
            ),

          )
              : Center(child:Text("loading...")),
        )
      ],

    );
  }

  Widget searchUI(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(10)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          onChanged: (value) => print(value),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenWidth(9)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Search...",
              prefixIcon: Icon(Icons.search)),
        ),
      ),
    );
  }


  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){

      Future<List<Notif>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList){
        print(noteList[0].title);
        setState((){
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });

    });
  }

}


