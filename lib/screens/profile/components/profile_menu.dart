import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
    this.alt,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;
  final Icon alt;

  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
        onPressed: widget.press,
        child: Row(
          children: [
            widget.alt == null
                ? SvgPicture.asset(
              widget.icon,
              color: kPrimaryColor,
              width: 22,
            )
                : widget.alt,
            SizedBox(width: 20),
            Expanded(child: Text(widget.text)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
