import 'package:flutter/material.dart';
import 'package:test_app_for_eclipse_ds/services/size_config.dart';

class ShowErrorWidget extends StatelessWidget {
  final String message;
  const ShowErrorWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: getFont(15.0),
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
