import 'package:flutter/material.dart';
import 'package:aylf/size_config.dart';

import '../../../app_theme.dart';

class Body extends StatefulWidget {
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

  String bullet = "\u2022 ";

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
    final double tempHeight = MediaQuery
        .of(context)
        .size
        .height -
        (MediaQuery
            .of(context)
            .size
            .width / 1.2) +
        144.0;

    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.aylfLighter,
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('assets/images/aylf_header_square.png'),
                  ),
                ],
              ),
              Positioned(
                top: (MediaQuery
                    .of(context)
                    .size
                    .width / 1.4) - 70.0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 40),
                    child: SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: infoHeight,
                            maxHeight: tempHeight > infoHeight
                                ? tempHeight
                                : infoHeight),
                        child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 16, bottom: 8),
                                  child: Text(
                                    'About AYLF',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: AppTheme.darkerText,
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      'We are a collaborative initiative that brings together University Student leaders, students, and young professionals across the country from both public and private Universities, for mentorship, training, networking and capacity building. AYLF was formed in 2007. It is now present in Kenya, Uganda, Rwanda, Burundi, Tanzania, DR Congo, and South Sudan.',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: AppTheme.grey,
                                      ),
                                      maxLines: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),


                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 900),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      'At AYLF, we believe leadership is being self-aware, having the ability to identify and meet community needs for transformation while inspiring them to exploit their gifts and potential. This is through a commitment to: \n\n    $bullet Integrity\n    $bullet Reconciliation\n    $bullet Unconditional, long term relationships\n    $bullet Service\n    $bullet Impact',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: AppTheme.grey,
                                      ),
                                      maxLines: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1200),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                        'Core values',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 18,
                                          letterSpacing: 0.27,
                                          color: Colors.black,
                                        )
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      '    $bullet Friendship/Relationship\n    $bullet Reconciliation\n    $bullet Community of compassion\n    $bullet Faithfulness/Loyalty\n    $bullet Integrity/Honesty',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: AppTheme.grey,
                                      ),
                                      maxLines: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1200),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                        'Mission',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 18,
                                          letterSpacing: 0.27,
                                          color: Colors.black,
                                        )
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      """Our aim is to be a movement of friends to nurture a new breed of leaders in Africa, based on the leadership qualities, values, and principles of Jesus of Nazareth as exemplified by some of the history’s greatest statesmen and women. We seek to appeal to the human spirit to rise up and embrace values that enhance a high quality of life to the least of these. Our goal is that Young Leaders embody the values and principles of Jesus in East and Central Africa.""",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: AppTheme.grey,
                                      ),
                                      maxLines: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1200),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                        'Vision',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 18,
                                          letterSpacing: 0.27,
                                          color: Colors.black,
                                        )
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      "At the heart of AYLF is the dream that emerging leaders in Africa would know how to speak the truth without being sectarian or religiously divisive, see people without labels or stereotypes, loving each other and those they lead while serving with integrity.",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: AppTheme.grey,
                                      ),
                                      maxLines: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1200),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                        'Philosophy',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 16,
                                          letterSpacing: 0.27,
                                          color: Colors.black,
                                        )
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 32, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      """$bullet The work is done simply in the name of Jesus under the auspices of a national leadership drawn from business, industry, politics, academia, and religion. It’s not done under the name of any particular organisation or religious group.\n\n$bullet The work relates to all people regardless of their religious affiliation - Christian, Muslim, Hindus, and others.\n\nThe work is anchored in the Values, Principles, Precepts and the Person of Jesus.\n\n$bullet The work flows out of, and is based on, long-term committed relationships among those involved.
                                      """,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: AppTheme.grey,
                                      ),
                                      maxLines: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1200),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                        'Our desired outcome',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 16,
                                          letterSpacing: 0.27,
                                          color: Colors.black,
                                        )
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 32, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      """We desire to see young leaders who commit to the following:\n\n$bullet High levels of stewardship\n$bullet High levels of accountability\n$bullet High levels of productivity\n$bullet Leaders wiling to serve others\n$bullet High levels of collaboration\n$bullet Justice in the community\n$bullet Harmonious living and co-existence
                                      """,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: AppTheme.grey,
                                      ),
                                      maxLines: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1200),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                        'Core values',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 18,
                                          letterSpacing: 0.27,
                                          color: Colors.black,
                                        )
                                    ),
                                  ),
                                ),

                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 32, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      """$bullet Friendship/Relationship\n$bullet Reconciliation\n$bullet Community of compassion\n$bullet Faithfulness/Loyalty\n$bullet Integrity/Honesty""",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: AppTheme.grey,
                                      ),
                                      maxLines: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: getProportionateScreenHeight(70),
                                )
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}