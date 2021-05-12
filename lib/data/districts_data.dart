import 'package:kakaaga/config/config.dart';

class DistrictModel {
  final String name;
  final double lat;
  final double lng;

  DistrictModel({
    required this.name,
    required this.lat,
    required this.lng,
  });

  @override
  toString() => '$name, ${lat.toString()} : ${lng.toString()}';
}

class MapDistanceModel {
  final String district;
  final int distance;

  MapDistanceModel({
    required this.district,
    required this.distance,
  });

  @override
  toString() => '$district : ${distance.toString()}';
}

class DistrictsLatLongData {
  // static calculateMyDistance() {
  static calculateMyDistance(String query) {
    // Calculate distance in kilometers

    List<dynamic> data = DistrictsLatLongData.districts;

    /// mapping query to the 'data' list above
    // String query = 'kam';
    List queryList = data.where((e) {
      final district = e.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return district.contains(searchLower);
    }).toList();
    // print(ob);

    /// returning the first indexed object at index 0
    /// I use index 0 because the queryList can be greater than 1 object
    double queryLatitude = queryList[0].lat;
    double queryLongitude = queryList[0].lng;
    // print(queryLatitude);
    // print(queryLongitude);
    // print('This is it, lat: ${queryList[0].lat}, lng: ${queryList[0].lng}');

    /// actual calculation using the good old for loop
    List<MapDistanceModel> allDistricts = [];
    for (var i = 0; i < data.length; i++) {
      int distance = kcalculateDistance(
              // data[47].lat, data[47].lng, data[i].lat, data[i].lng)
              queryLatitude,
              queryLongitude,
              data[i].lat,
              data[i].lng)
          .round();
      allDistricts.add(
        MapDistanceModel(district: data[i].name, distance: distance),
      );
    }

    /// filtering allDistricts list to districts & their distance
    /// within 60 kilometers
    List<MapDistanceModel> radius60km =
        allDistricts.where((e) => e.distance <= 60).toList();
    // print('within 60km radius: $radius60km');

    /// dropping off the distance to show district names only
    List<String> radius60kmDistricts = [];
    for (var i in radius60km) {
      radius60kmDistricts.add(i.district);
    }
    // print('Districts within 60km radius only: $radius60kmDistricts');
    // print('Total districts within 60km radius: ${radius60km.length}');
    return radius60kmDistricts;

    // List<MapDistanceModel> radius100km =
    //     allDistricts.where((e) => e.distance <= 100).toList();
    //
    // List radius100kmDistricts = [];
    // for (var i in radius100km) {
    //   // print(i.district);
    //   radius100kmDistricts.add(i.district);
    //   // return i.district;
    // }
    // // print('within 100km radius: $radius100km');
    // print('within 100km radius districts only: $radius100kmDistricts');
    // print('Total districts within 100km radius: ${radius100km.length}');
  }

  static List<DistrictModel> getSuggestions(String query) =>
      List.of(districts).where((district) {
        final districtLower = district.name.toLowerCase();
        final queryLower = query.toLowerCase();
        return districtLower.contains(queryLower);
      }).toList();

