import 'package:admin/controllers/animation.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../color_constants.dart';
import 'package:intl/intl.dart';


class SideMenu extends StatefulWidget {

  const SideMenu({
    Key? key
  }) : super(key: key);

  @override
  State<SideMenu> createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  int currentIndex = 0;
  int indexSelected = 0;
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

  String? categoryValue;
  String? serviceValue;
  String? placeValue;
  String? employeeValue;
  String? hourValue;
  bool onSaveLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    categoryValue = category.elementAt(0);
    serviceValue = service.elementAt(0);
    placeValue = emplacements.elementAt(0);
    employeeValue = employee.elementAt(0);
    super.initState();
  }

  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(delay: 50,
        child: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Drawer(
                backgroundColor: Palette.background,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text("Nouveau rendez-vous"),
                        Spacer(flex: 2),
                        IconButton(onPressed: (){
                          Scaffold.of(context).closeEndDrawer();
                        },
                            icon: Icon(Icons.close))
                      ],
                    ),
                    Divider(color: Colors.grey),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        TextButton(
                            onPressed: (){
                              setState((){
                                indexSelected = 0;
                              });

                            }, child:
                        Text("Planning", style: TextStyle(color: indexSelected == 0 ? Colors.blue : appColor))
                        ),
                        TextButton(
                            onPressed: (){
                              setState((){
                                indexSelected = 1;
                              });
                            }, child:
                        Text("Options", style: TextStyle(color: indexSelected == 1 ? Colors.blue : appColor))
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey),
                    Expanded(
                      child: ListView(
                        children: [

                          indexSelected == 0 ? buildPlanning() : indexSelected == 1 ? buildOptions() : buildPayment(),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
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
                              },
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                                onPressed: (){
                                  setState(() {
                                    onSaveLoading = !onSaveLoading;
                                  });
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
                )
            )
        )
    );
  }

  Future _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 0)),
        lastDate: DateTime(2030),
      selectableDayPredicate: (DateTime dateTime) {
        if (dateTime == DateTime(2022, 12, 23) || dateTime == DateTime(2022, 12, 28)) {
          return false;
        }
        return true;
      },
    );
    String formattedDate = DateFormat("dd/MM/yyyy").format(pickedDate!);
    if(pickedDate != null ){
      setState(() {
        dateController.text = formattedDate; //set output date to TextField value.
      });
    }
  }

  Widget buildPlanning(){

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Client(s):"),
                ),
                Container(
                    width: double.infinity,
                    height: 40,
                    child: TextFormField(
                      //controller: dateController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: backgroundColor,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                        hintText: "Clients",
                        hintStyle: TextStyle(fontSize: 12),
                        prefixIcon: Icon(Icons.group, size: 15),
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
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Catégorie:"),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    buttonPadding: EdgeInsets.only(left: 10),
                    buttonWidth: double.infinity,
                    buttonHeight: 40,
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: backgroundColor,
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
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Service:"),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    buttonPadding: EdgeInsets.only(left: 10),
                    buttonWidth: double.infinity,
                    buttonHeight: 40,
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: backgroundColor,
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
            SizedBox(height: 20),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Emplacement:"),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    buttonPadding: EdgeInsets.only(left: 10),
                    buttonWidth: double.infinity,
                    buttonHeight: 40,
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: backgroundColor,
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
                    items: emplacements
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
                    value: placeValue,
                    onChanged: (value) {
                      setState(() {
                        placeValue = value.toString();
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
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Employés:"),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    buttonPadding: EdgeInsets.only(left: 10),
                    buttonWidth: double.infinity,
                    buttonHeight: 40,
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: backgroundColor,
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
                    value: employeeValue,
                    onChanged: (value) {
                      setState(() {
                        employeeValue = value.toString();
                      });
                    },
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    itemHeight: 40,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 200,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Date:"),
                      ),
                      Container(
                          width: 230,
                          height: 40,
                          child: TextFormField(
                            controller: dateController,
                            onTap: (){
                              _selectDate();
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: backgroundColor,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                              hintText: "Date de rendez-vous",
                              hintStyle: TextStyle(fontSize: 12),
                              prefixIcon: Icon(Icons.calendar_today_outlined, size: 15),
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
                Spacer(flex: 2),
                Container(
                  width: 200,
                  child:
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Heure:"),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonPadding: EdgeInsets.only(left: 10),
                          buttonWidth: double.infinity,
                          buttonHeight: 40,
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: backgroundColor,
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
                          items: hours
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
                          value: hourValue,
                          onChanged: (value) {
                            setState(() {
                              hourValue = value.toString();
                            });
                          },
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          itemHeight: 40,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Note (interne):"),
                  ),
                  Container(
                      width: double.infinity,
                      child: TextFormField(
                        minLines: 4,
                        maxLines: 6,
                        controller: dateController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: backgroundColor,
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
  Widget buildOptions(){
    return Container(
      child: Text("Options"),
    );
  }
  Widget buildPayment(){
    return Container(
      child: Text("Paiement"),
    );
  }

}
