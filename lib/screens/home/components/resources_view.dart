import 'dart:io';

import 'package:flutter/material.dart';

import '../../../app_theme.dart';
import 'resource_list_data.dart';

class ResourcesListView extends StatefulWidget {
  const ResourcesListView(
      {Key key,this.callBacks})
      : super(key: key);

  final List<Function> callBacks;

  @override
  _ResourceListViewState createState() => _ResourceListViewState();
}

class _ResourceListViewState extends State<ResourcesListView>
    with TickerProviderStateMixin {
  List<ResourceListData> resourceListData = ResourceListData.tabIconsList;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            top: 0, bottom: 10, right: 16, left: 16),
        itemCount: resourceListData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final int count =
          resourceListData.length > 10 ? 10 : resourceListData.length;
          return ResourceView(
            callback: widget.callBacks[index],
            resourceListData: resourceListData[index],
          );
        },
      ),
    );
  }
}

class ResourceView extends StatelessWidget {
  const ResourceView(
      {Key key, this.resourceListData, this.callback}) : super(key: key);

  final Function callback;
  final ResourceListData resourceListData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child:Padding(
        padding: const EdgeInsets.only(
            top: 8, left: 8, right: 8, bottom: 8),
        child: FlatButton(
            onPressed: callback,
            color: resourceListData.startColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  resourceListData.icon,
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    resourceListData.titleTxt,
                    style: TextStyle(
                        color: AppTheme.white,
                        fontFamily: AppTheme.fontName,
                        fontSize: 13
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
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
}
