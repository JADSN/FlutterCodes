// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String appBarTitleText;

  const CustomAppBarWidget({
    Key? key,
    required this.appBarTitleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(appBarTitleText),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
