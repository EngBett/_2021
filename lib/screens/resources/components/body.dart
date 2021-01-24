import 'package:flutter/material.dart';
import 'dart:async';

import 'package:new_aylf_mobile/constants.dart';
import 'package:new_aylf_mobile/helpers/general_controller.dart';

import '../../../size_config.dart';
import 'resource_view.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {

  AnimationController animationController;

  List<Map> resources;

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
    var e = await Controller.getResources();
    setState(() {
      resources = e;
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
          child: resources !=null ? NestedScrollView(
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

                itemCount: resources.length,

                padding: const EdgeInsets.only(top: 8),

                scrollDirection: Axis.vertical,

                physics: const BouncingScrollPhysics(),

                itemBuilder: (BuildContext context, int index) {

                  final int count = resources.length > 10 ? 10 : resources.length;
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
                  return resources.length > 0 ? ResourceView(
                    resource:  resources[index],
                    animation: animation,
                    animationController: animationController,
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
