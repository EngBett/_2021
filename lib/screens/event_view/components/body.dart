import 'package:flutter/material.dart';
import 'package:aylf/size_config.dart';

import '../../../app_theme.dart';

class Body extends StatefulWidget {
  final Map event;

  const Body({Key key, this.event}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("\n\n\n${widget.event}\n\n\n\n");
    return SafeArea(
        child: Container(
      height: double.infinity,
      width: double.infinity,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/undraw/opportunities.png"),
                  fit: BoxFit.contain),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(.9)
                  ])),
              child: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.event["name"],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: opacity1,
            child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 48,
                      width: 2,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 2),
                            child: Text(
                              'Date',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: -0.1,
                                color: AppTheme.grey.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(
                                width: 28,
                                height: 28,
                                child: Icon(
                                  Icons.calendar_today,
                                  size: 16.0,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, bottom: 3),
                                child: Text(
                                  '${widget.event['start_date']}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppTheme.darkerText.withOpacity(.6),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.location_on,size: 16,color: Colors.black,),
                            SizedBox(width: 5,),
                            Text(widget.event["location"],overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontSize: 12))
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15)),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: opacity2,
                child: Text(
                  widget.event["description"] == null
                      ? "Description missing..."
                      : widget.event["description"],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                    letterSpacing: 0.27,
                    color: AppTheme.grey,
                  ),
                  maxLines: 300,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),

          SizedBox(
            height: getProportionateScreenHeight(60),
          )
        ],
      ),
    ));
  }
}
