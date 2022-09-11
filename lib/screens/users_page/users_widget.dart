import 'package:flutter/material.dart';
import '../../infrastructure/models/user.dart';
import '../user_page/user_page.dart';

class Users extends StatelessWidget {
  final List<User> users;
  const Users({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(users[index].username!),
            subtitle: Text(users[index].name!),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserPage(user: users[index]),
                ),
              );
            },
          ),
        );
      },
      itemCount: users.length,
    );
  }
}