import 'dart:convert';

import 'package:admin/responsive.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../color_constants.dart';
import '../../controllers/animatonFadeIn.dart';
import '../../main.dart';
import 'Drawer_windows/services_drawer.dart';
import 'package:http/http.dart' as http;

class Services extends StatefulWidget {

  const Services({
    Key? key
  }) : super(key: key);

  @override
  State<Services> createState() => ServicesState();

}

class ServicesState extends State<Services>{

  int currentIndex = 0;
  int selectedCategory = 0;
  bool addCategory = false;
  List allCategories = [];
  bool isLoading = false;
  bool isEmpty = false;
  bool update = false;
  int categoryId = 0;

  @override
  void initState() {
    super.initState();
    initializePage();
  }

  initializePage()async{
    final List list = await getAllCategories();
    setState(() {
      allCategories = list;
    });
    //print(allCategories);
  }

  Future getAllCategories()async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('${Domain.serverPort}/api/v1/categories'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      return json.decode(data);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  final List<String> filter = [
    'Nom croissant',
    'Nom décroissant',
  ];
  final List<String> categories = [];
  final List<String> services = [
    'Dégradé',
    '3 niveaux',
    '2 niveaux',
    'punk',
  ];

  String? filterValue;
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Material(
      child: FadeIn(delay: 50, child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      color: background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Palette.background,
            child: Row(
              children: [
                Text("Services", style: TextStyle(color: appColor, fontSize: 20),),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: background,
                  child: Center(
                    child: Text("2"),
                  ),
                ),
                SizedBox(width: 10),
                Text("Total", style: TextStyle(color: Colors.grey, fontSize: 20),),
                Spacer(flex: 2),
                ElevatedButton.icon(onPressed: (){
                  showDialog(
                    context: context,
                    builder: (_) {
                      return ServicesDrawer();
                    },
                  );
                }, icon: Icon(Icons.add), label: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("Ajouter un Service"),
                ))
              ],
            ),
          ),
          SizedBox(height: 3),
          Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 170,
              color: Palette.background,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      children: [
                        buildCategories(context),
                        if(Responsive.isDesktop(context))
                          buildServices(context),
                      ],
                    ),
                    buildBottom(context)
                  ],
                )
              )
          ),
        ],
      )
    );
  }

  Widget buildCategories(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      color: background,
      padding: EdgeInsets.only(left: 5, bottom: 5,top: 10, right: 15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text("Catégories", style: TextStyle(color: appColor, fontSize: 20),),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.7,
            child: ListView.builder(
              itemCount: allCategories.length,
                itemBuilder: (context, index){
                for(var i=0; i< categories.length; i++){

                }
                return InkWell(
                    onTap: (){
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(right: selectedCategory == index ? 5 : 15, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              selectedCategory == index ? BoxShadow(color: Colors.grey, blurRadius: 16): BoxShadow()
                            ],
                            border: selectedCategory == index ? Border.all(color:  doneStatus, width: 3) : null,
                            color: Palette.background
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.menu),
                                SizedBox(width: 15),
                                Text(allCategories[index]["name"])
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(Radius.circular(5))
                                    ),
                                    child: Text("2 Services", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
                                ),
                                Spacer(flex: 2),
                                IconButton(
                                    onPressed: (){
                                      setState(() {
                                        update = true;
                                        addCategory = true;
                                        categoryId = allCategories[index]["id"];
                                      });
                                      categoryController.text = allCategories[index]["name"];
                                    },
                                    icon: Icon(Icons.edit, color: newStatus)),
                                IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.copy, color: inactive)),
                                IconButton(
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
                                                              icon: Icon(Icons.delete, size: 14),
                                                              style: ElevatedButton.styleFrom(primary: specialColor),
                                                              onPressed: () {
                                                                deleteCategory(allCategories[index]["id"]);
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
                                                              ) : Text("Suprimer")
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.delete, color: specialColor)),
                              ],
                            )
                          ],
                        )
                    )
                );
                }),
          ),
          if(addCategory)
          Container(
            padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: appColor),
              ),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.menu),
                      SizedBox(width: 20),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: 40,
                        child: TextFormField(
                          controller: categoryController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: isEmpty ? specialColor : blue)),
                            hintText: 'Nouvel Catégorie',
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Text("0 Services", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
                      ),
                      Spacer(flex: 2),
                      !update ? IconButton(
                          onPressed: (){

                        if(categoryController.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          addNewCategory();
                        }else{
                          setState(() {
                            isEmpty = true;
                          });
                        }
                      },
                          icon: isLoading ? SizedBox(
                            width: 10,
                            height: 10,
                          child: CircularProgressIndicator(
                            color: validateColor,
                            backgroundColor: validateColor.withOpacity(0.2),
                          )) : Icon(Icons.check_circle, color: Colors.blue)
                      ) : IconButton(
                          onPressed: (){
                            updateCategory(categoryId);
                          },
                          icon: Icon(Icons.update)),
                      IconButton(
                          onPressed: (){
                            setState(() {
                              addCategory = false;
                              update = false;
                              categoryController.clear();
                            });
                          },
                          icon: Icon(Icons.close, color: inactive)),
                    ],
                  )
                ],
              )
          )
        ],
      )
    );
  }

  Widget buildServices(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
        padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text("Tous les Services", style: TextStyle(color: appColor, fontSize: 20),),
              Spacer(flex: 2),
              Text("Filtrer par: ", style: TextStyle(color: appColor, fontSize: 15),),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  buttonPadding: EdgeInsets.only(left: 10),
                  buttonWidth: MediaQuery.of(context).size.width / 7,
                  buttonHeight: 40,
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    color: background,
                  ),
                  items: filter
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
                  value: filterValue,
                  onChanged: (value) {
                    setState(() {
                      filterValue = value.toString();
                      if(filterValue == "Nom croissant"){
                        print("nom croissant");
                      }else{
                        print("descending");
                      }
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                  itemHeight: 40,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.7,
            child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: background),
                              color: Palette.background,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.menu),
                              SizedBox(width: 10),
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/shave.png")
                                  ),
                                  color: background,
                                ),
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          border: Border.all(width: 3, color: Colors.white),
                                          shape: BoxShape.circle,
                                        )
                                    )
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(services[index]),
                              Spacer(flex: 2),
                              Text("Duré: 30min"),
                              SizedBox(width: 20),
                              Text("Price: €5.00"),

                            ],
                          )
                      ),
                      SizedBox(height: 10)
                    ],
                  );
                }),
          ),
        ],
      )
    );
  }

  Widget buildBottom(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 50, right: 20, bottom: 5),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              if(!addCategory && !update) {
                setState(() {
                  addCategory = true;
                });
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 5,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: addCategory && update ? inactive : Colors.blue
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  Text("Ajouter une Catégorie", style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),
          Spacer(flex: 2),
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: (){
              showDialog(
                context: context,
                builder: (_) {
                  return ServicesDrawer();
                },
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void addNewCategory() async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${Domain.serverPort}/api/v1/categories'));
    request.body = json.encode({
      "status": "VISIBLE",
      "name": categoryController.text,
      "position": 1,
      "translations": "string",
      "image": "string",
      "note": "string"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Succès',
          message:
          "Nouvelle Catégorie ajouté avec succès",
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      setState(() {addCategory = false;});
      setState(() {isLoading = false;});
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
      setState(() {
        isLoading = false;
      });
    }
  }

  void deleteCategory(int id) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse('${Domain.serverPort}/api/v1/categories/$id'));

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
    }
    else {
      final error = await response.stream.bytesToString();
      var errorMessage = json.decode(error)["error"];
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
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateCategory(int id) async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse('${Domain.serverPort}/api/v1/categories/$id'));
    request.body = json.encode({
      "id": id,
      "status": "HIDDEN",
      "name": categoryController.text,
      "position": 0,
      "translations": "horizontal",
      "image": "image",
      "note": "string"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var output = await response.stream.bytesToString();
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
}
