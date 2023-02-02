import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../color_constants.dart';
import '../../../../responsive.dart';

class Gallery extends StatefulWidget {

  const Gallery({
    Key? key
  }) : super(key: key);

  @override
  State<Gallery> createState() => GalleryState();

}

class GalleryState extends State<Gallery>{

  List images = [
    "assets/images/240_F_265073366_wXcritZmlOMNsxq2DsgkiCJJeJ9p1eKo.jpeg",
    "assets/images/man.png",
    "assets/images/photo_2022-11-23_04-40-50.jpg",
    "assets/images/picture.png",
  ];

  File? style;
  List<File> fileList = [];
  
  imagePicker() async{
    FilePickerResult? pickedScreenShots = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (pickedScreenShots != null) {
      setState(() {
        fileList = pickedScreenShots.paths.map((path) => File(path!)).toList();
      });
      print(fileList);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Palette.background,
        height: MediaQuery.of(context).size.height / 1.2,
        child: Column(
          children: [
            Expanded(
              child: GridView(
                padding: EdgeInsets.only(
                    top: 12, left: 12, right: 12),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: List<Widget>.generate(
                  images.length + 1,
                      (int index) {
                    return index != images.length ? InkWell(
                      onTap: (){

                      },
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.contain,
                            //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
                          ),
                          borderRadius: BorderRadius.circular(15),

                          //border: Border.all(width: 3, color: Colors.grey)
                        ),
                      ),
                    ) : InkWell(
                      onTap: (){
                        imagePicker();
                      },
                      child: Container(
                        width: 110,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2, color: Colors.blue)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.blue),
                            SizedBox(height: 5),
                            Text("Ajouter une Image", style: TextStyle(color: Colors.blue))
                          ],
                        )
                      ),
                    );
                  },
                ),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: 1.5,
                ),
              ),
            ),
            Expanded(
                child: GridView.builder(
                    itemCount: fileList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(File(fileList[index].path), fit: BoxFit.contain);
                    }
                ),)
          ],
        )
    );
  }
}