import 'package:flutter/material.dart';
import 'package:freepayagency/pages/color/color.dart';
import 'package:get/get.dart';

ListTile ListTileCustom(
    text, IconData icon, IconData iconarrow, TextStyle styles, Function onTap) {
  return ListTile(
      onTap: () {
        onTap();
      },
      leading: Icon(
        icon,
        color: AppColors.mainColor,
      ),
      title: Text(
        text,
        style: styles,
        textAlign: TextAlign.left,
      ),
      trailing: Icon(iconarrow));
}