  static List<DistrictModel> districts = [
    DistrictModel(name: 'Abim', lat: 2.706698, lng: 33.659534),
    DistrictModel(name: 'Adjumani', lat: 3.376800, lng: 31.793410),
    DistrictModel(name: 'Agago', lat: 2.916290, lng: 33.357880),
    DistrictModel(name: 'Alebtong', lat: 2.260170, lng: 33.238390),
    DistrictModel(name: 'Amolatar', lat: 1.6391243, lng: 32.7857476),
    DistrictModel(name: 'Amudat', lat: 1.8261958, lng: 34.9312698),
    DistrictModel(name: 'Amuria', lat: 2.068622, lng: 33.6207178),
    DistrictModel(name: 'Amuru', lat: 3.1288655, lng: 32.1024833),
    DistrictModel(name: 'Apac', lat: 1.9173441, lng: 32.6476691),
    DistrictModel(name: 'Arua', lat: 2.9479914, lng: 31.1256453),
    DistrictModel(name: 'Budaka', lat: 1.0658317, lng: 34.0208639),
    DistrictModel(name: 'Bududa', lat: 1.042117, lng: 34.3987549),
    DistrictModel(name: 'Bugiri', lat: 0.5206015, lng: 33.7721578),
    DistrictModel(name: 'Bugweri', lat: 0.6900538, lng: 33.5988971),
    DistrictModel(name: 'Buhweju', lat: -0.3203668, lng: 30.3162197),
    DistrictModel(name: 'Buikwe', lat: 0.3031612, lng: 33.0390868),
    DistrictModel(name: 'Bukedea', lat: 1.3707048, lng: 34.1424762),
    DistrictModel(name: 'Bukomansimbi', lat: -0.1268703, lng: 31.6225952),
    DistrictModel(name: 'Bukwa', lat: 1.2549848, lng: 34.6924324),
    DistrictModel(name: 'Bulambuli', lat: 1.3581117, lng: 34.2803799),
    DistrictModel(name: 'Buliisa', lat: 1.9228563, lng: 31.3917566),
    DistrictModel(
        name: 'Bundibugyo', lat: 0.710097074508667, lng: 30.063079833984375),
    DistrictModel(name: 'Bunyangabu', lat: 0.37525, lng: 30.23643),
    DistrictModel(name: 'Bushenyi', lat: -0.4820626, lng: 30.1683591),
    DistrictModel(name: 'Busia', lat: 0.3914371, lng: 34.0180586),
    DistrictModel(name: 'Butaleja', lat: 0.8612477, lng: 33.8779637),
    DistrictModel(name: 'Butambala', lat: 0.1642653, lng: 32.1352371),
    DistrictModel(name: 'Butebo', lat: 1.172778, lng: 33.884444),
    DistrictModel(name: 'Buvuma', lat: -0.367638, lng: 33.1976948),
    DistrictModel(name: 'Buyende', lat: 1.235238, lng: 33.1703533),
    DistrictModel(name: 'Dokolo', lat: 1.9100822, lng: 33.0786648),
    DistrictModel(name: 'Gomba', lat: 0.2054379, lng: 31.7287012),
    DistrictModel(name: 'Gulu', lat: 2.8763527, lng: 32.4190553),
    DistrictModel(name: 'Hoima', lat: 1.4636618, lng: 31.1332949),
    DistrictModel(name: 'Ibanda', lat: -0.0598851, lng: 30.49229),
    DistrictModel(name: 'Iganga', lat: 0.6782174, lng: 33.5522381),
    DistrictModel(name: 'Isingiro', lat: -0.839118, lng: 30.926),
    DistrictModel(name: 'Jinja', lat: 0.5465468, lng: 33.2248169),
    DistrictModel(name: 'Kaabong', lat: 3.644623, lng: 34.0173683),
    DistrictModel(name: 'Kabale', lat: -1.234053, lng: 30.0166007),
    DistrictModel(name: 'Kabarole', lat: 0.6222824, lng: 30.2645682),
    DistrictModel(name: 'Kaberamaido', lat: 1.7600932, lng: 33.2532219),
    DistrictModel(name: 'Kagadi', lat: 0.9473399, lng: 30.8039626),
    DistrictModel(name: 'Kakumiro', lat: 0.7812042, lng: 31.32445),
    DistrictModel(name: 'Kalangala', lat: -0.6141908, lng: 32.375565),
    DistrictModel(name: 'Kaliro', lat: 1.0833677, lng: 33.4822171),
    DistrictModel(name: 'Kalungu', lat: -0.0973887, lng: 31.8104873),
    DistrictModel(name: 'Kampala', lat: 0.3177137, lng: 32.5813539),
    DistrictModel(name: 'Kamuli', lat: 0.9422474, lng: 33.1263004),
    DistrictModel(name: 'Kamwenge', lat: 0.1968292, lng: 30.4587039),
    DistrictModel(name: 'Kanungu', lat: -0.7063481, lng: 29.7142332),
    DistrictModel(name: 'Kapchorwa', lat: 1.3310606, lng: 34.3961656),
    DistrictModel(name: 'Kapelebyong', lat: 2.293333, lng: 33.830833),
    DistrictModel(name: 'Karenga', lat: 3.5676805, lng: 33.6950902),
    DistrictModel(name: 'Kasanda', lat: 0.556667, lng: 31.802222),
    DistrictModel(name: 'Kasese', lat: 0.1310412, lng: 30.0047968),
    DistrictModel(name: 'Katakwi', lat: 1.9733285, lng: 34.0573389),
    DistrictModel(name: 'Kayunga', lat: 0.9924074, lng: 32.8592384),
    DistrictModel(name: 'Kazo', lat: -0.0528218, lng: 30.7562011),
    DistrictModel(name: 'Kibaale', lat: 0.9276864, lng: 31.0027294),
    DistrictModel(name: 'Kiboga', lat: 0.8592559, lng: 31.9283489),
    DistrictModel(name: 'Kibuku', lat: 1.0573754, lng: 33.8056152),
    DistrictModel(name: 'Kikuube', lat: 1.5544409, lng: 31.6611232),
    DistrictModel(name: 'Kiruhura', lat: -0.2490242, lng: 30.8439583),
    DistrictModel(name: 'Kiryandongo', lat: 1.636528, lng: 31.308345),
    DistrictModel(name: 'Kisoro', lat: -1.1980545, lng: 29.670308),
    DistrictModel(name: 'Kitagwenda', lat: -0.1112757, lng: 30.3957039),
    DistrictModel(name: 'Kitgum', lat: 3.4438845, lng: 33.4841172),
    DistrictModel(name: 'Koboko', lat: 3.5351124, lng: 30.984843),
    DistrictModel(name: 'Kole', lat: 2.3015354, lng: 32.7356416),
    DistrictModel(name: 'Kotido', lat: 3.0335593, lng: 34.0388576),
    DistrictModel(name: 'Kumi', lat: 1.4565401, lng: 33.9219127),
    DistrictModel(name: 'Kwania', lat: 1.8736928, lng: 32.9607562),
    DistrictModel(name: 'Kween', lat: 1.3516649, lng: 34.5635807),
    DistrictModel(name: 'Kyankwanzi', lat: 1.093347, lng: 31.6813924),
    DistrictModel(name: 'Kyegegwa', lat: 0.4822132, lng: 31.0002048),
    DistrictModel(name: 'Kyenjojo', lat: 0.6454644, lng: 30.6583154),
    DistrictModel(name: 'Kyotera', lat: -0.7031161, lng: 31.4143237),
    DistrictModel(name: 'Lamwo', lat: 3.5248125, lng: 32.6576273),
    DistrictModel(name: 'Lira', lat: 2.2456918, lng: 32.896244),
    DistrictModel(name: 'Luuka', lat: 0.8199341, lng: 33.3268941),
    DistrictModel(name: 'Luweero', lat: 0.8456457, lng: 32.601848),
    DistrictModel(name: 'Lwengo', lat: -0.35, lng: 30.416667),
    DistrictModel(name: 'Lyantonde', lat: -0.2595983, lng: 31.1836376),
    DistrictModel(name: 'Madi-Okollo', lat: 2.6490798, lng: 31.144379),
    DistrictModel(name: 'Manafwa', lat: 2.65219, lng: 31.14576),
    DistrictModel(name: 'Maracha', lat: 3.2478417, lng: 30.9279148),
    DistrictModel(name: 'Masaka', lat: -0.483142, lng: 31.8318895),
    DistrictModel(name: 'Masindi', lat: 1.6917384, lng: 31.773826),
    DistrictModel(name: 'Mayuge', lat: -0.1457318, lng: 33.5894569),
    DistrictModel(name: 'Mbale', lat: 1.0020262, lng: 34.1978675),
    DistrictModel(name: 'Mbarara', lat: -0.5228382, lng: 30.6341274),
    DistrictModel(name: 'Mitooma', lat: -0.6061015, lng: 30.0072393),
    DistrictModel(name: 'Mityana', lat: 0.4560686, lng: 32.0768024),
    DistrictModel(name: 'Moroto', lat: 2.6156454, lng: 34.6399817),
    DistrictModel(name: 'Moyo', lat: 3.4896136, lng: 31.5876587),
    DistrictModel(name: 'Mpigi', lat: 0.225, lng: 32.31361),
    DistrictModel(name: 'Mubende', lat: 0.5154423, lng: 31.5658141),
    DistrictModel(name: 'Mukono', lat: -0.0523245, lng: 32.7262557),
    DistrictModel(name: 'Nabilatuk', lat: 2.020556, lng: 34.584167),
    DistrictModel(name: 'Nakapiripirit', lat: 1.974176, lng: 34.6095899),
    DistrictModel(name: 'Nakaseke', lat: 1.0022373, lng: 32.1758087),
    DistrictModel(name: 'Nakasongola', lat: 1.3204358, lng: 32.4894347),
    DistrictModel(name: 'Namayingo', lat: -0.2367412, lng: 33.8124371),
    DistrictModel(name: 'Namisindwa', lat: 0.9029962, lng: 34.3480246),
    DistrictModel(name: 'Namutumba', lat: 0.8869852, lng: 33.6653494),
    DistrictModel(name: 'Napak', lat: 2.3981727, lng: 34.1714176),
    DistrictModel(name: 'Nebbi', lat: 2.4679181, lng: 31.2823033),
    DistrictModel(name: 'Ngora', lat: 1.4988837, lng: 33.7729298),
    DistrictModel(name: 'Ntoroko', lat: 0.9909204, lng: 30.3883147),
    DistrictModel(name: 'Ntungamo', lat: -0.9537516, lng: 30.3031537),
    DistrictModel(name: 'Nwoya', lat: 2.5283587, lng: 31.8708765),
    DistrictModel(name: 'Obongi', lat: 3.241824, lng: 31.551931),
    DistrictModel(name: 'Omoro', lat: 2.576256, lng: 32.354158),
    DistrictModel(name: 'Rukiga', lat: 0.466670, lng: 30.13333),
    DistrictModel(name: 'Rukungiri', lat: -0.697403, lng: 29.8917364),
    DistrictModel(name: 'Otuke', lat: 2.4784334, lng: 33.3933562),
    DistrictModel(name: 'Oyam', lat: 2.3489345, lng: 32.423386),
    DistrictModel(name: 'Pader', lat: 2.8896583, lng: 32.8961763),
    DistrictModel(name: 'Pakwach', lat: 2.4608979, lng: 31.498716),
    DistrictModel(name: 'Pallisa', lat: 1.2106561, lng: 33.7593726),
    DistrictModel(name: 'Rakai', lat: -0.7079013, lng: 31.4044819),
    DistrictModel(name: 'Rubanda', lat: -1.212222, lng: 29.862778),
    DistrictModel(name: 'Rubirizi', lat: -0.2557913, lng: 29.9365),
    DistrictModel(name: 'Rwampara', lat: -0.746695, lng: 30.493850),
    DistrictModel(name: 'Sembabule', lat: -0.0526845, lng: 31.4089655),
    DistrictModel(name: 'Serere', lat: 1.4916989, lng: 33.3568368),
    DistrictModel(name: 'Sheema', lat: -0.591872, lng: 30.3740417),
    DistrictModel(name: 'Sironko', lat: 1.1883856, lng: 34.2977349),
    DistrictModel(name: 'Soroti', lat: 1.7906288, lng: 33.6060706),
    DistrictModel(name: 'Terego', lat: 3.141548, lng: 31.007119),
    DistrictModel(name: 'Tororo', lat: 0.7407421, lng: 34.1026862),
    DistrictModel(name: 'Wakiso', lat: 0.2169668, lng: 32.5118713),
    DistrictModel(name: 'Yumbe', lat: 3.4920316, lng: 31.284616),
    DistrictModel(name: 'Zombo', lat: 2.5251164, lng: 30.8897323),
  ];
}
