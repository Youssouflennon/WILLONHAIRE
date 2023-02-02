import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../color_constants.dart';

class Details extends StatefulWidget {

  const Details({
    Key? key
  }) : super(key: key);

  @override
  State<Details> createState() => DetailsState();

}

class DetailsState extends State<Details>{


  int indexSelected = 0;
  String phoneNumber = "";
  String? categoryValue;
  String? serviceValue;
  String? placeValue;
  String? employeeValue;
  String? hourValue;

  final _formKey = GlobalKey<FormState>();

  final List<String> category = [
    'ADULT',
    'ADO',
    'ENFANT'
  ];
  final List<String> emplacements = [
    'YAOUNDE',
    'DOUALA',
    'KENEDI',
    'LIMBE'
  ];
  final List<String> service = [
    'coupe',
    'trassage',
    'teinture',
    'punk'
  ];
  final List<String> employee = [
    'Blaise B',
    'Allpha Swagger',
    'Walter Larson',
    'Midoriya Toriyama',
    'Ashida Inosuke'
  ];
  final List<String> hours = [
    '12:00',
    '08:30',
    '09:30',
    '10:30',
    '11:30',
    '12:30',
    '13:30',
  ];

  File? style;
  List<File> fileList = [];

  imagePicker() async{
    FilePickerResult? pickedScreenShots = await FilePicker.platform.pickFiles(allowMultiple: false);
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
        padding: EdgeInsets.all(defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height:150,
                width: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: background,
                    image: DecorationImage(
                        image: AssetImage('assets/images/man.png')
                    )
                ),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: background,
                        border: Border.all(width: 3, color: Colors.white),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(onPressed: (){
                        imagePicker();
                      },
                          icon: Icon(Icons.photo_camera, size: 30, color: CupertinoColors.systemBlue,)
                      ),
                    )
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nom:"),
                      Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: 40,
                          child: TextFormField(
                            //controller: dateController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: background,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                            ),
                            validator: (String? value) {
                              return (value != null && value.isEmpty)
                                  ? 'field required!'
                                  : null;
                            },
                          )
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Prénom:"),
                      Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: 40,
                          child: TextFormField(
                            //controller: dateController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: background,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                            ),
                            validator: (String? value) {
                              return (value != null && value.isEmpty)
                                  ? 'field required!'
                                  : null;
                            },
                          )
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email:"),
                      Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: 40,
                          child: TextFormField(
                            //controller: dateController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: background,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                            ),
                            validator: (String? value) {
                              return (value != null && value.isEmpty)
                                  ? 'field required!'
                                  : null;
                            },
                          )
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Emplacement:"),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonPadding: EdgeInsets.only(left: 10),
                          buttonWidth: MediaQuery.of(context).size.width / 5,
                          buttonHeight: 40,
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: Colors.black,
                            ),
                            color: background,
                          ),
                          hint: Text(
                            'Choisir',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),
                          ),
                          items: category
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ))
                              .toList(),
                          value: categoryValue,
                          onChanged: (value) {
                            setState(() {
                              categoryValue = value.toString();
                            });
                          },
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          itemHeight: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Utilisateur associé:"),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonPadding: EdgeInsets.only(left: 10),
                          buttonWidth: MediaQuery.of(context).size.width / 5,
                          buttonHeight: 40,
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: Colors.black,
                            ),
                            color: background,
                          ),
                          hint: Text(
                            'Choisir',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),
                          ),
                          items: service
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ))
                              .toList(),
                          value: serviceValue,
                          onChanged: (value) {
                            setState(() {
                              serviceValue = value.toString();
                            });
                          },
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          itemHeight: 40,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text("Téléphone:"),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: 60,
                        child: IntlPhoneField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: background,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(2),),
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: '032655333333',
                            labelText: 'Téléphone',
                            suffixIcon: Icon(Icons.phone_android_outlined),
                          ),
                          initialCountryCode: 'BE',
                          onChanged: (phone) {
                            phoneNumber = phone.completeNumber;
                            //telController.text = phoneNumber;
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text("Description: "),
                          Icon(Icons.help)
                        ],
                      )
                  ),
                  Container(
                      width: double.infinity,
                      child: TextFormField(
                        minLines: 4,
                        maxLines: 6,
                        //controller: dateController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: background,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                        ),
                        validator: (String? value) {
                          return (value != null && value.isEmpty)
                              ? 'field required!'
                              : null;
                        },
                      )
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Note: (Interne):"),
                    ),
                    Container(
                        width: double.infinity,
                        child: TextFormField(
                          minLines: 4,
                          maxLines: 6,
                          //controller: dateController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: background,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                          ),
                          validator: (String? value) {
                            return (value != null && value.isEmpty)
                                ? 'field required!'
                                : null;
                          },
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
