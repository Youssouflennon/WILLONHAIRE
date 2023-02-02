import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../color_constants.dart';

class ServicesDetails extends StatefulWidget {

  const ServicesDetails({
    Key? key
  }) : super(key: key);

  @override
  State<ServicesDetails> createState() => ServicesDetailsState();

}

class ServicesDetailsState extends State<ServicesDetails>{


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
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Container(
                height:150,
                width: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: background,
                    image: DecorationImage(
                        image: AssetImage('assets/images/picture.png'),
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

                      },
                          icon: Icon(Icons.photo_camera, size: 30, color: CupertinoColors.systemBlue,)
                      ),
                    )
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nom:"),
                  Container(
                      width: double.infinity,
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
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Catégories:"),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      buttonPadding: EdgeInsets.only(left: 10),
                      buttonWidth: double.infinity,
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
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Employées:"),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      buttonPadding: EdgeInsets.only(left: 10),
                      buttonWidth: double.infinity,
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
                      items: employee
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
              SizedBox(height: 20),
              Container(
                child: Column(
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
              ),
            ],
          ),
        )
    );
  }
}
