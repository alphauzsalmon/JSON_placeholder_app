import 'package:flutter/material.dart';
import 'package:test_app_for_eclipse_ds/models/user.dart';
import 'package:test_app_for_eclipse_ds/screens/widgets/widgets.dart';

class UserPage extends StatelessWidget {
  final User user;
  const UserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: user.username!),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardWidget(
                icon: Icons.person, title: 'Name:', subTitle: user.name!),
            CardWidget(
                icon: Icons.email, title: 'Email:', subTitle: user.email!),
            CardWidget(
                icon: Icons.phone, title: 'Phone:', subTitle: user.phone!),
            CardWidget(
                icon: Icons.web, title: 'Website:', subTitle: user.website!),
            CardWidget(
                icon: Icons.work,
                title: 'Company:',
                subTitle: user.company!.name!),
            CardWidget(
                icon: Icons.business_sharp,
                title: 'BS:',
                subTitle: user.company!.bs!),
            CardWidget(
                icon: Icons.speaker_notes_sharp,
                title: 'Catch Phrase:',
                subTitle: user.company!.catchPhrase!),
            CardWidget(
                icon: Icons.home,
                title: "Adress:",
                subTitle: '${user.address!.street} street'),
            CardWidget(
                icon: Icons.home,
                title: 'Home:',
                subTitle: user.address!.suite!),
            CardWidget(
                icon: Icons.home,
                title: 'City:',
                subTitle: user.address!.city!),
            PostsWidget(
              user: user,
            ),
            AlbumsWidget(user: user),
          ],
        ),
      ),
    );
  }
}
