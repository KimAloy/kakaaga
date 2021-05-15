import 'package:flutter/cupertino.dart';
import 'package:kakaaga/api/api.dart';
import 'package:kakaaga/models/models.dart';

class AdvertProvider extends ChangeNotifier {
  bool mySwitch = true;

  List<Advert> mySearchResults = [];

  addToSearchResults(Advert advert) {
    mySearchResults.add(advert);
    notifyListeners();
  }

  List<Advert> watchlisted = [];

  // void toggleWatchlisted(Advert advert) {
  //   advert.isWatchlisted = !advert.isWatchlisted;
  //   notifyListeners();
  // }

  void addToWatchlist(advert) {
    watchlisted.add(advert);
    notifyListeners();
  }

  void removeFromWatchlist(advert) {
    watchlisted.remove(advert);
    notifyListeners();
  }

  List<Advert> _myAdverts = [];

  List<Advert> _advertsList = [];

  List<Advert> get advertsList => _advertsList;

  List<Advert> get myAdverts => _myAdverts;

  void addAdvert(Advert advert) => FirebaseApi.createAdvert(advert);

  void deleteAdvertProvider(Advert advert) =>
      FirebaseApi.deleteAdvertApi(advert);

  void editAdvertProvider({
    required Advert advert,
    required String title,
    required int price,
    required int quantity,
    required String quantityUnit,
    required String description,
    required String phoneNumber,
    required String parish,
    required String district,
    required bool whatsApp,
    required bool phoneCallOk,
    required bool eachCheckbox,
  }) {
    advert.title = title;
    advert.price = price;
    advert.quantity = quantity;
    advert.quantityUnit = quantityUnit;
    advert.description = description;
    advert.phoneNumber = phoneNumber;
    advert.parish = parish;
    advert.district = district;
    advert.whatsApp = whatsApp;
    advert.phoneCallOk = phoneCallOk;
    advert.eachCheckbox = eachCheckbox;

    FirebaseApi.editAdvertApi(advert);
  }

  void setAdverts(List<Advert>? adverts) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _myAdverts = adverts!;
        notifyListeners();
      });
}
