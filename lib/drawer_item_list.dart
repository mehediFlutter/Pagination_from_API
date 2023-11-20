import 'package:flutter/material.dart';

class DrawerItemList extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function onTapFunction;

  const DrawerItemList({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTapFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      color: Color(0xFF333333),
      elevation: 10,
      child: ListTile(
        onTap: () {
          onTapFunction(); // Corrected: Invoke the onTapFunction
        },
        iconColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        leading: icon,
        title: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}