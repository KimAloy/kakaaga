import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/data/districts_data.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/provider/advert_provider.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:kakaaga/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late List<Advert> adverts;

  void latestListings() {
    setState(() {
      adverts.sort((a, b) => b.listed!.compareTo(a.listed!));
    });
  }

  void sortLowestPrice() {
    setState(() {
      adverts.sort((a, b) => a.price!.compareTo(b.price!));
    });
  }

  void sortHighestPrice() {
    setState(() {
      adverts.sort((a, b) => b.price!.compareTo(a.price!));
    });
  }

  void sortLowestQuantity() {
    setState(() {
      adverts.sort((a, b) => a.quantity!.compareTo(b.quantity!));
    });
  }

  void sortHighestQuantity() {
    setState(() {
      adverts.sort((a, b) => b.quantity!.compareTo(a.quantity!));
    });
  }

  String query = '';
  bool searchNearby = true;
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AdvertProvider>(context, listen: false);
    adverts = provider.mySearchResults;
    latestListings();
  }

  bool incudeNearbySwitch = true;

  void searchListByDistrict(String query) {
    final provider = Provider.of<AdvertProvider>(context, listen: false);
    final _adverts = provider.mySearchResults.where((element) {
      final district = element.district!.toLowerCase();
      final searchLower = query.toLowerCase();
      return district.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.adverts = _adverts;
    });
  }

  final districtController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedDistrict;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScreenBackground2,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavigationItems(searchColor: kScreenBackground2),
                AppBar(
                  backgroundColor: kColorOne,
                  elevation: 0.0,
                  title: Text('Mazaawo'),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        searchDistrict(),
                        const SizedBox(height: 7.5),
                        Row(
                          children: [
                            Text(
                              'Include nearby districts',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 15),
                            includeNearbySwitchWidget(),
                          ],
                        ),
                        const SizedBox(height: 7.5),
                        Text(
                          adverts.length == 0
                              ? 'No results available'
                              : adverts.length == 1
                                  ? 'Showing ${adverts.length} result'
                                  : 'Showing ${adverts.length} results',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 15),
                        SortDialogButton(
                          onChanged: (value) {
                            setState(() {
                              if (value == 0) {
                                latestListings();
                              } else if (value == 1) {
                                sortLowestPrice();
                              } else if (value == 2) {
                                sortHighestPrice();
                              } else if (value == 3) {
                                sortLowestQuantity();
                              } else if (value == 4) {
                                sortHighestQuantity();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: adverts.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 5),
                  itemBuilder: (context, index) {
                    final Advert advertItem = adverts[index];
                    return advertItem.images == null
                        ? ForSaleNoImageContainer(
                            advertData: advertItem,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SearchResultsAdvertDetailsScreen(
                                    advertData: advertItem);
                              }));
                            })
                        : ForSaleContainerHasImage(
                            advertData: advertItem,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SearchResultsAdvertDetailsScreen(
                                    advertData: advertItem);
                              }));
                            });
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget includeNearbySwitchWidget() {
    return Switch.adaptive(
        activeColor: kColorOne,
        value: incudeNearbySwitch,
        inactiveThumbColor: Colors.brown,
        inactiveTrackColor: Colors.black54,
        // TODO: Implement switch to include nearby districts
        onChanged: (showNearbySwitch) =>
            setState(() => this.incudeNearbySwitch = showNearbySwitch));
  }

  Widget searchDistrict() => Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TypeAheadFormField<String?>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: districtController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 11, 10, 11),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Colors.black38,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kColorOne),
                    ),
                    labelText: 'Search district',
                    labelStyle: TextStyle(color: Colors.black38),
                    border: OutlineInputBorder(),
                  ),
                ),
                suggestionsCallback: DistrictsData.getSuggestions,
                itemBuilder: (context, String? suggestion) => ListTile(
                  title: Text(suggestion!),
                ),
                onSuggestionSelected: (String? suggestion) =>
                    districtController.text = suggestion!,
                onSaved: (value) => selectedDistrict = value,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                final form = _formKey.currentState!;
                if (form.validate()) {
                  form.save();
                  print('The district is: $selectedDistrict');
                  setState(() {
                    searchListByDistrict(selectedDistrict!);
                  });
                }
              },
              child: Container(
                height: 49,
                width: 49,
                decoration: BoxDecoration(
                    color: kColorOne, borderRadius: BorderRadius.circular(5.0)),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      );
}
