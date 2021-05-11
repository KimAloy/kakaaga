import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/widgets/widgets.dart';

// class AddPhotosController extends GetxController {
//   List<Asset> images = List<Asset>().obs;
// }

class AddPhotos extends StatefulWidget {
  final String title;
  final bool addPhotosError;

  const AddPhotos({
    Key? key,
    required this.title,
    required this.addPhotosError,
  }) : super(key: key);

  @override
  _AddPhotosState createState() => _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {
  // AddPhotosController addPhotosController = Get.put(AddPhotosController());

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kGrey50,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardTitleText(title: widget.title),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: kColorOne),
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // loadAssets();
                            // TODO: Load assets should go here

                            print('add images tapped');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child:
                                Icon(Icons.add, color: Colors.white, size: 35),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: kColorTwo,
                            onPrimary: Colors.white,
                            shape: CircleBorder(),
                          ),
                        ),
                      ),
                    ),
                    widget.addPhotosError
                        ? Padding(
                            padding: const EdgeInsets.only(top: 6, left: 5),
                            child: Text(
                              'Add at least one photo*',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 80,
                    // child: buildListView(),
                    // TODO: Build lisview from uploaded photos
                    child: Text('List of photos should go here'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // List<Asset> images = [];
  // // List<Asset> images = List<Asset>();

  // Widget buildListView() {
  //   return ListView.separated(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: images.length,
  //     separatorBuilder: (BuildContext context, int index) =>
  //         const SizedBox(width: 8),
  //     itemBuilder: (BuildContext context, int index) {
  //       Asset asset = images[index];
  //       return GestureDetector(
  //         onTap: () => print('"tapped image $index"'),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(6),
  //           child: AssetThumb(
  //             asset: asset,
  //             width: 300,
  //             height: 300,
  //             // width: 100, height: 100,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<void> loadAssets() async {
  // TODO: Load assets should go here
  //   List<Asset> resultList = [];
  //   // List<Asset> resultList = List<Asset>();

  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 300,
  //       enableCamera: true,
  //       selectedAssets: images,
  //       cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
  //       materialOptions: MaterialOptions(
  //         actionBarColor: "#3c96d3",
  //         actionBarTitle: "Select Photos",
  //         allViewTitle: "All Photos",
  //         useDetailsView: false,
  //         selectCircleStrokeColor: "#3c96d3",
  //       ),
  //     );
  //   } on Exception catch (e) {
  //     print(
  //         '****** UNSUPPORTED OPERATION ****** UNSUPPORTED OPERATION ****** ' +
  //             e.toString());
  //   }
  //   if (!mounted) return;

  //   setState(() {
  //     images = resultList;
  //   });
  // }
}
