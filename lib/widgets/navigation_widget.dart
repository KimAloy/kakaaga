import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:kakaaga/widgets/widgets.dart';

class NavigationItems extends StatelessWidget {
  final Color? searchColor;
  final Color? postColor;
  final Color? watchlistColor;
  final Color? myZattabiColor;
  final bool showSearchIcon;
  final bool showGoToHomeScreenIcon;
  final bool goToAdvertiseScreenOnTap;
  final bool goToWatchlistScreenOnTap;
  final bool goToMyZattabiMyAdvertsScreenOnTap;

  const NavigationItems({
    Key? key,
    this.searchColor,
    this.postColor,
    this.watchlistColor,
    this.myZattabiColor,
    this.showSearchIcon = true,
    this.showGoToHomeScreenIcon = true,
    this.goToAdvertiseScreenOnTap = true,
    this.goToWatchlistScreenOnTap = true,
    this.goToMyZattabiMyAdvertsScreenOnTap = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            showGoToHomeScreenIcon == false
                ? Container(width: 30)
                : _NavigationModel(
                    color:
                        searchColor == null ? Colors.transparent : searchColor,
                    icon: Icons.home_outlined,
                    text: 'Home',
                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return HomeScreen();
                    })),
                  ),
            showSearchIcon == false
                ? Container(width: 60)
                : _NavigationModel(
                    color:
                        searchColor == null ? Colors.transparent : searchColor,
                    icon: Icons.search,
                    text: 'Search',
                    onTap: () => showSearch(
                        context: context, delegate: SearchDelegateWidget()),
                  ),
            _NavigationModel(
                color: postColor == null ? Colors.transparent : postColor,
                icon: Icons.add_box_outlined,
                text: 'Advertise',
                onTap: goToAdvertiseScreenOnTap == false
                    ? () => null
                    : () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return AdvertiseScreen();
                        }))),
            _WatchlistNavigationWidget(
                color: watchlistColor == null
                    ? Colors.transparent
                    : watchlistColor,
                text: 'Watchlist',
                onTap: goToWatchlistScreenOnTap == false
                    ? () => null
                    : () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return WatchlistScreen();
                        }));
                      }),
            Flexible(
              child: _NavigationModel(
                  color: myZattabiColor == null
                      ? Colors.transparent
                      : myZattabiColor,
                  icon: Icons.account_circle_outlined,
                  //  TODO: change myAccount to account name
                  text: 'My Account',
                  onTap: goToMyZattabiMyAdvertsScreenOnTap == false
                      ? () => null
                      : () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return WrapperMyAccount();
                          }));
                        }),
            )
          ],
        ),
      ),
    );
  }
}

class _NavigationModel extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final Function? onTap;

  const _NavigationModel({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.black54,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WatchlistNavigationWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final Function? onTap;

  const _WatchlistNavigationWidget({
    Key? key,
    required this.text,
    this.color,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Transform.rotate(
                angle: pi / 1,
                child: Icon(
                  FontAwesomeIcons.binoculars,
                  size: 20,
                  color: Colors.black54,
                ),
              ),
              Text(
                text,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
