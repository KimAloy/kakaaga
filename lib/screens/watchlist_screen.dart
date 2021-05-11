import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/provider/advert_provider.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:kakaaga/widgets/widgets.dart';
import 'package:provider/provider.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdvertProvider>(context);
    final watchlisted = provider.watchlisted;
    return Scaffold(
      backgroundColor: kScreenBackground2,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NavigationItems(
                watchlistColor: kScreenBackground2,
                goToWatchlistScreenOnTap: false,
              ),
              AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  'Watchlist',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: kColorOne,
                elevation: 0.0,
              ),
              watchlisted.length == 0
                  ? Column(
                      children: [
                        const SizedBox(height: 80),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 60,
                                      child: Center(
                                        child: Transform.rotate(
                                          angle: pi / 1,
                                          child: Icon(
                                            FontAwesomeIcons.binoculars,
                                            size: 40,
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Icon(
                                        Icons.add_circle,
                                        size: 30,
                                        color: Colors.black26,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Such emptyness!\nOnce you tap an advert's Watchlist icon, you'll see it listed here",
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: watchlisted.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 5),
                      itemBuilder: (BuildContext context, int index) {
                        final Advert myAdvert = watchlisted[index];
                        return myAdvert.images == null
                            ? ForSaleNoImageContainer(
                                advertData: myAdvert,
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SearchResultsAdvertDetailsScreen(
                                        advertData: myAdvert);
                                  }));
                                })
                            : ForSaleContainerHasImage(
                                advertData: myAdvert,
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SearchResultsAdvertDetailsScreen(
                                        advertData: myAdvert);
                                  }));
                                });
                      },
                    ),
              const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
