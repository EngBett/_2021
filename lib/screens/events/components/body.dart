import 'package:flutter/material.dart';
import 'dart:async';

import 'package:aylf/constants.dart';
import 'package:aylf/helpers/general_controller.dart';

import '../../../size_config.dart';
import 'event_view.dart';

class Body extends StatefulWidget {
  final int groupId;

  const Body({Key key, this.groupId}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {

  AnimationController animationController;

  List<Map> events;

  final ScrollController _scrollController = ScrollController();

  String searchQuery;

  @override
  void initState() {

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    getEvents();
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<void> getEvents() async{
    List<Map> e;
    if(widget.groupId == null){
      e = await Controller.getEvents();
    }else{
      e = await Controller.getGroupEvents(widget.groupId);
    }

    setState(() {
      events = e;
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
          child: events !=null ? NestedScrollView(
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

                itemCount: events.length,

                padding: const EdgeInsets.only(top: 8),

                scrollDirection: Axis.vertical,

                itemBuilder: (BuildContext context, int index) {

                  final int count = events.length > 10 ? 10 : events.length;
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
                  return events.length > 0 ? EventView(
                    animation: animation,
                    animationController: animationController,
                    event: events[index],
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
