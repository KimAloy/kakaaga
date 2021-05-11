import 'package:flutter/cupertino.dart';
import 'package:kakaaga/models/models.dart';

class AdvertProvider extends ChangeNotifier {
  bool mySwitch = true;

  List<Advert> mySearchResults = [];

  addToSearchResults(Advert advert) {
    mySearchResults.add(advert);
    notifyListeners();
  }

  List<Advert> myAdverts = [];

  List<Advert> watchlisted = [];

  void toggleWatchlisted(Advert advert) {
    advert.isWatchlisted = !advert.isWatchlisted;
    notifyListeners();
  }

  void addToWatchlist(advert) {
    watchlisted.add(advert);
    notifyListeners();
  }

  void removeFromWatchlist(advert) {
    watchlisted.remove(advert);
    notifyListeners();
  }

  List<Advert> advertsList = [
    Advert(
      quantity: 1000,
      quantityUnit: 'matooke',
      images: [
        'assets/matooke.jpg',
      ],
      title: 'Matooke big bunches, mpologoma & musa',
      adStatus: true,
      isWatchlisted: false,
      district: 'Luwero',
      parish: 'Nakikoota',
      listed: '2021-03-01 08:28:29',
      price: 15000,
      advertPhoneNumber: '+256773123658',
      advertiserName: 'Katongole Bosco Kauma Embulakalevu',
      advertiserJoinedDate: '13 May 2021',
      advertiserProfilePicture: 'assets/myUser101.jpg',
      eachCheckbox: true,
      phoneCallOk: true,
      whatsApp: true,
      description: '',
      listingID: '002jd',
    ),
    Advert(
      quantity: 1500,
      quantityUnit: 'broilers',
      eachCheckbox: true,
      phoneCallOk: false,
      whatsApp: true,
      images: ['assets/broilers_1.jpg'],
      title: '6 months old. Very juicy',
      adStatus: true,
      isWatchlisted: false,
      description:
          'Well reared, succulent wings. Go well with all types of food. Broiler chicken ready for sale.',
      district: 'Wakiso',
      parish: 'Kawanda',
      listed: '2021-01-02 08:28:29',
      price: 15000,
      advertPhoneNumber: '+256773123658',
      advertiserName: 'William Wilberforce',
      advertiserJoinedDate: '1 March 2021',
      listingID: '002jghd',
    ),
    Advert(
      quantity: 50,
      title: 'Bananas',
      images: ['assets/matooke_1.jpg'],
      adStatus: true,
      isWatchlisted: false,
      district: 'Masindi',
      parish: 'Kagadi',
      listed: '2021-02-02 08:28:29',
      price: 10000,
      description:
          'Young banana suckers for sale. Ndiizi, Mpologoma, Musa, and Bogoya,',
      advertPhoneNumber: '+256773123658',
      advertiserName: 'Gafabusa Agogo Wilberforce',
      advertiserJoinedDate: '23 December 2021',
      advertiserProfilePicture: 'assets/myUser101.jpg',
      phoneCallOk: false,
      whatsApp: false,
      listingID: '002j234567dfghjvbnd',
    ),
    Advert(
      quantity: 900,
      quantityUnit: 'layers',
      eachCheckbox: true,
      phoneCallOk: false,
      whatsApp: false,
      images: ['assets/off_layers.jpg'],
      title: 'Off layers',
      adStatus: true,
      isWatchlisted: false,
      district: 'Kampala',
      parish: 'Kawempe',
      listed: '2021-03-01 08:28:29',
      price: 35000,
      description: 'Off layers for meat. Chicken for sale',
      advertPhoneNumber: '+256773123658',
      advertiserName: 'Kavuma Arnold',
      advertiserJoinedDate: '1 March 2021',
      advertiserProfilePicture: 'assets/myUser101.jpg',
      listingID: '0gjk02jd',
    ),
    Advert(
      phoneCallOk: true,
      whatsApp: true,
      quantity: 87,
      quantityUnit: 'chicken',
      images: ['assets/broilers_2.jpg'],
      title: 'broilers chicken',
      adStatus: true,
      isWatchlisted: false,
      district: 'Mbale',
      parish: 'Lama',
      listed: '2021-03-02 10:00:29',
      price: 30000,
      description: '6 weeks old',
      advertPhoneNumber: '+256773123658',
      advertiserName: 'Kate Wonderland',
      advertiserJoinedDate: '18 June 2021',
      eachCheckbox: true,
      listingID: 'dtyilkjhgf002jd',
    ),
    Advert(
      phoneCallOk: false,
      whatsApp: true,
      quantity: 2000,
      quantityUnit: 'trays',
      images: ['assets/eggs.jpg'],
      title: 'Eggs',
      adStatus: true,
      isWatchlisted: false,
      district: 'Kiboga',
      parish: 'Mabaale',
      listed: '2020-03-02 08:28:29',
      price: 4000,
      description: 'Local hen eggs',
      advertPhoneNumber: '+256773123658',
      advertiserName: 'Christopher Jjemba',
      advertiserJoinedDate: '1 March 2021',
      advertiserProfilePicture: 'assets/myUser101.jpg',
      listingID: '002j028sdfghd',
    ),
    Advert(
        quantity: 2000,
        quantityUnit: 'kgs',
        eachCheckbox: false,
        phoneCallOk: false,
        whatsApp: true,
        title: 'Vanilla Grade A & B',
        adStatus: true,
        isWatchlisted: false,
        district: 'Luweero',
        parish: 'Kawanda',
        listed: '2021-05-02 12:06:00',
        price: 1200000,
        description:
            'Grade A is 1.2m only.\nGrade B is 1 million only.\nMy vanilla is 4 months slow cured premium grade vanilla',
        advertPhoneNumber: '+256773123658',
        advertiserName: 'James Musoke',
        advertiserJoinedDate: '1 March 2021',
        listingID: '147895wefgbnm002jd',
        images: [
          'assets/vanilla_a.jpg',
          'assets/vanilla_grade_a.jpg',
          'assets/vanilla_grade_b.jpg',
        ]),
    Advert(
        quantity: 300,
        quantityUnit: 'kgs',
        eachCheckbox: false,
        phoneCallOk: false,
        whatsApp: true,
        title: 'Vanilla Grade A',
        adStatus: true,
        isWatchlisted: false,
        district: 'Mukono',
        parish: 'Seeta',
        listed: '2021-03-02 12:06:00',
        price: 1000000,
        description: '4 months slow cured premium grade vanilla',
        advertPhoneNumber: '+256773123658',
        advertiserName: 'Janet Nakiboneka',
        advertiserJoinedDate: '1 March 2021',
        listingID: '147895wefgbnm002jd',
        images: [
          'assets/vanilla_a.jpg',
          'assets/vanilla_grade_a.jpg',
        ]),
    Advert(
        quantity: 7200,
        quantityUnit: 'kgs',
        eachCheckbox: false,
        phoneCallOk: false,
        whatsApp: true,
        title: 'Vanilla Grade B',
        adStatus: true,
        isWatchlisted: false,
        district: 'Mukono',
        parish: 'Seeta',
        listed: '2021-04-02 12:06:00',
        price: 1150000,
        description:
            '4 months slow cured premium grade vanilla. Phytosanity certificate provided',
        advertPhoneNumber: '+256773123658',
        advertiserName: 'Janet Nakiboneka',
        advertiserJoinedDate: '1 March 2021',
        listingID: '147895wefgbnm002jd',
        images: ['assets/vanilla_grade_b.jpg']),
  ];
}
