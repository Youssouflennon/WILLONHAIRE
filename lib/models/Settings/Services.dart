import 'package:admin/responsive.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../color_constants.dart';
import '../../controllers/animatonFadeIn.dart';
import 'Drawer_windows/services_drawer.dart';

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
  final List<String> filter = [
    'Nom croissant',
    'Nom décroissant',
  ];
  final List<String> categories = [
    'Coupe Ado',
    'Coupe Adult',
    'Coupe Enfant',
    'Coupe Homme',
  ];
  final List<String> services = [
    'Dégradé',
    '3 niveaux',
    '2 niveaux',
    'punk',
  ];

  String? filterValue;

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
              itemCount: categories.length,
                itemBuilder: (context, index){
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
                              Text(categories[index])
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
                              IconButton(onPressed: (){

                              },
                                  icon: Icon(Icons.edit, color: Colors.grey)),
                              IconButton(onPressed: (){

                              },
                                  icon: Icon(Icons.copy, color: Colors.grey)),
                              IconButton(onPressed: (){

                              },
                                  icon: Icon(Icons.delete, color: Colors.grey)),
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
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
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
                      IconButton(onPressed: (){
                        setState(() {
                          addCategory = false;
                        });
                      },
                          icon: Icon(Icons.check_circle, color: Colors.blue)),
                      IconButton(onPressed: (){

                      },
                          icon: Icon(Icons.copy, color: Colors.grey)),
                      IconButton(onPressed: (){

                      },
                          icon: Icon(Icons.delete, color: Colors.grey)),
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
              setState(() {
                addCategory = true;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 5,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.blue
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
}
