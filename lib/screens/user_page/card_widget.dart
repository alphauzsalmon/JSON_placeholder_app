import 'package:flutter/material.dart';
import '../../services/size_config.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const CardWidget(
      {Key? key,
        required this.icon,
        required this.title,
        required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(fontSize: getFont(15.0)),
        ),
        subtitle: Text(
          subTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getFont(20.0),
          ),
        ),
      ),
    );
  }
}