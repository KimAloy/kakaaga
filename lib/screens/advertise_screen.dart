import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/provider/advert_provider.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:kakaaga/widgets/add_photos.dart';
import 'package:kakaaga/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class AdvertiseScreen extends StatefulWidget {
  @override
  _AdvertiseScreenState createState() => _AdvertiseScreenState();
}

class _AdvertiseScreenState extends State<AdvertiseScreen> {
  int? quantity;
  String? quantityUnit;
  int? price;
  bool eachCheckbox = true;
  String? title;
  String? description;
  List? images;
  String? district;
  String? parish;
  String? phoneNumber;
  bool whatsApp = true;
  bool phoneCallOk = true;
  DateTime? createdTime;
  String? advertiserName;
  DateTime? advertiserJoinedDate;
  String? advertiserProfilePicture;
  bool adStatus = true;
  bool addPhotosError = false;

  final _quantityController = TextEditingController();
  final _quantityUnitController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  final _parishController = TextEditingController();
  final _districtController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  // final _firestore = FirebaseFirestore.instance.collection('adverts');

  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    /// get current logged in user
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print('advertise screen: ${user.email}');
      }
    } catch (e) {
      print(e);
    }

    /// get user profile information from user collection
    await FirebaseFirestore.instance
        .collection('users')
        .where(FieldPath.documentId, isEqualTo: loggedInUser!.uid)
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        Map<String, dynamic> documentData = event.docs.single.data();
        // print('phone number again: ${documentData['phoneNumber']}');
        setState(() {
          phoneNumber = documentData['phoneNumber'];
          advertiserName = documentData['name'];
          advertiserJoinedDate = Utils.toDateTime(documentData['joinedDate']);
          advertiserProfilePicture = documentData['profilePicture'];
        });
      }
    });
  }

  final _form = GlobalKey<FormState>();
  String errorMessage = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final _userPhoneNumberController = TextEditingController(text: phoneNumber);
    // print('phoneNumber is this: $phoneNumber');

    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kColorOne)),
        opacity: 0.3,
        // color: kColorOne,
        isLoading: loading,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NavigationItems(
                      postColor: kScreenBackground2,
                      goToAdvertiseScreenOnTap: false,
                    ),
                    AppBar(
                      title: Text(
                        'New Advert',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: kColorOne,
                      elevation: 0.0,
                    ),
                    // GetUserName(dataType: 'phoneNumber'),
                    // GetUserName(dataType: 'joinedDate'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 15),
                        Quantity(
                          quantityController: _quantityController,
                          quantityUnitController: _quantityUnitController,
                        ),
                        const SizedBox(height: 15),
                        Price(
                          controller: _priceController,
                          eachCheckbox: eachCheckbox,
                          onEachSelected: (value) {
                            setState(() {
                              eachCheckbox = value;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        AdvertTitle(controller: _titleController),
                        const SizedBox(height: 15),
                        Description(
                            title: "Description (Optional)",
                            hintText: 'Type description here...',
                            controller: _descriptionController),
                        const SizedBox(height: 15),
                        AddPhotos(
                          //  TODO: file_picker plugin doesn't
                          // work, multi-image picker uses deprecated api, so use default google picker
                          title: 'Add photos (Optional)',
                          addPhotosError: addPhotosError,
                        ),
                        const SizedBox(height: 15),
                        Location(
                          districtController: _districtController,
                          districtValidator: (text) =>
                              text.isEmpty ? 'Please enter a District*' : null,
                          parishController: _parishController,
                          parishValidator: (text) =>
                              text.isEmpty ? 'Please enter a Parish*' : null,
                        ),
                        const SizedBox(height: 15),
                        MyPreferredContact(
                          // initialValue: phoneNumber,
                          controller: _userPhoneNumberController,
                          // onChanged: (value) =>
                          //     setState(() => phoneNumber = value),
                          title: 'Preferred Contact*',
                          validator: (text) => text.isEmpty
                              ? 'Please enter a valid phone number*'
                              : null,
                          whatsApp: whatsApp,
                          phoneCallOk: phoneCallOk,
                          onSelectedPhoneCallOk: (value) {
                            setState(() {
                              phoneCallOk = value;
                            });
                          },
                          onSelectedWhatsApp: (value) {
                            setState(() {
                              whatsApp = value;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        topLeft: Radius.circular(5),
                      ),
                      child: Container(
                        color: kScreenBackground,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 10),
                            errorMessage == ''
                                ? const SizedBox.shrink()
                                : Center(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6, left: 5),
                                          child: Text(
                                            'Please fill in the required fields marked*',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                            ActionButton(
                                text: 'Post Advert',
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                onPressed: () {
                                  print('post advert button tapped');
                                  // _validateForm();
                                  final isValid =
                                      _form.currentState!.validate();
                                  if (!isValid) {
                                    setState(() {
                                      errorMessage = 'a';
                                      return;
                                      loading = false;
                                    });
                                  } else {
                                    setState(() => loading = true);
                                    final advert = Advert(
                                      advertiserEmail: loggedInUser!.email,
                                      quantity: int.parse(_quantityController
                                          .text
                                          .replaceAll(',', '')
                                          .toString()),
                                      quantityUnit:
                                          _quantityUnitController.text,
                                      title: _titleController.text,
                                      createdTime: DateTime.now(),
                                      price: int.parse(_priceController.text
                                          .replaceAll(',', '')
                                          .toString()),
                                      phoneNumber:
                                          _userPhoneNumberController.text,
                                      whatsApp: whatsApp,
                                      phoneCallOk: phoneCallOk,
                                      description: _descriptionController.text,
                                      adStatus: true,
                                      district: _districtController.text,
                                      parish: _parishController.text,
                                      images: [],
                                      eachCheckbox: eachCheckbox,
                                      advertiserName: advertiserName,
                                      advertiserJoinedDate:
                                          advertiserJoinedDate,
                                    );

                                    final provider =
                                        Provider.of<AdvertProvider>(context,
                                            listen: false);
                                    provider.addAdvert(advert);

                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return MyAdvertsScreen();
                                        },
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Succesfully listed'),
                                        backgroundColor: kColorOne,
                                      ),
                                    );
                                  }
                                }),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
