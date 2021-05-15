import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kakaaga/api/api.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/provider/advert_provider.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:kakaaga/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MyAdvertsScreen extends StatefulWidget {
  @override
  _MyAdvertsState createState() => _MyAdvertsState();
}

class _MyAdvertsState extends State<MyAdvertsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdvertProvider>(context);
    final myAdverts = provider.myAdverts;
    // final myAdverts = provider.advertsList;
    return Scaffold(
      backgroundColor: kScreenBackground2,
      body: StreamBuilder<List<Advert>>(
          stream: FirebaseApi.readAdverts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try later');
            }
            // this refreshes infinitely, hence I've used snapshot.hasData
            // if(snapshot.connectionState == ConnectionState.waiting){
            if (!snapshot.hasData) {
              return buildText('Loading...');
            } else {
              final adverts = snapshot.data;
              final provider = Provider.of<AdvertProvider>(context);
              provider.setAdverts(adverts!);

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      NavigationItems(
                        myZattabiColor: kScreenBackground2,
                        goToMyZattabiMyAdvertsScreenOnTap: false,
                      ),
                      Container(color: kColorOne, height: 4),
                      const SizedBox(height: 2),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back, size: 24),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                Spacer(),
                                MyOutlineButton(
                                  textColor: kColorOne,
                                  text: 'My Adverts',
                                ),
                                const SizedBox(width: 10),
                                MyOutlineButton(
                                  onPressed: () {
                                    print('"profile and account"');
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return MyProfileAndAccountScreen();
                                    }));
                                  },
                                  text: 'My account',
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      myAdverts.length == 0
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 50),
                                  Icon(
                                    FontAwesomeIcons.frownOpen,
                                    size: 45,
                                    color: Colors.black26,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Such emptyness!\nOnce you post and advert,\n you'll see it listed here",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black45,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: myAdverts.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(height: 5),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Advert myAdvert = myAdverts[index];

                                    if (myAdvert.images!.isEmpty) {
                                      return ForSaleNoImageContainer(
                                          advertData: myAdvert,
                                          showWatchlistIcon: false,
                                          showDistance: false,
                                          showAdvertStatusSwitch: true,
                                          onTap: () {
                                            print(
                                                '"For Sale tapped has NO image"');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) {
                                                  return MyAdvertsDetailsScreen(
                                                    index: index,
                                                    advertData: myAdvert,
                                                    showWatchlistIcon: false,
                                                  );
                                                },
                                              ),
                                            ).whenComplete(
                                                () => setState(() => {}));
                                          });
                                    } else {
                                      // if (myAdvert.images != null) {
                                      return ForSaleContainerHasImage(
                                          advertData: myAdvert,
                                          showWatchlistIcon: false,
                                          showDistance: false,
                                          showAdvertStatusSwitch: true,
                                          onTap: () {
                                            print(
                                                '"For Sale tapped has image"');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) {
                                                  return MyAdvertsDetailsScreen(
                                                    index: index,
                                                    advertData: myAdvert,
                                                    showWatchlistIcon: false,
                                                  );
                                                },
                                              ),
                                            ).whenComplete(
                                                () => setState(() => {}));
                                          });
                                    }
                                    // else {
                                    //   return Center(
                                    //     child: Container(
                                    //       child: Text(
                                    //         'my_zattabi_my_adverts_screen Error. Take a look there',
                                    //         style: TextStyle(
                                    //             fontSize: 20,
                                    //             fontWeight: FontWeight.bold),
                                    //       ),
                                    //     ),
                                    //   );
                                    // }
                                  },
                                ),
                                const SizedBox(height: 100),
                              ],
                            ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
