import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/provider/advert_provider.dart';
import 'package:kakaaga/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EditAdvertScreen extends StatefulWidget {
  final int index;

  const EditAdvertScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _EditAdvertScreenState createState() => _EditAdvertScreenState();
}

class _EditAdvertScreenState extends State<EditAdvertScreen> {
  String? advertType;
  String? title;
  int? price;
  String? quantity;
  String? quantityUnit;
  String? description;
  String? advertPhoneNumber;
  String? parish;
  String? district;
  late bool whatsApp;
  late bool phoneCallOk;
  late bool eachCheckbox;
  String errorMessage = '';

  @override
  initState() {
    super.initState();
    final _provider = Provider.of<AdvertProvider>(context, listen: false);
    final _myAdverts = _provider.myAdverts;

    // advertType = _myAdverts[widget.index].advertType;
    title = _myAdverts[widget.index].title;
    price = _myAdverts[widget.index].price;
    quantity = _myAdverts[widget.index].quantity == 0
        ? ''
        : _myAdverts[widget.index].quantity.toString();
    quantityUnit = _myAdverts[widget.index].quantityUnit;
    description = _myAdverts[widget.index].description;
    district = _myAdverts[widget.index].district;
    parish = _myAdverts[widget.index].parish;
    eachCheckbox = _myAdverts[widget.index].eachCheckbox;
    whatsApp = _myAdverts[widget.index].whatsApp;
    phoneCallOk = _myAdverts[widget.index].phoneCallOk;
    advertPhoneNumber = _myAdverts[widget.index].advertPhoneNumber;
  }

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController(text: title);
    final _priceController = TextEditingController(text: price.toString());
    final _quantityController = TextEditingController(text: quantity);
    final _quantityUnitController = TextEditingController(text: quantityUnit);
    final _descriptionController = TextEditingController(text: description);
    final _advertPhoneNumberController =
        TextEditingController(text: advertPhoneNumber);
    final _districtController = TextEditingController(text: district);
    final _parishController = TextEditingController(text: parish);
    final _provider = Provider.of<AdvertProvider>(context, listen: false);
    final _myAdverts = _provider.myAdverts;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppBar(
                  title: Text(
                    'Edit Advert',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: kColorOne,
                  elevation: 0.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                    top: 15,
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
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
                          controller: _descriptionController,
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
                          controller: _advertPhoneNumberController,
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
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
                          text: 'Save Changes',
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          onPressed: () {
                            final isValid = _form.currentState!.validate();
                            setState(() {
                              if (!isValid) {
                                errorMessage = 'a';
                                return;
                              } else {
                                final editing = _myAdverts[widget.index];

                                editing.quantity = _quantityController.text
                                        .toString()
                                        .isEmpty
                                    ? 0
                                    : int.parse(
                                        _quantityController.text.toString());
                                editing.quantityUnit =
                                    _quantityUnitController.text;
                                editing.price =
                                    int.parse(_priceController.text.toString());
                                editing.eachCheckbox = eachCheckbox;
                                editing.title = _titleController.text;
                                editing.description =
                                    _descriptionController.text;
                                editing.district = _districtController.text;
                                editing.parish = _parishController.text;
                                editing.advertPhoneNumber =
                                    _advertPhoneNumberController.text;
                                editing.whatsApp = whatsApp;
                                editing.phoneCallOk = phoneCallOk;
                                _myAdverts[widget.index] = editing;
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Succesfully edited'),
                                    backgroundColor: kColorOne,
                                  ),
                                );
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
