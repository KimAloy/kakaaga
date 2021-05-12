import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/data/districts_data.dart';
import 'package:kakaaga/widgets/widgets.dart';

class Location extends StatefulWidget {
  final TextEditingController parishController;
  final Function parishValidator;
  final TextEditingController districtController;
  final Function districtValidator;

  const Location({
    Key? key,
    required this.parishController,
    required this.parishValidator,
    required this.districtController,
    required this.districtValidator,
  }) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String? selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kGrey50,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardTitleText(title: 'Location*'),
            const SizedBox(height: 8),
            enterDistrict(),
            const SizedBox(height: 8),
            MyTextFormField(
                maxLines: 1,
                labelText: 'Enter parish*',
                controller: widget.parishController,
                validator: widget.parishValidator),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget enterDistrict() {
    return Container(
      height: 40,
      child: TypeAheadFormField<DistrictModel>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: widget.districtController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(5, 11, 5, 11),
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
            labelText: 'Enter district*',
            labelStyle: TextStyle(fontSize: 14.5),
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: DistrictsLatLongData.getSuggestions,
        itemBuilder: (context, DistrictModel suggestion) => ListTile(
          title: Text(suggestion.name),
        ),
        onSuggestionSelected: (DistrictModel suggestion) =>
            widget.districtController.text = suggestion.name,
        onSaved: (value) => selectedDistrict = value,
        validator: widget.districtValidator as String? Function(String?)?,
      ),
    );
  }
}
