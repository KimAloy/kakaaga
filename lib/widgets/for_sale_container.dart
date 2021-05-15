import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/widgets/widgets.dart';

class ForSaleContainerHasImage extends StatelessWidget {
  final Advert advertData;
  final Function onTap;
  final bool showWatchlistIcon;
  final bool showDistance;
  final bool showAdvertStatusSwitch;

  const ForSaleContainerHasImage({
    Key? key,
    required this.advertData,
    required this.onTap,
    this.showWatchlistIcon = true,
    this.showDistance = true,
    this.showAdvertStatusSwitch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: kScreenBackground,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 75,
                width: 75,
                child: Image.asset(
                  advertData.images![0],
                  fit: BoxFit.contain,
                ),
              ),
            ),
            showWatchlistIcon == false
                ? const SizedBox.shrink()
                : Positioned(
                    right: 8,
                    top: 5,
                    child: WatchlistIcon(advertData: advertData),
                  ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  showAdvertStatusSwitch == false
                      ? const SizedBox.shrink()
                      : Flexible(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 85),
                                  RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.5),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Ad Status: ',
                                              style: TextStyle(
                                                  color: Colors.black54)),
                                          TextSpan(
                                              text: advertData.adStatus == true
                                                  ? 'active'
                                                  : '',
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                          TextSpan(
                                              text: advertData.adStatus == false
                                                  ? 'not active'
                                                  : '',
                                              style:
                                                  TextStyle(color: Colors.red))
                                        ]),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                  Flexible(
                    child: Row(
                      children: [
                        const SizedBox(width: 85),
                        showDistance == false
                            ? Text(
                                '${advertData.parish}, ${advertData.district}',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14.5),
                              )
                            : Container(
                                width: myWidth - 150,
                                child: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '${advertData.parish}, ${advertData.district}     ',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        const SizedBox(width: 85),
                        Text(
                          'Listed: ${kConvertDateTime(DateTime.parse(advertData.createdTime!.toString()))}',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 14.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  advertData.quantity == null
                      ? const SizedBox.shrink()
                      : Flexible(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 85),
                                  Text('Quantity: ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14.5)),
                                  Text(
                                      '${numberCommaFormatter.format(advertData.quantity)}',
                                      style: TextStyle(fontSize: 14.5)),
                                  advertData.quantityUnit == null
                                      ? const SizedBox.shrink()
                                      : Text(' ${advertData.quantityUnit}',
                                          style: TextStyle(fontSize: 14.5)),
                                ],
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                  Flexible(
                    child: Row(
                      children: [
                        const SizedBox(width: 85),
                        Expanded(
                          child: Text(
                            "${advertData.title}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                        advertData.eachCheckbox == true
                            ? 'Asking price: UGX ${numberCommaFormatter.format(advertData.price)} each'
                            : 'Asking price: UGX ${numberCommaFormatter.format(advertData.price)}',
                        style: kPriceContainerTextStyle),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForSaleNoImageContainer extends StatelessWidget {
  final Advert advertData;
  final Function onTap;
  final bool showWatchlistIcon;
  final bool showDistance;
  final bool showAdvertStatusSwitch;

  const ForSaleNoImageContainer({
    Key? key,
    required this.advertData,
    required this.onTap,
    this.showWatchlistIcon = true,
    this.showDistance = true,
    this.showAdvertStatusSwitch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: kScreenBackground,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  showAdvertStatusSwitch == false
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.5),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Ad Status: ',
                                        style:
                                            TextStyle(color: Colors.black54)),
                                    TextSpan(
                                        text: advertData.adStatus == true
                                            ? 'active'
                                            : '',
                                        style: TextStyle(color: Colors.blue)),
                                    TextSpan(
                                        text: advertData.adStatus == false
                                            ? 'not active'
                                            : '',
                                        style: TextStyle(color: Colors.red))
                                  ]),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                  showDistance == false
                      // TODO: Calculate distance automatically
                      ? Text(
                          '${advertData.parish}, ${advertData.district}',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 14.5),
                        )
                      : RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${advertData.parish}, ${advertData.district}     ',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14.5),
                              ),
                            ],
                          ),
                        ),
                  Text(
                    'Listed: ${kConvertDateTime(DateTime.parse(advertData.createdTime!.toString()))}',
                    style: TextStyle(color: Colors.black54, fontSize: 14.5),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('Quantity: ',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 14.5)),
                      Text(
                          '${numberCommaFormatter.format(advertData.quantity)}',
                          style: TextStyle(fontSize: 14.5)),
                      advertData.quantityUnit == null
                          ? const SizedBox.shrink()
                          : Text(' ${advertData.quantityUnit}',
                              style: TextStyle(fontSize: 14.5)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${advertData.title}",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    advertData.eachCheckbox == true
                        ? 'Asking price: UGX ${numberCommaFormatter.format(advertData.price)} each'
                        : 'Asking price: UGX ${numberCommaFormatter.format(advertData.price)}',
                    style: kPriceContainerTextStyle,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
            showWatchlistIcon == false
                ? const SizedBox.shrink()
                : Positioned(
                    right: 8,
                    top: 5,
                    child: WatchlistIcon(advertData: advertData)),
          ],
        ),
      ),
    );
  }
}

class AutoSizeTextContainerItems extends StatelessWidget {
  final String text1;
  final String text2;

  const AutoSizeTextContainerItems({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: text1,
            style: TextStyle(color: Colors.black54, fontSize: 14.5),
          ),
          TextSpan(
            text: text2,
            style: TextStyle(fontSize: 14.5),
          ),
        ],
      ),
      maxLines: 1,
      maxFontSize: 14.5,
      minFontSize: 8,
    );
  }
}
