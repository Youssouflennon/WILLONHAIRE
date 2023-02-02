import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../../color_constants.dart';
import '../../../responsive.dart';
import '../../../widgets/app_button_widget.dart';
import '../../../widgets/input_widget.dart';
import 'package:http/http.dart' as http;

class FormMaterial extends StatefulWidget {
  @override
  _FormMaterialState createState() => _FormMaterialState();
}

final List<String> items = [
  'APPLICATION',
  'MODULE',
];
String? selectedValue;
bool isValid = false;
bool isLoading = false;

class _FormMaterialState extends State<FormMaterial> {


  TextEditingController appName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController objectives = TextEditingController();
  TextEditingController code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Palette.background,
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15.0))),
      content: Container(
        color: backgroundColor,
        padding: EdgeInsets.only(top: 0,bottom: 0.0,right: 10,left: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              },
                hoverColor: backgroundColor,
              icon: Icon(Icons.close, color: Colors.grey),
              ),
            ),
            Center(
              child: Text("Publier une Application", style: TextStyle(color: appColor, fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ),
            //SelectionSection(),
            appInfo(context),
            moreInfo(context),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: AppButton(
                loading: isLoading,
                text: "Publish App",
                type: ButtonType.PRIMARY,
                onPressed: (){
                  if(isValid ) {
                    setState(() {
                      isLoading = !isLoading;
                    });
                    //publishApp();
                  }
                },
              ),
            ),
            /*ElevatedButton(
                onPressed: (){
                  setState(() {
                    isLoading = true;
                  });
                  publishApp();
                },
                child: 
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: isLoading ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1.5,
                        )) : Text("Publish App", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
                  ),
                ))*/
          ],
        )
      ),
    );
  }

  Widget dropDownTextForm(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select app Type", style: TextStyle(color: Colors.black)),
        SizedBox(height: 4.0),
        DropdownButtonFormField2(
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(top: 10, bottom: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: textFieldColor,
              ),
            ),
            filled: true,
            labelStyle: TextStyle(color: Colors.black),
            //label: Text('Select Item', style: TextStyle(color: Colors.black)),
            fillColor: textFieldColor,
            prefixIcon: Icon(Icons.category),
            focusedBorder: OutlineInputBorder(
              //gapPadding: 16,
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: primaryColor,

          ),
          items: items
              .map((item) =>
              DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                      fontSize: 14,color: appColor
                  ),
                ),
              ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        ),
      ],
    );
  }

  Container appInfo(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 30, left: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: EdgeInsets.only(right: 20, left: 20),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      dropDownTextForm(),
                      /*DropDownTextField(
                        clearOption: false,
                        textFieldDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),

                          filled: true,
                          fillColor: secondaryColor,
                          labelText: "Select app Type",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            //gapPadding: 16,
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        dropDownItemCount: 2,
                        searchShowCursor: false,
                        dropDownList: [
                          DropDownValueModel(name: 'APPLICATION', value: "APPLICATION"),
                          DropDownValueModel(name: 'MODULE', value: "MODULE"),
                        ],
                        onChanged: (val) {
                          //appType = val;
                        },
                      ),*/
                      SizedBox(height: 20),
                      InputWidget(
                        kController: appName,
                        onSaved: (String? value) {},
                        onChanged: (String? value) {},
                        validator: (String? value) {
                          return (value != null && value.isEmpty)
                              ? 'field required!'
                              : null;
                        },

                        topLabel: "App Name",
                        hintText: "Enter app Name",
                        prefixIcon: Icon(Icons.settings_applications),
                      ),
                      SizedBox(height: 20),
                      InputMultilineWidget(
                        kController: description,
                        onSaved: (String? value) {},
                        onChanged: (String? value) {},
                        minLines: 3,
                        maxLines: 5,
                        validator: (String? value) {
                          return (value != null && value.isEmpty)
                              ? 'field required!'
                              : null;
                        },

                        topLabel: "Description",
                        hintText: "Enter description",
                      ),
                      SizedBox(height: 20),
                      if(Responsive.isMobile(context) || Responsive.isTablet(context))
                        Column(
                          children: [
                            InputWidget(
                              kController: code,
                              onSaved: (String? value) {},
                              onChanged: (String? value) {},
                              validator: (String? value) {
                                return (value != null && value.isEmpty)
                                    ? 'field required!'
                                    : null;
                              },
                              topLabel: "Code",
                              hintText: "Enter Code",
                              prefixIcon: Icon(Icons.description_outlined, color: Palette.background),
                            ),
                            SizedBox(height: 20),
                            InputWidget(
                              kController: price,
                              keyboardType: TextInputType.number,
                              onSaved: (String? value) {},
                              onChanged: (String? value) {},
                              validator: (String? value) {
                                return (value != null && value.isEmpty)
                                    ? 'field required!'
                                    : null;
                              },

                              topLabel: "Price",
                              hintText: "Enter price",
                              prefixIcon: Icon(Icons.attach_money_rounded),
                            ),
                            SizedBox(height: 20),
                            InputMultilineWidget(
                              kController: objectives,
                              onSaved: (String? value) {},
                              minLines: 3,
                              maxLines: 5,
                              onChanged: (String? value) {},
                              validator: (String? value) {
                                return (value != null && value.isEmpty)
                                    ? 'field required!'
                                    : null;
                              },
                              topLabel: "Objectives",
                              hintText: "Enter Objectives",
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                    ],
                  ),
                ),
                if(!Responsive.isMobile(context) && !Responsive.isTablet(context))
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: EdgeInsets.only(right: 20, left: 20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      InputWidget(
                        kController: code,
                        onSaved: (String? value) {},
                        onChanged: (String? value) {},
                        validator: (String? value) {
                          return (value != null && value.isEmpty)
                              ? 'field required!'
                              : null;
                        },
                        topLabel: "Code",
                        hintText: "Enter Code",
                        prefixIcon: Icon(Icons.description_outlined),
                      ),
                      SizedBox(height: 20),
                      InputWidget(
                        kController: price,
                        keyboardType: TextInputType.number,
                        onSaved: (String? value) {},
                        onChanged: (String? value) {},
                        validator: (String? value) {
                          return (value != null && value.isEmpty)
                              ? 'field required!'
                              : null;
                        },

                        topLabel: "Price",
                        hintText: "Enter price",
                        prefixIcon: Icon(Icons.attach_money_rounded),
                      ),
                      SizedBox(height: 20),
                      InputMultilineWidget(
                        kController: objectives,
                        onSaved: (String? value) {},
                        minLines: 3,
                        maxLines: 5,
                        onChanged: (String? value) {},
                        validator: (String? value) {
                          return (value != null && value.isEmpty)
                              ? 'field required!'
                              : null;
                        },
                        topLabel: "Objectives",
                        hintText: "Enter Objectives",
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      )
    );
  }
  File? appLogo;

  /*logoPicker() async {
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        appLogo = File(pickedImage.path);
      });
    }
  }*/
  logoPicker() async {
    FilePickerResult? pickedImage = await FilePicker.platform.pickFiles();
    if (pickedImage != null) {
      setState(() {
        appLogo = File(pickedImage.files.single.path.toString());
        //displayFlightTicket = pickedImage.files.single.name;
      });
    }
  }

  List<XFile>? imageFileList = [];
  List<File> fileList = [];
  File? screenshot1;
  File? screenshot2;
  File? screenshot3;
  File? screenshot4;
  String screenshotFiles = "";

  screenshotPicker() async{
    FilePickerResult? pickedScreenShots = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (pickedScreenShots != null) {
      fileList = pickedScreenShots.paths.map((path) => File(path!)).toList();
      setState(() {
        screenshotFiles = fileList.toString();
        screenshot1 = File(fileList.elementAt(0).path);
        screenshot2 = File(fileList.elementAt(1).path);
        screenshot3 = File(fileList.elementAt(2).path);
        screenshot4 = File(fileList.elementAt(3).path);
        isValid = true;
      });
      print("$screenshot1,\n $screenshot2,\n $screenshot3,\n $screenshot4");
    }
  }

  Container moreInfo(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Column(
              children: [
                ElevatedButton.icon(onPressed: (){
                  logoPicker();
                },
                    icon: Icon(Icons.upload_rounded), label: Text("upload App Logo")),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: textFieldColor,
                  ),
                  width: 200,
                  height: 250,
                  child: appLogo != null ?
                  Image.file(appLogo!, fit: BoxFit.fill) : Text('Add logo', style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey)),
                ),
              ],
            ),
            SizedBox(width: 20),
            Column(
              children: [
                ElevatedButton.icon(onPressed: (){
                  screenshotPicker();
                },
                    icon: Icon(Icons.upload_rounded), label: Text("upload screenShots")),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: textFieldColor,
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 250,
                  child: fileList.isEmpty ? Text('Add Screenshots of your app(4 images required)', style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey))
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        itemCount: fileList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.file(File(fileList[index].path), fit: BoxFit.contain);
                        }
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

  publishApp()async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://saas24.shintheo.com:7000/applications?type=$selectedValue&name=$appName&description=$description&price=$price&objectives=$objectives'));
    request.body = json.encode({
      "logo": appLogo,
      "screenshotOne": screenshot1,
      "screenshotTwo": screenshot2,
      "screenshotThree": screenshot3,
      "screenshotFour": screenshot4,
      "code": code.text
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200  || response.statusCode == 201) {
      print(await response.stream.bytesToString());
      setState(() {
        isLoading = false;
      });
      MotionToast.info(
        description:  Text("everything is OK! 👍", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
        height: 90,
      ).show(context);
    }
    else {
      print(response.reasonPhrase);
      final error = await response.stream.bytesToString();
      setState(() {
        isLoading = false;
      });
      MotionToast.error(
        description:  Text(json.decode(error)["message"], style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
        height: 90,
      ).show(context);
    }
  }
}
