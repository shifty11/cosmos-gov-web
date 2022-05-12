import 'package:cosmos_gov_web/config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationData {
  final int index;
  final RouteData routerData;
  final Icon icon;
  final String label;

  const NavigationData(this.index, this.routerData, this.icon, this.label);
}

class BottomNavigationBarWidget extends StatelessWidget {
  final double sideBarWith = 300;

  static const List<NavigationData> menu = [
    NavigationData(0, rSubscriptions, Icon(Icons.bookmarks), 'Subscriptions'),
    NavigationData(1, rVoting, Icon(Icons.how_to_vote), 'Voting'),
    NavigationData(2, rAdmin, Icon(Icons.settings), 'Admin'),
  ];

  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  int getIndex(BuildContext context) {
    final location = GoRouter.of(context).location;
    for (var d in BottomNavigationBarWidget.menu) {
      if (d.routerData.path == location) {
        return d.index;
      }
    }
    return -1;
  }

  goTo(BuildContext context, int index) {
    final routerData = BottomNavigationBarWidget.menu.firstWhere((d) => d.index == index).routerData;
    context.goNamed(routerData.name);
  }

  BottomNavigationBarItem navigationItem(Icon icon, String label) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (index) => goTo(context, index),
        currentIndex: getIndex(context),
        items: BottomNavigationBarWidget.menu
            .map((d) => BottomNavigationBarItem(
                  icon: d.icon,
                  label: d.label,
                  tooltip: '',
                ))
            .toList());
  }
}
