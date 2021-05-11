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
            // Wrap(
            //   spacing: 5,
            //   runSpacing: -8,
            //   children: List.generate(locationInput.length, (int index) {
            //     String hello = locationInput[index].title;
            //     return ChoiceChip(
            //       avatar: locationValue == index
            //           ? Icon(Icons.done, color: Colors.white, size: 20)
            //           : null,
            //       label: Text('$hello'),
            //       labelStyle: TextStyle(
            //           color:
            //               locationValue == index ? Colors.white : Colors.black),
            //       selected: locationValue == index,
            //       selectedShadowColor: kColorOne,
            //       selectedColor: kColorOne,
            //       onSelected: (bool selected) {
            //         setState(() {
            //           locationValue = selected ? index : null;
            //         });
            //       },
            //     );
            //   }).toList(),
            // ),
            // const SizedBox(height: 8),
            // locationValue == 0
            //     ? const SizedBox.shrink()
            //     :
            enterDistrict(),
            const SizedBox(height: 8),
            MyTextFormField(
                maxLines: 1,
                labelText: 'Enter Parish name*',
                controller: widget.parishController,
                validator: widget.parishValidator),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget enterDistrict() {
    return Row(
      children: [
        Expanded(
          child: TypeAheadFormField<String?>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: widget.districtController,
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
                labelText: 'Enter district',
                labelStyle: TextStyle(color: Colors.black38),
                border: OutlineInputBorder(),
              ),
            ),
            suggestionsCallback: DistrictsData.getSuggestions,
            itemBuilder: (context, String? suggestion) => ListTile(
              title: Text(suggestion!),
            ),
            onSuggestionSelected: (String? suggestion) =>
                widget.districtController.text = suggestion!,
            onSaved: (value) => selectedDistrict = value,
            validator: widget.districtValidator as String? Function(String?)?,
          ),
        ),
      ],
    );
  }
}
