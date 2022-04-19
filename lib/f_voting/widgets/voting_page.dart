

import 'package:cosmos_gov_web/f_home/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

class VotingPage extends StatelessWidget {
  const VotingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          SidebarWidget(),
          Text("Voting Page"),
        ],
      ),
    );
  }
}