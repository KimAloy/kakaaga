import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/provider/advert_provider.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:provider/provider.dart';

class SearchDelegateWidget extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search for Agriproduct';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      hintColor: Colors.white,
      primaryColor: kColorOne,
      textTheme: theme.textTheme.copyWith(
        headline6: theme.textTheme.headline6!.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        print('"pop back arrow tapped"');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _EmptyMessage();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<AdvertProvider>(context);
    List mySearchResults = provider.mySearchResults;
    Function myResults = provider.addToSearchResults;

    List myforSaleResults(String query) {
      List advertsList = provider.advertsList;
      List _myList = advertsList
              .where((element) =>
                  element.title!.toLowerCase().contains(query.toLowerCase()))
              .toList() +
          advertsList
              .where((element) => element.description!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
      return _myList.toSet().toList();
    }

    myforSaleListToShow() {
      List forSaleListResults = myforSaleResults(query);
      for (int i = 0; i < forSaleListResults.length; i++) {
        var data = forSaleListResults[i];
        myResults(Advert(
          adStatus: data.adStatus,
          quantity: data.quantity,
          quantityUnit: data.quantityUnit,
          images: data.images,
          title: data.title,
          district: data.district,
          parish: data.parish,
          createdTime: data.createdTime,
          price: data.price,
          phoneNumber: data.phoneNumber,
          advertiserName: data.advertiserName,
          advertiserJoinedDate: data.advertiserJoinedDate,
          advertiserProfilePicture: data.advertiserProfilePicture,
          description: data.description,
          eachCheckbox: data.eachCheckbox,
          whatsApp: data.whatsApp,
          phoneCallOk: data.phoneCallOk,
          // isWatchlisted: data.isWatchlisted,
        ));
      }
    }

    List forSaleListResults = myforSaleResults(query);

    if (query.length == 0) {
      return Container();
    } else {
      return Column(
        children: [
          _SearchAppBarItemsList(
            text: '${forSaleListResults.length} ',
            text2: "'$query' for Sale Ads",
            onTap: () {
              print('"for sale tapped"');

              if (forSaleListResults.isEmpty) {
                showResults(context); // shows buildResults
              } else {
                // Very VERY IMPORTANT but double edged sword!.
                // It clears() for Sale OR Wanted page of previous search data
                // BUT it clears the state of the Watchlisted item
                mySearchResults.clear();
                Navigator.of(context).pop();
                myforSaleListToShow();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchResultsScreen();
                    },
                  ),
                );
              }
            },
          ),
          Divider(height: 1),
        ],
      );
    }
  }
}

class _SearchAppBarItemsList extends StatelessWidget {
  final Function? onTap;
  final String text;
  final String text2;

  const _SearchAppBarItemsList({
    Key? key,
    this.onTap,
    required this.text,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              splashColor: kColorThree,
              onTap: onTap as void Function()?,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: text,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: text2,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: kColorOne,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80),
          Container(
            height: 100,
            width: 220,
            child: Image.asset(
              'assets/searchDelegate.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "Always tap on ",
              style: kSearchDelegateTextStyle,
            ),
            TextSpan(
              text: '"for Sale Ads"',
              style: kSearchDelegateRichTextStyle,
            ),
          ])),
          SizedBox(height: 20),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: "If",
              style: kSearchDelegateTextStyle,
            ),
            TextSpan(
              text: ' " \'0\' for Sale Ads "',
              style: kSearchDelegateRichTextStyle,
            ),
            TextSpan(
              text: ", try searching using a different word.",
              style: kSearchDelegateTextStyle,
            ),
          ])),
        ],
      ),
    );
  }
}
