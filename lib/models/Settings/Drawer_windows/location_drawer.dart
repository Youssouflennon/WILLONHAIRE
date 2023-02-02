import 'package:admin/controllers/animation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../color_constants.dart';

class LocationDrawer extends StatefulWidget {

  const LocationDrawer({
    Key? key
  }) : super(key: key);

  @override
  State<LocationDrawer> createState() => LocationDrawerState();
}

class LocationDrawerState extends State<LocationDrawer> {


  String? phoneNumber;
  bool onSaveLoading = false;
  int indexSelected = 0;

  /*@override
  void initState() {
    // TODO: implement initState
    categoryValue = category.elementAt(0);
    serviceValue = service.elementAt(0);
    placeValue = emplacements.elementAt(0);
    employeeValue = employee.elementAt(0);
    super.initState();
  }*/

  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(delay: 50,
        child: Container(
            width: MediaQuery.of(context).size.width / 3,
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.6, right: 0),
            child: Drawer(
                backgroundColor: Palette.background,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text("Nouvel Emplacement"),
                        Spacer(flex: 2),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        },
                            icon: Icon(Icons.close))
                      ],
                    ),
                    Divider(color: Colors.grey),
                    SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.height - 150,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: background
                            ),
                            child: Center(
                              child: Icon(Icons.location_on, color: Colors.white, size: 100,),
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
                              Text("Adresse:"),
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
                              Text("Téléphone:"),
                              Container(
                                width: double.infinity,
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
                                  initialCountryCode: 'IN',
                                  onChanged: (phone) {
                                    phoneNumber = phone.completeNumber;
                                    //telController.text = phoneNumber;
                                  },
                                ),
                              )
                            ],
                          ),
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
                        ],
                      ),
                    ),

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
}
