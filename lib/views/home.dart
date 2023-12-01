import 'package:flutter/material.dart';
import 'package:upmatev2/widgets/home/new_post.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            NewPost()
          ],
        ),
      ),
    );
  }
}
