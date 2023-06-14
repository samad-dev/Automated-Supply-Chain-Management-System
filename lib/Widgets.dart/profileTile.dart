import 'package:asms/Constants/ColorConstants.dart';
import 'package:flutter/material.dart';


class ProfileTile extends StatelessWidget {
  var iconn;
  var txt;
  var onTapFunc;
   ProfileTile({Key? key, required this.onTapFunc ,required this.iconn, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTapFunc,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      tileColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(
        iconn,
        color: Color(ColorConstants.drkGreen1),
      ),
      title: Text(txt),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Color(ColorConstants.drkGreen1),
      ),
    );
  }
}
