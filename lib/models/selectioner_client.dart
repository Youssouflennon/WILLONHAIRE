import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:page_transition/page_transition.dart';
import '../color_constants.dart';
import 'InterfacePOS.dart';

class SelectClient extends StatefulWidget {

  const SelectClient({
    Key? key
  }) : super(key: key);

  @override
  State<SelectClient> createState() => SelectClientState();

}

class SelectClientState extends State<SelectClient>{

  bool profileImage = false;
  bool onEditClick = false;
  bool toEdit = false;
  bool onSelectClick = false;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  final storage = const FlutterSecureStorage();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController barCodeController = TextEditingController();
  TextEditingController rueController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController tvaController = TextEditingController();

  int selectedIndex = 0;
  onSelected(int index) {
    setState(() => selectedIndex = index);
  }

  final box = Hive.box("myBox");

  editClient(){
    if(onSelectClick) {
      setState(() {
        nameController.text = "Larson Midoriya";
        emailController.text = "larson@gmail.com";
        addressController.text = "yaounde";
        rueController.text = "Rue 423311 Yaoundé 5";
        telController.text = "+325789678596";
        barCodeController.text = "2223456788999876543";
        townController.text = "Yaounde";
        postalCodeController.text = "42-downtown";
        tvaController.text = "121122";
      });
    }
  }

