import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/widgets/widgets.dart';

class SortDialogButton extends StatefulWidget {
  final onChanged;
  const SortDialogButton({Key? key, required this.onChanged}) : super(key: key);

  @override
  _SortDialogButtonState createState() => _SortDialogButtonState();
}

class _SortDialogButtonState extends State<SortDialogButton> {
  int selectedIndex = 0;

  String sortDialogTitle = 'Latest Listings';

  List<AdvertItemsModel> sortDialogItems = [
    AdvertItemsModel(title: 'Latest Listings', index: 0),
    AdvertItemsModel(title: 'Lowest Price', index: 1),
    AdvertItemsModel(title: 'Highest Price', index: 2),
    AdvertItemsModel(title: 'Lowest Quantity', index: 3),
    AdvertItemsModel(title: 'Highest Quantity', index: 4),
  ];

  updateTitle(index) {
    setState(() {
      sortDialogTitle = sortDialogItems[index].title;
      selectedIndex = sortDialogItems[index].index;
      print('this is the index $selectedIndex');
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('"sort dialog button tapped"');
        showGeneralDialog(
          context: context,
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondAnimation) {
            return listMenu();
          },
        );
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.black38),
                borderRadius: BorderRadius.circular(3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Text(
                    'Sort:  $sortDialogTitle',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.arrow_drop_down, color: kColorOne),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  listMenu() {
    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Center(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: kColorOne),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Sort',
                        style: TextStyle(
                          color: kColorOne,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15),
                      Divider(),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: sortDialogItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          AdvertItemsModel mySortDialogItems =
                              sortDialogItems[index];
                          return MyRadioListTile(
                            title: mySortDialogItems.title,
                            value: mySortDialogItems.index,
                            groupValue: selectedIndex,
                            onChanged: (index) {
                              widget.onChanged(index);
                              updateTitle(index);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
