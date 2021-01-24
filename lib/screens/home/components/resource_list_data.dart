import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class ResourceListData {
  ResourceListData({
    this.icon,
    this.titleTxt = '',
    this.startColor,
    this.endColor,
  });

  Icon icon;
  String titleTxt;
  Color startColor;
  Color endColor;

  static List<ResourceListData> tabIconsList = <ResourceListData>[
    ResourceListData(
      icon: Icon(FeatherIcons.feather,color: Colors.white,size: 14,),
      titleTxt: 'Events',
      startColor: Color(0xFFFA7D82),
      endColor: Color(0xFFFFB295),
    ),
    ResourceListData(
      icon: Icon(FeatherIcons.activity,color: Colors.white,size: 14,),
      titleTxt: 'Activities',
      startColor: Color(0xFF738AE6),
      endColor: Color(0xFF5C5EDD),
    ),
    ResourceListData(
      icon: Icon(FeatherIcons.paperclip,color: Colors.white,size: 14,),
      titleTxt: 'Resources',
      startColor: Color(0xFFFE95B6),
      endColor: Color(0xFFFF5287),
    ),

  ];
}
