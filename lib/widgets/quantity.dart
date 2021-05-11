import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/widgets/widgets.dart';

class Quantity extends StatelessWidget {
  final TextEditingController quantityController;
  final TextEditingController quantityUnitController;

  const Quantity(
      {Key? key,
      required this.quantityController,
      required this.quantityUnitController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: kGrey50,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardTitleText(title: 'Quantity for Sale*'),
            const SizedBox(height: 8),
            MyTextFormField(
              validator: (value) =>
                  value.isEmpty ? 'Please enter a quantity*' : null,
              controller: quantityController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                DigitsInputFormatter(),
              ],
            ),
            const SizedBox(height: 12),
            CardTitleText(title: 'Quantity Unit (Optional)'),
            const SizedBox(height: 8),
            MyTextField(
              controller: quantityUnitController,
              height: 38,
              hintText: 'e.g. bags, kgs, litres',
              fontSize: 15,
              textCapitalization: TextCapitalization.sentences,
            ),
          ],
        ),
      ),
    );
  }
}
