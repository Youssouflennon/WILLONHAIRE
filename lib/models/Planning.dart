import 'package:admin/color_constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../Drawer_Menu/drawer_menu.dart';
import '../responsive.dart';

class Planning extends StatefulWidget {

  const Planning({
    Key? key
  }) : super(key: key);

  @override
  State<Planning> createState() => PlanningState();

}

class PlanningState extends State<Planning>{

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

  List _elements = [
    {'client': 'John','employee': 'Salomon', 'day': 'lundi','profilePic': 'assets/images/photo_2022-11-23_04-40-50.jpg', 'service': 'coupe Adult', 'initTime': '12:00', 'status': 'En Attente'},
    {'client': 'Will','employee': 'William', 'day': 'lundi', 'profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'service': 'coupe Ado', 'initTime': '11:30', 'status': 'Annulé'},
    {'client': 'Beth','employee': 'William', 'day': 'mardi', 'profilePic': 'assets/images/photo_2022-11-23_04-40-50.jpg', 'service': 'coupe Ado', 'initTime': '15:00', 'status': 'Approuvé'},
    {'client': 'Miranda','employee': 'Salomon', 'day': 'jeudi', 'profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'service': 'coupe enfant', 'initTime': '9:30', 'status': 'Annulé'},
    {'client': 'Will','employee': 'William', 'day': 'lundi', 'profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'service': 'coupe Ado', 'initTime': '14:30', 'status': 'En Attente'},
    {'client': 'Beth','employee': 'William', 'day': 'mardi', 'profilePic': 'assets/images/photo_2022-11-23_04-40-50.jpg', 'service': 'coupe Ado', 'initTime': '13:00', 'status': 'Approuvé'},
    {'client': 'Miranda','employee': 'Salomon', 'day': 'jeudi', 'profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'service': 'coupe enfant', 'initTime': '16:00', 'status': 'Approuvé'},
  ];

  String firstDate = DateFormat("dd, MMMM", "fr_CA").format(DateTime.now()).toString();
  String lastDate = DateFormat("dd, MMMM", "fr_CA").format(DateTime.now().add(Duration(days: 5))).toString();

  selectDate()async{
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      locale: Locale("fr", "FR"),
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );
    List<String> dates = result.toString().split(" - ");
    List<String> initialDate = dates[0].split(" ");
    String date1 = initialDate[0];
    List<String> finalDate = dates[1].split(" ");
    String date2 = finalDate[0];
    DateTime startDate = DateTime.parse(date1);
    DateTime endDate = DateTime.parse(date2);
    setState(() {
      firstDate = DateFormat("dd, MMMM", "fr_CA").format(startDate).toString();
      lastDate = DateFormat("dd, MMMM", "fr_CA").format(endDate).toString();
    });
  }

  String? selectedService;
  String? selectedPlace;

  @override
  Widget build(BuildContext context) {
    double radius = 5;
    double width = MediaQuery.of(context).size.width / 7;
    return Material(
      child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: Responsive.isDesktop(context) ? 30 : 10, left: 10, right: 10),
                    color: Palette.background,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5),
                            if (!Responsive.isDesktop(context))
                              IconButton(
                                icon: Icon(Icons.menu, color: appColor),
                                //onPressed: context.read<MenuController>().controlMenu,
                                onPressed: (){
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return MenuDrawer();
                                    },
                                  );
                                },
                              ),
                            SizedBox(width: 10),
                            Text("Planning", style: TextStyle(color: appColor, fontWeight: FontWeight.bold, fontSize: 40, letterSpacing: 1),),

                            Spacer(flex: 2),
                            ElevatedButton.icon(
                                onPressed: (){
                                  Scaffold.of(context).openEndDrawer();
                                }, icon: Icon(Icons.add),
                                label: Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text("Nouveau rendez-vous", style: TextStyle(fontSize: 15))
                                )
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              padding: EdgeInsets.only(left: 10,right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                                  color: Palette.background,
                                  border: Border.all(color: inactive)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      '$firstDate - $lastDate',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    selectDate();
                                  },
                                      icon: Icon(Icons.calendar_today)),
                                ],
                              ),
                            ),
                            Spacer(),
                            //Text("Services: ", style: TextStyle(color: appColor, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1),),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                buttonPadding: EdgeInsets.only(left: 10),
                                buttonWidth: 220,
                                buttonHeight: 40,
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radius),
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
                            //Text("Emplacement: ", style: TextStyle(color: appColor, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1),),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                buttonPadding: EdgeInsets.only(left: 10),
                                buttonWidth: 220,
                                buttonHeight: 40,
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radius),
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
                          ],
                        ),
                      ],
                    )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  color: Palette.background,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Responsive.isDesktop(context) ?
                      Row(
                        children: [
                          InkWell(
                            child: Column(
                              children: [
                                Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(width: 1, color: blue),
                                        color: Colors.white
                                    ),
                                    child: Center(
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                          ),
                                          child: Center(
                                            child: Text("Tous", style: TextStyle(color: Colors.white)),
                                          ),
                                        )
                                    )
                                ),
                                SizedBox(height: 10),
                                Text("Tous les employées")
                              ],
                            ),
                            onTap: (){

                            },
                            hoverColor: Colors.redAccent,
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: _elements.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index){
                                        return Container(
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: AssetImage(_elements[index]["profilePic"]), fit: BoxFit.fill
                                                      )
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text("Saeba Rio")
                                              ],
                                            )
                                        );
                                      }
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ) : SizedBox(),
                      if(!Responsive.isDesktop(context))...[
                        Container(
                            width: 60,
                            height: 60,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 1, color: blue),
                                color: Colors.white
                            ),
                            child: Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage("assets/images/photo_2022-11-23_04-40-34.jpg"),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                )
                            )
                        ),
                        Text("Atsushi Nakagima", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                      ],
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 1.7,
                          child: Column(
                            children: [
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
                                        color: background,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
                                          child: Text(
                                            value,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                          ),
                                        )
                                    ),
                                    itemBuilder: (c, element) {
                                      return Container(
                                        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: backgroundColor)
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 50,
                                              child: Text("${element['initTime']}"),
                                            ),

                                            SizedBox(
                                                width: 200,
                                                child: Center(
                                                  child: Text(element['client']),
                                                )),

                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.blue
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(width: Responsive.isDesktop(context) ? 200 : 400, child: Text(element['service']),),
                                            if(Responsive.isDesktop(context))...[
                                              SizedBox(width: 200, child: Center(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: AssetImage(element['profilePic']), fit: BoxFit.fill
                                                            )
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(element['employee']),
                                                    ],
                                                  )
                                              )),
                                            ],

                                            Spacer(),
                                            element['status'] == "Nouveau" ? Container(
                                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                                width: width /2,
                                                decoration: BoxDecoration(
                                                    color: newStatus.withOpacity(0.2),
                                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                                child: Center(child: Text(element['status'], style: TextStyle(color: newStatus, fontWeight: FontWeight.bold)))
                                            ) : element['status'] == "En Attente" ?
                                            Container(
                                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                                width: width /2,
                                                decoration: BoxDecoration(
                                                    color: pendingStatus.withOpacity(0.2),
                                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                                child: Center(child: Text(element['status'], style: TextStyle(color: pendingStatus, fontWeight: FontWeight.bold)))
                                            ) : element['status'] == "Annulé" ?
                                            Container(
                                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                                width: width /2,
                                                decoration: BoxDecoration(
                                                    color: specialColor.withOpacity(0.2),
                                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                                child: Center(child: Text(element['status'], style: TextStyle(color: specialColor, fontWeight: FontWeight.bold)))
                                            ) : element['status'] == "Approuvé" ?
                                            Container(
                                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                                width: width /2,
                                                decoration: BoxDecoration(
                                                    color: validateColor.withOpacity(0.2),
                                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                                child: Center(child: Text(element['status'], style: TextStyle(color: validateColor, fontWeight: FontWeight.bold)))
                                            ) : SizedBox(),
                                            SizedBox(width: 10),
                                            Material(
                                              child: InkWell(
                                                  onTap: (){
                                                    Scaffold.of(context).openEndDrawer();
                                                  },
                                                  child:  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(),
                                                        borderRadius: BorderRadius.all(Radius.circular(5))
                                                    ),
                                                    child: Icon(Icons.edit),
                                                  )
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  )
                              ),
                            ],
                          )
                      ),

                    ],
                  ),
                ),
                Responsive.isDesktop(context) ?
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: (){
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Icon(Icons.add),
                  ),
                ) : SizedBox()
              ],
            ),
          )
      )
    );
  }
}
