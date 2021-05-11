import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/widgets/widgets.dart';

class Price extends StatefulWidget {
  final TextEditingController controller;
  final bool eachCheckbox;
  final Function onEachSelected;
  const Price({
    Key? key,
    required this.controller,
    required this.eachCheckbox,
    required this.onEachSelected,
  }) : super(key: key);

  @override
  _PriceState createState() => _PriceState();
}

class _PriceState extends State<Price> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: kGrey50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardTitleText(title: "Selling Price*"),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: MyTextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Please enter a price*' : null,
                    controller: widget.controller,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DigitsInputFormatter(),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text('each'),
                  labelStyle: TextStyle(
                    color: widget.eachCheckbox ? Colors.white : Colors.black,
                  ),
                  checkmarkColor: Colors.white,
                  selectedShadowColor: kColorOne,
                  selectedColor: kColorOne,
                  selected: widget.eachCheckbox,
                  onSelected: widget.onEachSelected as void Function(bool)?,
                  // onSelected: (value) {
                  //   setState(() {
                  //     eachCheckbox = value;
                  //   });
                  // },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
