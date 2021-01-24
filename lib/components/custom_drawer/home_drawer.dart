import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_aylf_mobile/helpers/api.dart';
import 'package:new_aylf_mobile/helpers/hex_color.dart';
import 'package:new_aylf_mobile/screens/profile/profile_screen.dart';
import 'package:new_aylf_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:new_aylf_mobile/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_theme.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList> drawerList;

  Map _user;
  String _country;

  bool _loading = false;

  @override
  void initState() {
    _getLocalStorage();

    setdDrawerListArray();
    super.initState();
  }


  Future<SharedPreferences> _getLocalStorage() async {

    var storage = await SharedPreferences.getInstance();

    var user_id = storage.getString('user_id');
    var token = storage.getString('token');

    setState(() {
      _country = storage.getString('country');
    });


    _fetchUser(user_id, token);

  }

  void _fetchUser(id, token) async {
    var res = await CallApi().getDataWToken("/api-user/$id", token);

    setState((){
      _user = json.decode(res.body);
    });

  }


  void setdDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Home',
        icon: Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: 'Help',
        /*isAssetsImage: true,*/
        icon: Icon(Icons.help),
      ),
      DrawerList(
        index: DrawerIndex.FeedBack,
        labelName: 'FeedBack',
        icon: Icon(Icons.lightbulb_outline),
      ),
      DrawerList(
        index: DrawerIndex.Invite,
        labelName: 'Invite Friend',
        icon: Icon(Icons.share),
      ),
      DrawerList(
        index: DrawerIndex.Share,
        labelName: 'Rate the app',
        icon: Icon(Icons.star),
      ),
      DrawerList(
        index: DrawerIndex.About,
        labelName: 'About AYLF',
        icon: Icon(Icons.info),
      ),
      DrawerList(
        index: DrawerIndex.Dev,
        labelName: 'About Developer',
        icon: Icon(Icons.code),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 5.0),
            color: AppTheme.aylfLighter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage("assets/images/aylf_upscaled.png"),
                        fit: BoxFit.contain,
                      ),
                    ), //BoxDecoration
                  ),
                  AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(
                            1.0 - (widget.iconAnimationController.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: GestureDetector(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(40.0)),
                                child: _user==null ? Image.asset('assets/images/default-user-image.png') : Image.network("https://ui-avatars.com/api/?size=512&name=${_user["data"]['firstname']}+${_user["data"]['lastname']}"),
                              ),
                              onTap: () async{
                                Navigator.pushNamed(context, ProfileScreen.routeName);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      _user == null
                          ? 'Waiting...'
                          : "${_user["data"]['firstname']} ${_user["data"]['lastname']}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList[index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.aylfDark2,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () async {

                  SharedPreferences localStorage =
                      await SharedPreferences.getInstance();
                  localStorage.clear();

                  Navigator.popUntil(
                      context, ModalRoute.withName(SplashScreen.routeName));
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? AppTheme.aylfMain
                                  : AppTheme.aylfDark1),
                        )
                      : Icon(listData.icon.icon,
                          color: widget.screenIndex == listData.index
                              ? AppTheme.aylfMain
                              : AppTheme.aylfDark1),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? AppTheme.aylfMain
                          : AppTheme.aylfDark1,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppTheme.aylfMain.withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
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

  Widget _pageRedirectingSnackBar() {
    return SnackBar(
      backgroundColor: HexColor("CFE7F1"),
      duration: Duration(milliseconds: 4000),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(
            height: 50,
            child: Image.asset('assets/images/pacman-loader.gif'),
          ),

          SizedBox(width: 20),

          Text(
            'Redirecting ...',
            style: TextStyle(
                fontFamily: AppTheme.fontName,
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold
            ),
          ),



        ],
      ),
    );
  }

  Widget _pageLoadingSnackBar() {
    return SnackBar(
      backgroundColor: HexColor("CFE7F1"),
      duration: Duration(milliseconds: 4000),
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 50,
              child: Image.asset('assets/images/pacman-loader.gif'),
            ),

            SizedBox(width: 20),

            Text(
              'Another process is ongoing ...',
              style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold
              ),
            ),



          ],
        ),
      )
    );
  }

  Widget _noInternetSnackBar() {
    return SnackBar(
      backgroundColor: HexColor("CFE7F1"),
      duration: Duration(milliseconds: 4000),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(
            height: 50,
            child: Image.asset('assets/images/no_internet.gif'),
          ),

          SizedBox(width: 20),

          Text(
            'No internet connection',
            style: TextStyle(
                fontFamily: AppTheme.fontName,
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold
            ),
          ),

        ],
      ),
    );
  }

}

enum DrawerIndex {
  HOME,
  FeedBack,
  Help,
  Share,
  About,
  Invite,
  Dev,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}
