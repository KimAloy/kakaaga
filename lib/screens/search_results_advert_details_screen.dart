import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/widgets/widgets.dart';

class SearchResultsAdvertDetailsScreen extends StatelessWidget {
  final Advert advertData;

  const SearchResultsAdvertDetailsScreen({
    Key? key,
    required this.advertData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              advertData.images!.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          // automaticallyImplyLeading: false,
                          elevation: 0.0,
                          // leading: BackButton(color: Colors.black),
                          backgroundColor: Colors.transparent,
                          iconTheme: IconThemeData(color: Colors.black),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            CircleAvatar(
                              backgroundColor: Colors.amber[400],
                              radius: 24,
                              child: WatchlistIcon(advertData: advertData),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                        const SizedBox(height: 15),
                      ],
                    )
                  : ImagesContainerDetailsScreen(
                      advertData: advertData,
                      imageContainerHeight: 272.5,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SelectableText(
                      "${advertData.title}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    SelectableText(
                      advertData.eachCheckbox == true
                          ? 'Asking price:\nUGX ${numberCommaFormatter.format(advertData.price)} each'
                          : 'Asking price:\nUGX ${numberCommaFormatter.format(advertData.price)}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),

                    AutoSizeText.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Quantity: ${advertData.quantity} ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: advertData.quantityUnit == null
                                ? ''
                                : '${advertData.quantityUnit}',
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(
                          '${advertData.phoneNumber}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        advertData.whatsApp == true
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
                        advertData.phoneCallOk == true
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
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              'Seller located in ${advertData.parish}, ${advertData.district}\n',
                                          // style: TextStyle(
                                          //   fontSize: 19,
                                          //   fontWeight: FontWeight.bold,
                                          // ),
                                        ),
                                        TextSpan(
                                          text: 'Get directions',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //     child: Row(
                                  //   children: [
                                  //     Text(
                                  //         'Seller located in ${advertData.parish}, ${advertData.district}'),
                                  //     Text(
                                  //       ' Get directions',
                                  //       style: TextStyle(
                                  //         color: Colors.blue,
                                  //         decoration: TextDecoration.underline,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.access_time),
                              const SizedBox(width: 8),
                              SelectableText(
                                'Listed: ${kConvertDateTime(DateTime.parse(advertData.createdTime!.toString()))} ',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    advertData.description == null
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
                                '${advertData.description}',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                    // advertData.keywords == null
                    //     ? const SizedBox.shrink()
                    //     : Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SelectableText(
                    //             'Keywords',
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.bold),
                    //           ),
                    //           const SizedBox(height: 15),
                    //           SelectableText('${advertData.keywords}',
                    //               style: TextStyle(fontSize: 16))
                    //         ],
                    //       ),
                    AboutTheSellerOrBuyer(advertData: advertData),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
