import 'package:flutter/material.dart';
import '../../services/size_config.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String text;
  AppBarWidget({Key? key, required this.text})
      : preferredSize = Size.fromHeight(getHeight(44.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
      centerTitle: true,
    );
  }

  @override
  final Size preferredSize;
}