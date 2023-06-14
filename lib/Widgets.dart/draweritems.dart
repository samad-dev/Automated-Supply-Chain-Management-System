import 'package:asms/Constants/ColorConstants.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onPressed,
      required this.clr})
      : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;
  var clr;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: clr,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 22, color: Color(ColorConstants.drkGreen1)),
            )
          ],
        ),
      ),
    );
  }
}
