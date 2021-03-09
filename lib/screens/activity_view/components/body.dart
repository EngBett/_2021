import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aylf/helpers/api.dart';
import 'package:aylf/helpers/general_controller.dart';
import 'package:aylf/helpers/hex_color.dart';
import 'package:aylf/screens/navigation/navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_theme.dart';
import '../../../size_config.dart';
import 'calendar_popup_view.dart';

class Body extends StatefulWidget {
  final Map activity;
  final bool volunteered;

  const Body({Key key, this.activity, this.volunteered}) : super(key: key);

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

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _token;

  Map status;

  int _positionsLeft;
  bool _loading = false;

  @override
  void initState() {
    _positionsLeft = widget.activity['volunteers_needed'] -
        widget.activity['volunteers'].length;

    _getToken();

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  _getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    setState(() {
      _token = storage.getString('token');
    });
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

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: SafeArea(
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
                        widget.activity["name"],
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 8, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Volunteers\nRequired',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.27,
                          color: AppTheme.grey.withOpacity(.5),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "${widget.activity['volunteers_needed']}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.futura,
                          fontWeight: FontWeight.w200,
                          fontSize: 24,
                          letterSpacing: 0.27,
                          color: AppTheme.aylfMain,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          '4.3',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 22,
                            letterSpacing: 0.27,
                            color: AppTheme.grey.withOpacity(0),
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: AppTheme.aylfMain.withOpacity(0),
                          size: 24,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: opacity1,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    getBoxUI("$_positionsLeft", 'Positions\nLeft'),
                    getBoxUI("${widget.activity['start_date']}", 'Starting'),
                    getBoxUI("${widget.activity['end_date']}", 'Ending'),
                  ],
                ),
              ),
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
                    widget.activity["description"] == null
                        ? "Description missing..."
                        : widget.activity["description"],
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
            Divider(
              height: 1,
            ),
            !widget.volunteered
                ? Expanded(
                  child: AnimatedOpacity(
                      opacity: opacity2,
                      duration: const Duration(milliseconds: 500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.grey.withOpacity(0.2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              onTap: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                // setState(() {
                                //   isDatePopupOpen = true;
                                // });
                                showCalenderDialog(context: context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width -
                                            50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Choose dates',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 16,
                                                  color: Colors.grey
                                                      .withOpacity(0.8)),
                                            ),
                                            SizedBox()
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      '${startDate == null ? "{start date}" : DateFormat("dd, MMM").format(startDate)} - ${endDate == null ? "{end date}" : DateFormat("dd, MMM").format(endDate)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        color: AppTheme.anchorLinkBlue,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                )
                : SizedBox(),
            !widget.volunteered
                ? AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, bottom: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: _volunteer,
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppTheme.aylfMain,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color:
                                            AppTheme.aylfMain.withOpacity(0.5),
                                        offset: const Offset(1.1, 1.1),
                                        blurRadius: 10.0),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    _loading ? 'Loading ...' : 'Volunteer',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                      color: AppTheme.nearlyWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      )),
    );
  }

  Widget getBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  wordSpacing: -1,
                  fontSize: 10,
                  letterSpacing: 0.27,
                  color: AppTheme.aylfMain,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: AppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCalenderDialog({BuildContext context}) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            if (startData != null && endData != null) {
              startDate = startData;
              endDate = endData;
            }
          });
        },
        onCancelClick: () {},
      ),
    );
  }

  void _volunteer() async {
    if (!_loading) {
      if (await getConnection()) {
        if (endDate != null && startDate != null) {
          setState(() {
            _loading = true;
          });

          var data = {
            "from": DateFormat("yyyy-MM-dd").format(startDate),
            "to": DateFormat("yyyy-MM-dd").format(endDate),
            "activity_id": widget.activity["id"]
          };

          var res = await CallApi().postDataWToken(data, '/api-volunteer', _token);
          var body = await json.decode(res.body);

          setState(() {
            _loading = false;
          });

          var activities = await Controller.getUserVolunteeredActivities();

          Navigator.of(context)
              .popUntil(ModalRoute.withName(NavigationScreen.routeName));
        } else {
          _datesMissing();
        }
      } else {
       _showNoInternetModal();
      }
    }
  }

  _datesMissing() {
    showModalBottomSheet(context: context, builder: (BuildContext context) => Container(
      height: getProportionateScreenHeight(50),
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Please choose dates'),
          ],
        ),
      ),
    ));
  }

  Future<bool> getConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  _showNoInternetModal(){
    showModalBottomSheet(context: context, builder: (BuildContext context) => Container(
      height: getProportionateScreenHeight(50),
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Check your internet connection...'),
          ],
        ),
      ),
    ));
  }
}
