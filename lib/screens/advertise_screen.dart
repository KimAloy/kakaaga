import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/screens/screens.dart';
import 'package:kakaaga/widgets/add_photos.dart';
import 'package:kakaaga/widgets/widgets.dart';

class AdvertiseScreen extends StatefulWidget {
  @override
  _AdvertiseScreenState createState() => _AdvertiseScreenState();
}

class _AdvertiseScreenState extends State<AdvertiseScreen> {
  final _quantityController = TextEditingController();
  final _quantityUnitController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  final _userPhoneNumberController = TextEditingController();
  final _parishController = TextEditingController();
  final _districtController = TextEditingController();

  // String? userPhoneNumber = UserData.user.userPhoneNumber;
  bool whatsApp = true;
  bool phoneCallOk = true;
  bool addPhotosError = false;
  bool eachCheckbox = true;
  int locationValue = 0;

  // @override
  // void initState() {
  //   // super.initState();
  //   // setState(() {
  //   // _userPhoneNumberController.text = userPhoneNumber!;
  //   // });
  //   return super.initState();
  // }

  final _form = GlobalKey<FormState>();
  String errorMessage = '';

  void _validateForm() {
    final isValid = _form.currentState!.validate();
    setState(() {
      if (!isValid) {
        errorMessage = 'a';
        return;
      } else {
        // DateTime now = DateTime.now();

        // myAdvertsController!.myAdverts.add(Advert(
        //   advertType: typeOfAdvertController!.typeOfAdvertTitle,
        //   quantity: _quantityController.text.toString().isEmpty
        //       ? 0
        //       : int.parse(
        //           _quantityController.text.replaceAll(',', '').toString()),
        //   quantityUnit: _quantityUnitController.text,
        //   price:
        //       int.parse(_priceController.text.replaceAll(',', '').toString()),
        //   eachCheckbox: eachCheckbox,
        //   advertPhoneNumber: _userPhoneNumberController.text,
        //   title: _titleController.text,
        //   description: _descriptionController.text,
        //   district: _districtController.text,
        //   parish: _parishController.text,
        //   listed: '$now',
        //   whatsApp: true,
        //   phoneCallOk: true,
        //   images: [
        //
        //   ],
        //   adStatus: true,
        //   listingID: _listingID,
        //   isWatchlisted: false,
        // )
        // );
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                      title: 'Add photos (Optional)*',
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
                      controller: _userPhoneNumberController,
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
                              _validateForm();
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
    );
  }
}
