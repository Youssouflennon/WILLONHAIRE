import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;

import '../../../../color_constants.dart';
import '../../../../main.dart';

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
  bool onSaveLoading = false;
  bool homme = false;
  bool femme = false;
  String gender = "";
  String profilePic = "";
  String employeeId = "";
  String userId = "";
  bool isLoading = false;
  bool deleted = false;

  final box = Hive.box('myBox');

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkValue();
  }

  checkValue(){
    if(box.get("employeeId") != null){
      setState(() {
        employeeId = box.get("employeeId").toString();
      });
    }
    if(employeeId.isNotEmpty){

    }
  }

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

  File? image;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telController = TextEditingController();
  //TextEditingController firstNameController = TextEditingController();

  imagePicker() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        image = File(result.files.single.path.toString());
      });
    } else {
      print("No file selected");
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
              Material(
                child: InkWell(
                  onTap: (){
                    imagePicker();
                  },
                  child: image != null ? image!.path.isEmpty ? Container(
                    height:150,
                    width: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: background,
                        image: profilePic.isNotEmpty ? DecorationImage(
                            image: AssetImage('assets/images/man.png')
                        ) : null
                    ),
                    child: Icon(Icons.photo_camera, size: 50, color: inactive),
                  ) : Image.file(
                    File(image!.path),
                    fit: BoxFit.contain,
                    width: 150,
                    height: 150
                  ) : CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.indigoAccent,
                      child: Icon(Icons.photo_camera, size: 50, color: Palette.background),
                  )
                )
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
                            controller: firstNameController,
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
                            controller: lastNameController,
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
                            controller: emailController,
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
                            telController.text = phoneNumber;
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                  children: [
                    Text("Sexe: "),
                    SizedBox(width: 15),
                    Text("HOMME"),
                    Checkbox(
                      value: homme,
                      onChanged: (value) {
                        setState(() {
                          femme = false;
                          homme = !homme;
                          gender = "MALE";
                        });
                        print(gender);
                      },
                    ),
                    Text("FEMME"),
                    Checkbox(
                      value: femme,
                      onChanged: (value) {
                        setState(() {
                          homme = false;
                          femme = !femme;
                          gender = "FEMALE";
                        });
                        print(gender);
                      },
                    ),
                  ]
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
                          return null;
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
                            return null;
                          },
                        )
                    ),
                  ],
                ),
              ),
              if(employeeId.isNotEmpty)...[
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                  title: Center(
                                    child: Column(
                                      children: [
                                        Icon(Icons.warning_outlined,
                                            size: 36, color: Colors.red),
                                        SizedBox(height: 20),
                                        Text("Confirmer la Supression"),
                                      ],
                                    ),
                                  ),
                                  content: Container(
                                    //color: Palette.background,
                                    height: 70,
                                    child: Column(
                                      children: [
                                        Text(
                                            "Voulez-vous vraiment Suprimer cet élément?", style: TextStyle(color: Color(0xFF032252))),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 14,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    primary: inactive),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                label: Text("Annuler")),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            ElevatedButton.icon(
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 14,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    primary: specialColor),
                                                onPressed: () {
                                                  deleteEmployee(employeeId);
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                },
                                                label: isLoading ? SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: CircularProgressIndicator(
                                                    color: validateColor,
                                                  ),
                                                ) : deleted ? Icon(Icons.check_circle, color: Colors.green) : Text("Suprimer")
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                            });
                      },
                      child: Text("Suprimer cette Employé", style: TextStyle(fontSize: 20,color: specialColor, fontWeight: FontWeight.bold, decoration: TextDecoration.underline))
                  )
                )
              ],
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                  child: Row(
                    children: [
                      Spacer(flex: 2),
                      InkWell(
                        child: Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                border: Border.all(color: Colors.black12)
                            ),
                            child: Text("Annuler", style: TextStyle(color: Colors.grey.withOpacity(0.6)),)
                        ),
                        onTap: (){
                          Navigator.pop(context);
                          box.delete("employeeId");
                        },
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()) {
                              setState(() {
                                onSaveLoading = true;
                                addEmployee();
                              });
                            }
                          },
                          child: Container(
                              width: 140,
                              height: 40,
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: onSaveLoading ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1.5,
                                    )) : Text("Enregistrer"),
                              )
                          )
                      ),
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }

  void addEmployee()async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${Domain.serverPort}/api/v1/employees'));
    request.body = json.encode({
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "email": emailController.text,
      "password": "Employee@123",
      "gender": gender,
      "phone": telController.text,
      "image": image!.path
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Succès',
          message:
          'Employé ${firstNameController.text} ${lastNameController.text} a été crée avec succès',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      //Navigator.pop(context);
    }
    else {
      final error = await response.stream.bytesToString();
      var errorMessage = json.decode(error)["error"];
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'échec',
          message:
          "Oups! $errorMessage",
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  void deleteEmployee(String id) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse('${Domain.serverPort}/api/v1/employees/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var output = await response.stream.bytesToString();
      Navigator.pop(context);
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Succès',
          message: output,
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      setState(() {
        isLoading =false;
        deleted = true;
      });
      box.delete("employeeId");
    }
    else {
      setState(() {
        isLoading =false;
      });
      final error = await response.stream.bytesToString();
      var errorMessage = json.decode(error);
      Navigator.pop(context);
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'échec',
          message:
          "Oups! $errorMessage",
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      box.delete("employeeId");
    }
  }
}