  List _elements = [
    {'Telephone': '+237697665522','employee': 'Salomon', 'address': 'Belgique', 'day': 'lundi'},
    {'Telephone': '+327623453654','employee': 'William', 'address': 'Cameroun', 'day': 'lundi'},
    {'Telephone': '+4325678996755','employee': 'William', 'address': 'Limbe', 'day': 'lundi'},
    {'Telephone': '+476235463587467','employee': 'Salomon', 'address': 'Douala', 'day': 'lundi'},
    {'Telephone': '+237697665522','employee': 'Salomon', 'address': 'Belgique', 'day': 'lundi'},
    {'Telephone': '+327623453654','employee': 'William', 'address': 'Cameroun', 'day': 'lundi'},
    {'Telephone': '+4325678996755','employee': 'William', 'address': 'Limbe', 'day': 'lundi'},
    {'Telephone': '+476235463587467','employee': 'Salomon', 'address': 'Douala', 'day': 'lundi'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.only(top: defaultPadding, bottom: defaultPadding),
        decoration: BoxDecoration(
          color: fond,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 10),
                Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.brown),
                            color: backgroundColor
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.keyboard_double_arrow_left),
                            Text('Annuler', style: TextStyle(fontSize: 20),)
                          ],
                        ),
                      ),
                    )
                ),
                Spacer(flex: 2),
                Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width / 5,
                  child: TextFormField(
                    //controller: emailController,
                    autofocus: false,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                      hintText: 'Rechercher un client',
                      filled: true,
                    ),
                    validator: (inputValue) {
                      if (inputValue!.isEmpty) {
                        return "field Required!";
                      }
                    },
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.brown),
                      color: backgroundColor
                    ),
                    child: Icon(Icons.person_add_alt_1),
                  ),
                ),
                SizedBox(width: 10),
                onSelectClick ?
                InkWell(
                  onTap: (){
                    setState(() {
                      Navigator.pop(context);
                      Navigator.of(context).push( MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                            return SelectClient();
                          },
                          fullscreenDialog: true));
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.brown
                    ),
                    child: Text("Dé-sélectionner le client", style: TextStyle(fontSize: 20, color: CupertinoColors.white)),
                  ),
                ) :
                SizedBox(width: 20),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 10),
            Container(
              color: backgroundColor,
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CupertinoColors.white,
                        image: profileImage ? DecorationImage(
                            image: AssetImage("assets/images/offer.png")
                        ) : null
                    ),
                    child: Center(
                      child: !profileImage ? Icon(Icons.photo_camera, size: 30) : null,
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 70),
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 40,
                              child: TextFormField(
                                controller: nameController,
                                readOnly: onEditClick,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: onEditClick ? Colors.black12 : CupertinoColors.white,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                                  hintText: "Nom",
                                  hintStyle: TextStyle(fontSize: 12),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 70,
                            child: Text("Rue"),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 40,
                              child: TextFormField(
                                controller: rueController,
                                readOnly: onEditClick,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: onEditClick ? Colors.black12 : CupertinoColors.white,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                                  hintText: "Rue",
                                  hintStyle: TextStyle(fontSize: 12),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 70,
                            child: Text("Ville"),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 40,
                              child: TextFormField(
                                controller: townController,
                                readOnly: onEditClick,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: onEditClick ? Colors.black12 : CupertinoColors.white,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                                  hintText: "Ville",
                                  hintStyle: TextStyle(fontSize: 12),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 70,
                            child: Text("Code \nPostal"),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 40,
                              child: TextFormField(
                                controller: postalCodeController,
                                readOnly: onEditClick,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: onEditClick ? Colors.black12 : CupertinoColors.white,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                                  hintText: "Code Postal",
                                  hintStyle: TextStyle(fontSize: 12),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 70,
                            child: Text("Ville et \nEtat"),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: CSCPicker(
                              showCities: false,
                              onCountryChanged: (value) {
                                setState(() {
                                  countryValue = value;
                                });
                              },
                              onStateChanged:(value) {
                                if(value != null) {
                                  setState(() {
                                    stateValue = value;
                                  });
                                }
                              },
                              onCityChanged:(value) {
                                if(value != null) {
                                  setState(() {
                                    cityValue = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Container(
                            width: 70,
                            child: Text("Email"),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 40,
                              child: TextFormField(
                                controller: emailController,
                                readOnly: onEditClick,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: onEditClick ? Colors.black12 : CupertinoColors.white,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                                  hintStyle: TextStyle(fontSize: 12),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 70,
                            child: Text("Téléphone"),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 40,
                              child: TextFormField(
                                controller: telController,
                                readOnly: onEditClick,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: onEditClick ? Colors.black12 : CupertinoColors.white,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                                  hintStyle: TextStyle(fontSize: 12),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 70,
                            child: Text("Code-barres"),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 40,
                              child: TextFormField(
                                controller: barCodeController,
                                readOnly: onEditClick,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: onEditClick ? Colors.black12 : CupertinoColors.white,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                                  hintStyle: TextStyle(fontSize: 12),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 70,
                            child: Text("N° TVA"),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: 40,
                              child: TextFormField(
                                controller: tvaController,
                                readOnly: onEditClick,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: onEditClick ? Colors.black12 : CupertinoColors.white,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                                  hintStyle: TextStyle(fontSize: 12),
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
                  Column(
                    children: [
                      IconButton(
                          onPressed: (){

                          }, icon: Icon(Icons.refresh, size: 30, color: CupertinoColors.black)
                      ),
                      SizedBox(height: 15),
                      if(onSelectClick)
                        IconButton(
                            onPressed: (){
                              setState(() {
                                onEditClick = !onEditClick;
                              });
                            }, icon: Icon(Icons.edit, size: 30, color: !onEditClick ? CupertinoColors.activeBlue : CupertinoColors.black)
                        )
                    ],
                  ),
                  IconButton(
                      onPressed: (){
                        if(onSelectClick){
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 500),
                                child: InterfacePOS()),
                          );
                        }
                      }, icon: Icon(Icons.save, size: 30, color: onSelectClick ? CupertinoColors.black : Colors.black12)
                  ),

                ],
              )
            ),
            Expanded(
                child: GroupedListView<dynamic, String>(
                  elements: _elements,
                  groupBy: (element) => element['day'],
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1['employee'].compareTo(item2['employee']),
                  order: GroupedListOrder.ASC,
                  useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) => Container(
                      color: barMenu,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            SizedBox(width: 300,child: Text(
                              "Nom",
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
                            )),
                            SizedBox(width: MediaQuery.of(context).size.width / 4,child: Text(
                              "Adresse",
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
                            )),
                            SizedBox(width: 150,child: Text(
                              "Téléphone",
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
                            )),
                            Spacer(),
                            SizedBox(width: 100,child: Text(
                              "Action",
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
                            ))
                          ],
                        )
                      )
                  ),
                  itemBuilder: (c, element) {
                    return Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: backgroundColor)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 300,
                                  child: Text(element['employee'])),
                              SizedBox(width: MediaQuery.of(context).size.width / 4, child: Text(element['address']),),

                              SizedBox(
                                  width: 150,
                                  child: Text(element['Telephone'])),
                              Spacer(),
                              SizedBox(
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: (){
                                            setState(() {
                                              onSelectClick = true;
                                              onEditClick = true;
                                              editClient();
                                            });
                                            box.put("getClient", element['employee']);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                                color: blue
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.check, color: CupertinoColors.white),
                                                Text("Sélectionner", style: TextStyle(color: CupertinoColors.white))
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ],
                      )
                    );
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
