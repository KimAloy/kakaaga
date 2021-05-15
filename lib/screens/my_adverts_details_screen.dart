import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/provider/advert_provider.dart';
import 'file:///C:/Users/MadCoder/AndroidStudioProjects/kakaaga/lib/screens/edit_advert_screen.dart';
import 'package:kakaaga/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MyAdvertsDetailsScreen extends StatefulWidget {
  final Advert advertData;
  final bool showWatchlistIcon;
  final int index;

  const MyAdvertsDetailsScreen({
    Key? key,
    required this.advertData,
    this.showWatchlistIcon = true,
    required this.index,
  }) : super(key: key);

  @override
  _MyAdvertsDetailsScreenState createState() => _MyAdvertsDetailsScreenState();
}

class _MyAdvertsDetailsScreenState extends State<MyAdvertsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdvertProvider>(context);
    bool mySwitch = provider.mySwitch;
    List myAdverts = provider.myAdverts;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.advertData.images!.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        ImagesContainerDetailsScreen(
                          advertData: widget.advertData,
                          showWatchlistIcon: widget.showWatchlistIcon,
                          imageContainerHeight:
                              widget.showWatchlistIcon == false ? 250 : 272.5,
                          useBackArrowOnTap: true,
                          backArrowOnTap: () =>
                              Navigator.of(context).pop(mySwitch),
                        ),
                        const SizedBox(height: 15)
                      ],
                    ),
              widget.advertData.images!.isEmpty
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          leading: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                          elevation: 0.0,
                          backgroundColor: kScreenBackground,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              widget.showWatchlistIcon == false
                                  ? const SizedBox.shrink()
                                  : Row(
                                      children: [
                                        Spacer(),
                                        CircleAvatar(
                                          backgroundColor: Colors.amber[400],
                                          radius: 24,
                                          child: WatchlistIcon(
                                              advertData: widget.advertData),
                                        ),
                                        const SizedBox(width: 15),
                                      ],
                                    ),
                              widget.showWatchlistIcon == false
                                  ? const SizedBox.shrink()
                                  : const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
              SwitchListTile(
                title: RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Ad Status: ',
                        ),
                        TextSpan(
                            text: widget.advertData.adStatus == true
                                ? 'active'
                                : '',
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(
                            text: widget.advertData.adStatus == false
                                ? 'not active'
                                : '',
                            style: TextStyle(color: Colors.red, fontSize: 16.5))
                      ]),
                ),
                secondary: Icon(
                  Icons.swap_vert_circle_outlined,
                  color: widget.advertData.adStatus == true
                      ? Colors.green
                      : Colors.red,
                ),
                value: widget.advertData.adStatus,
                onChanged: (bool value) {
                  setState(() {
                    widget.advertData.adStatus = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    widget.showWatchlistIcon == true
                        ? const SizedBox.shrink()
                        : _MyFlatButtons(
                            editAdvertOnPressed: () {
                              editAdvert(widget.advertData);

                              print(
                                  '"edit advert pressed, found in new_advert_details_screen"');
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (_) {
                              //         return EditAdvertScreen(
                              //             index: widget.index);
                              //       },
                              //     ),
                              //   ).whenComplete(() => setState(() => {
                              //         // THIS CODE BELOW 'widget.index' IS QUITE USELESS
                              //         // THIS STILL WORKS EVEN WITHOUT IT
                              //         // widget.index //
                              //       }));
                            },
                            deleteAdvertOnPressed: () {
                              print('"delete advert pressed"');
                              showDialog(
                                context: context,
                                builder: (_) => DeleteAdvertDialog(
                                  onPressed: () {
                                    print('"Yes delete advert tapped"');
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    myAdverts.remove(widget.advertData);
                                    // from johannes at timestamp 05:12 in - Flutter Tutorial - 2_2 TodoApp UI From Scratch
                                    deleteAdvert(widget.advertData);
                                  },
                                ),
                              );
                            },
                          ),
                    const SizedBox(height: 15),
                    SelectableText(
                      "${widget.advertData.title}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    SelectableText(
                      widget.advertData.eachCheckbox == true
                          ? 'Asking price:\nUGX ${numberCommaFormatter.format(widget.advertData.price)} each'
                          : 'Asking price:\nUGX ${numberCommaFormatter.format(widget.advertData.price)}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (widget.advertData.quantity == null ||
                        widget.advertData.quantity == 0)
                      SelectableText(
                        'For Sale',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    else
                      Row(
                        children: [
                          AutoSizeText.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Qty ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                TextSpan(
                                  text: 'For Sale: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                TextSpan(
                                    text:
                                        '${numberCommaFormatter.format(widget.advertData.quantity)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                TextSpan(
                                  // text: advertData.quantityUnit.isEmpty // IT ALSO WORKS
                                  text: widget.advertData.quantityUnit == null
                                      ? ''
                                      : ' ${widget.advertData.quantityUnit}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            maxFontSize: 20,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(
                          '${widget.advertData.phoneNumber}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        widget.advertData.whatsApp == true
                            ? Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Icon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.green,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        widget.advertData.phoneCallOk == true
                            ? Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Icon(
                                    FontAwesomeIcons.phone,
                                    color: kColorTwo,
                                    size: 20,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(
                                  '"Location tapped\nshould go to map screen"');
                            },
                            child: Row(
                              children: [
                                Icon(Icons.room_outlined),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Location: ${widget.advertData.parish}, ${widget.advertData.district} Uganda',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.access_time),
                              const SizedBox(width: 8),
                              SelectableText(
                                'Listed: ${kConvertDateTime(DateTime.parse(widget.advertData.createdTime!.toString()))} ',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    // widget.advertData.description!.isEmpty
                    widget.advertData.description == null // THIS DOESN'T WORK
                        ? const SizedBox.shrink()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                'Description',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 15),
                              SelectableText(
                                '${widget.advertData.description}',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                    // widget.advertData.keywords.isEmpty
                    //     // advertData.keywords == null // THIS DOESN'T WORK
                    //     ? const SizedBox.shrink()
                    //     : Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SelectableText(
                    //             'Keywords',
                    //             style: TextStyle(
                    //                 fontSize: 20,
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //           const SizedBox(height: 15),
                    //           SelectableText('${widget.advertData.keywords}',
                    //               style: TextStyle(fontSize: 16))
                    //         ],
                    //       ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }

  void deleteAdvert(Advert advert) {
    final provider = Provider.of<AdvertProvider>(context, listen: false);
    provider.deleteAdvertProvider(advert);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Advert deleted.'),
        backgroundColor: kColorOne,
      ),
    );
  }

  void editAdvert(Advert advertData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return EditAdvertScreen(advert: widget.advertData);
        },
      ),
    );
  }
}

class _MyFlatButtons extends StatelessWidget {
  final Function editAdvertOnPressed;
  final Function deleteAdvertOnPressed;

  const _MyFlatButtons({
    Key? key,
    required this.editAdvertOnPressed,
    required this.deleteAdvertOnPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton.icon(
          onPressed: deleteAdvertOnPressed as void Function()?,
          icon: Icon(Icons.delete_forever_outlined, size: 20),
          label: Text('Delete'),
          style: TextButton.styleFrom(primary: Colors.red),
        ),
        const SizedBox(width: 15),
        OutlinedButton.icon(
          onPressed: editAdvertOnPressed as void Function()?,
          icon: Icon(Icons.edit, size: 20),
          label: Text('Edit'),
          style: TextButton.styleFrom(primary: kColorOne),
        ),
      ],
    );
  }
}
