import 'package:cosmos_gov_web/config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationData {
  final int index;
  final RouteData routerData;

  const NavigationData(this.index, this.routerData);
}

class BottomNavigationBarWidget extends StatelessWidget {
  final double sideBarWith = 300;

  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  Widget button(BuildContext context, String name, RouteData routeData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          minimumSize: const Size.fromHeight(40),
          backgroundColor: GoRouter.of(context).location == routeData.path ? Colors.grey[400] : null,
        ),
        onPressed: () {
          context.goNamed(routeData.name);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(name, style: Theme.of(context).textTheme.titleLarge),
        ),
      ),
    );
  }

  int getIndex(BuildContext context) {
    final location = GoRouter.of(context).location;
    if (location == rSubscriptions.path) {
      return 0;
    }
    if (location == rVoting.path) {
      return 1;
    }
    return -1;
  }

  goTo(BuildContext context, int index) {
    switch (index) {
      case 0:
        return context.goNamed(rSubscriptions.name);
      case 1:
        return context.goNamed(rVoting.name);
    }
  }

  BottomNavigationBarItem navigationItem(Icon icon, String label) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => goTo(context, index),
      currentIndex: getIndex(context),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmarks),
          label: 'Subscriptions',
          tooltip: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.how_to_vote),
          label: 'Voting',
          tooltip: '',
        ),
      ],
    );
  }
}
