import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/widgets/widgets.dart';

class ImagesContainerDetailsScreen extends StatefulWidget {
  final Advert advertData;
  final double imageContainerHeight;
  final bool showWatchlistIcon;
  final bool useBackArrowOnTap;
  final Function? backArrowOnTap;

  const ImagesContainerDetailsScreen({
    Key? key,
    required this.advertData,
    this.showWatchlistIcon = true,
    required this.imageContainerHeight,
    this.useBackArrowOnTap = false,
    this.backArrowOnTap,
  }) : super(key: key);

  @override
  __ImagesContainerState createState() => __ImagesContainerState();
}

class __ImagesContainerState extends State<ImagesContainerDetailsScreen> {
  int currentIndex = 0;

  void newIndex(index) {
    setState(() {
      currentIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    return Container(
      height: widget.imageContainerHeight,
      child: Stack(
        children: [
          Container(
            height: 250,
            width: myWidth,
            child: widget.advertData.images!.length > 1
                ? Swiper(
                    index: currentIndex,
                    onIndexChanged: newIndex,
                    itemCount: widget.advertData.images!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        widget.advertData.images![index],
                        fit: BoxFit.contain,
                      );
                    },
                  )
                : Image.asset(
                    widget.advertData.images![0],
                    fit: BoxFit.contain,
                  ),
          ),
          Positioned(
            top: 8,
            left: 0,
            child: IconButton(
              onPressed: widget.useBackArrowOnTap == false
                  ? () => Navigator.of(context).pop()
                  : widget.backArrowOnTap as void Function()?,
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kColorTwo,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Text(
                  '${currentIndex + 1} / ${widget.advertData.images!.length}',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
          widget.showWatchlistIcon == false
              ? const SizedBox.shrink()
              : Positioned(
                  right: 20,
                  bottom: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.amber[400],
                    radius: 24,
                    child: WatchlistIcon(advertData: widget.advertData),
                  ),
                )
        ],
      ),
    );
  }
}
