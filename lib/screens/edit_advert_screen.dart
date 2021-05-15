import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/provider/advert_provider.dart';
import 'package:kakaaga/widgets/widgets.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class EditAdvertScreen extends StatefulWidget {
  final Advert advert;

  const EditAdvertScreen({
    Key? key,
    required this.advert,
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
  String? phoneNumber;
  String? parish;
  String? district;
  late bool whatsApp;
  late bool phoneCallOk;
  late bool eachCheckbox;
  String errorMessage = '';

  @override
  initState() {
    super.initState();

    title = widget.advert.title;
    price = widget.advert.price;
    quantity =
        widget.advert.quantity == 0 ? '' : widget.advert.quantity.toString();
    quantityUnit = widget.advert.quantityUnit;
    description = widget.advert.description;
    district = widget.advert.district;
    parish = widget.advert.parish;
    eachCheckbox = widget.advert.eachCheckbox;
    whatsApp = widget.advert.whatsApp;
    phoneCallOk = widget.advert.phoneCallOk;
    phoneNumber = widget.advert.phoneNumber;
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
        TextEditingController(text: phoneNumber);
    final _districtController = TextEditingController(text: district);
    final _parishController = TextEditingController(text: parish);
    bool loading = false;
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
                            districtValidator: (text) => text.isEmpty
                                ? 'Please enter a District*'
                                : null,
                            parishController: _parishController,
                            parishValidator: (text) =>
                                text.isEmpty ? 'Please enter a Parish*' : null,
                          ),
                          const SizedBox(height: 15),
                          MyPreferredContact(
                            // onChanged: (value) =>
                            //     setState(() => phoneNumber = value),
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
                                if (!isValid) {
                                  setState(() {
                                    errorMessage = 'a';
                                    loading = false;
                                  });
                                  return;
                                } else {
                                  setState(() => loading = true);
                                  final provider = Provider.of<AdvertProvider>(
                                      context,
                                      listen: false);
                                  provider.editAdvertProvider(
                                      advert: widget.advert,
                                      title: _titleController.text,
                                      price: int.parse(_priceController.text
                                          .replaceAll(',', '')
                                          .toString()),
                                      quantity: int.parse(_quantityController
                                          .text
                                          .replaceAll(',', '')
                                          .toString()),
                                      quantityUnit:
                                          _quantityUnitController.text,
                                      description: _descriptionController.text,
                                      phoneNumber:
                                          _advertPhoneNumberController.text,
                                      parish: _parishController.text,
                                      district: _districtController.text,
                                      whatsApp: whatsApp,
                                      phoneCallOk: phoneCallOk,
                                      eachCheckbox: eachCheckbox);
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Succesfully edited'),
                                      backgroundColor: kColorOne,
                                    ),
                                  );
                                }
                              }),
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
      ),
    );
  }
}
