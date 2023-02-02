
import 'dart:convert';

import 'package:admin/controllers/animatonFadeIn.dart';
import 'package:admin/main.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../color_constants.dart';
import '../../responsive.dart';
import 'Drawer_windows/employee_drawer.dart';
import 'package:http/http.dart' as http;

class Employee extends StatefulWidget {

  const Employee({
    Key? key
  }) : super(key: key);

  @override
  State<Employee> createState() => EmployeeState();

}

class EmployeeState extends State<Employee>{

  final List<String> services = [
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

  String? selectedService;
  String? selectedPlace;
  bool isBlockView = true;
  bool isListView = false;
  List employes=[];
  bool isLoadind = true;
  final box = Hive.box("myBox");


@override
  initState() {
    initializePage();
  }

  initializePage()async{

    getAllEmployees();
    employes = await getAllEmployees();
  }

 Future getAllEmployees()async{
   var headers = {
     'Content-Type': 'application/json'
   };
   var request = http.Request('GET', Uri.parse('${Domain.serverPort}/api/v1/employees'));

   request.headers.addAll(headers);

   http.StreamedResponse response = await request.send();

   if (response.statusCode == 200) {
     setState(() {
       isLoadind = false;
     });
     //print(await response.stream.bytesToString());
     var allEmployees = await response.stream.bytesToString();
     return json.decode(allEmployees);
   }
   else {
     setState(() {
       isLoadind = false;
     });
     print(response.reasonPhrase);
   }
  }

  @override
  Widget build(BuildContext context){
    return Material(
      child: FadeIn(delay: 50, child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      color: background,
      height: MediaQuery.of(context).size.height - 80,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Palette.background,
            child: Row(
              children: [
                Text("Employees", style: TextStyle(color: appColor, fontSize: 20),),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: background,
                  child: Center(
                    child: Text(employes.length.toString()),
                  ),
                ),
                SizedBox(width: 10),
                Text("Total", style: TextStyle(color: Colors.grey, fontSize: 20),),
                Spacer(flex: 2),
                ElevatedButton.icon(onPressed: (){
                  showDialog(
                    context: context,
                    builder: (_) {
                      return EmployeeDrawer();
                    },
                  );
                }, icon: Icon(Icons.add), label: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("Ajouter un Employée"),
                ))
              ],
            ),
          ),
          SizedBox(height: 3),
          Container(
            padding: EdgeInsets.only(left: 30,top: 10,bottom: 10, right: 30),
            width: MediaQuery.of(context).size.width,
            color: Palette.background,
            child: Column(
              children: [
                Row(
                  children: [
                    if (!Responsive.isMobile(context))
                      Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        buttonPadding: EdgeInsets.only(left: 10),
                        buttonWidth: 200,
                        buttonHeight: 40,
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: backgroundColor,
                        ),
                        hint: Text(
                          'Tous les services',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: services
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
                        value: selectedService,
                        onChanged: (value) {
                          setState(() {
                            selectedService = value as String;
                          });
                        },
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                        itemHeight: 40,
                      ),
                    ),
                    SizedBox(width: 10),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        buttonPadding: EdgeInsets.only(left: 10),
                        buttonWidth: 200,
                        buttonHeight: 40,
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: backgroundColor,
                        ),
                        hint: Text(
                          'Tous les emplacements',
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
                        value: selectedPlace,
                        onChanged: (value) {
                          setState(() {
                            selectedPlace = value as String;
                          });
                        },
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                        itemHeight: 40,
                      ),
                    ),
                    SizedBox(width: 10),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        buttonPadding: EdgeInsets.only(left: 10),
                        buttonWidth: 150,
                        buttonHeight: 40,
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: backgroundColor,
                        ),
                        hint: Text(
                          'Trier par',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: services
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
                        value: selectedService,
                        onChanged: (value) {
                          setState(() {
                            selectedService = value as String;
                          });
                        },
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                        itemHeight: 40,
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: (){
                        setState(() {
                          isBlockView = true;
                          isListView = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: isBlockView ? CupertinoColors.systemBlue : Colors.grey, width: 2)
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.dashboard, color: isBlockView ? CupertinoColors.systemBlue : Colors.grey,),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: (){
                        setState(() {
                          isListView = true;
                          isBlockView = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: isListView ? CupertinoColors.systemBlue : Colors.grey, width: 2)
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.view_agenda, color: isListView ? CupertinoColors.systemBlue : Colors.grey,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          if(isLoadind)
         Column(
           children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/4,
            ),
             SizedBox(
               height: 30,
               width: 30,
               child: CircularProgressIndicator(
                 backgroundColor: validateColor.withOpacity(0.2),
                 color: validateColor,
               ),
             ),
           ],
         ),
          if(isBlockView)
          Expanded(
              child: GridView.builder(
                  itemCount: employes.length,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.isDesktop(context) ? 3 : 2, mainAxisExtent: 160.0, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0),
                  itemBuilder: (context, index) {
                    //articles?.sort((a, b) => b.date.compareTo(a.date));
                    return InkWell(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (_) {
                              return EmployeeDrawer();
                            },
                          );
                          box.put("employeeId", employes[index]["id"]);
                        },
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.8),
                                    offset: Offset(2, 2),
                                    blurRadius: 16,
                                  ),
                                ],
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        padding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(Radius.circular(30))
                                        ),
                                        child: Text(employes[index]["status"], style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                                    )
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage('assets/images/photo_2022-11-23_04-40-34.jpg'), fit: BoxFit.fill
                                              //image: AssetImage(employes[index]["pictureFullPath"]), fit: BoxFit.fill
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${employes[index]["firstName"].toUpperCase()} ${employes[index]["lastName"]}", style: TextStyle(color: appColor, fontSize: 20)),
                                        Text(employes[index]["email"], style: TextStyle(color: Colors.grey, fontSize: 15)),
                                        Text(employes[index]["phone"], style: TextStyle(color: Colors.grey, fontSize: 15)),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                        )
                    );
                  }
              )
          ),
          if(isListView)
            Container(
              width: double.infinity,
              color: Palette.background,
              child: DataTable2(
                columnSpacing: defaultPadding,
                minWidth: 600,
                dataRowHeight: 60,
                showCheckboxColumn: false,
                columns: [
                  DataColumn(
                    label: Text("Employée", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                  ),
                  DataColumn(
                    label: Text("email", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                  ),
                  DataColumn(
                    label: Text("Telephone", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                  ),
                  DataColumn(
                    label: Text("Status", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                  ),
                ],
                rows: List.generate(
                  employes.length,
                      (index) => DataRow(
                          onSelectChanged: (_){
                            showDialog(
                              context: context,
                              builder: (_) {
                                return EmployeeDrawer();
                              },
                            );
                          },
                          cells: [
                            DataCell(
                                Row(
                                  children: [
                                    Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                            image: DecorationImage(
                                                image: AssetImage("assets/images/photo_2022-11-23_04-40-50.jpg"), fit: BoxFit.fill))),
                                    SizedBox(width: 5),
                                    Text("${employes[index]["firstName"].toUpperCase()} ${employes[index]["lastName"]}", style: TextStyle(color: Color(0xFF032252), fontSize: 15))
                                  ],
                                )
                            ),
                            DataCell(Text(employes[index]["email"], style: TextStyle(color: Color(0xFF032252), fontSize: 15))),
                            DataCell(Text(employes[index]["phone"], style: TextStyle(color: Color(0xFF032252), fontSize: 15))),
                            DataCell(
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(Radius.circular(30))
                                    ),
                                    child: Text(employes[index]["status"], style: TextStyle(color: validateColor, fontWeight: FontWeight.bold))
                                )
                            ),
                          ]
                      )
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildBottom(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: background,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
      child: Row(
        children: [
          Text("Showing 1 to 2 of 2 employees"),
          Spacer(flex: 2),
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: (){
              showDialog(
                context: context,
                builder: (_) {
                  return EmployeeDrawer();
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