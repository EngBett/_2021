import 'package:flutter/material.dart';
import 'dart:async';

import 'package:aylf/constants.dart';
import 'package:aylf/helpers/general_controller.dart';

import '../../../size_config.dart';
import 'activity_view.dart';

class Body extends StatefulWidget {
  final int groupId;
  final bool userActivities;

  const Body({Key key, this.groupId, this.userActivities}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {

  AnimationController animationController;

  List<Map> activities;

  final ScrollController _scrollController = ScrollController();

  String searchQuery;

  @override
  void initState() {

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    getActivities();
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<void> getActivities() async{
    List<Map> e;

    if(widget.groupId == null && widget.userActivities == null){
      e = await Controller.getActivities();
    }else if(widget.groupId != null){
      e = await Controller.getGroupActivities(widget.groupId);
    }else{
      e = await Controller.getUserVolunteeredActivities();
    }

    setState(() {
      activities = e;
      print(e);
    });
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: activities !=null ? NestedScrollView(
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

                itemCount: activities.length,

                padding: const EdgeInsets.only(top: 8),

                scrollDirection: Axis.vertical,

                physics: const BouncingScrollPhysics(),

                itemBuilder: (BuildContext context, int index) {

                  final int count = activities.length > 10 ? 10 : activities.length;
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
                  return activities.length > 0 ? ActivityView(
                    animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animationController,
                        curve:
                        Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
                    animationController: animationController,
                    activity: activities[index]
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

}
