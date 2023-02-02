import 'package:admin/models/rapport/popDetails.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../color_constants.dart';
import '../../responsive.dart';

class Rapports extends StatefulWidget {

  const Rapports({
    Key? key
  }) : super(key: key);

  @override
  State<Rapports> createState() => RapportsState();
}

class RapportsState extends State<Rapports>{

  String? selectedEmployee;
  String? selectedStatus;
  bool isBlockView = false;
  bool isListView = true;
  int currentIndex = 0;
  String firstDate = DateFormat("dd, MMMM", "fr_CA").format(DateTime.now()).toString();
  String lastDate = DateFormat("dd, MMMM", "fr_CA").format(DateTime.now().add(Duration(days: 5))).toString();

  List _elements = [
    {'Reference': 'Shop/0022','date': '20/05/2022 19:26:44','status': 'payée','client': 'ANONYME', 'caissier': 'Salomon', 'total': '13.00€',},
    {'Reference': 'Shop/0007','date': '20/05/2022 19:26:44','status': 'Nouveau','client': 'ANONYME','caissier': 'William', 'total': '15.00€',},
    {'Reference': 'Shop/0061','date': '20/05/2022 19:26:44','status': 'payée','client': 'ANONYME','caissier': 'William', 'total': '11.00€',},
    {'Reference': 'Shop/0042','date': '20/05/2022 19:26:44','status': 'payée','client': 'ANONYME','caissier': 'Salomon', 'total': '17.00€',},
    {'Reference': 'Shop/0020','date': '20/05/2022 19:26:44','status': 'En cours','client': 'ANONYME','caissier': 'Salomon', 'total': '19.00€',},
    {'Reference': 'Shop/0134','date': '20/05/2022 19:26:44','status': 'payée','client': 'ANONYME','caissier': 'William', 'total': '13.00€',},
    {'Reference': 'Shop/0033','date': '20/05/2022 19:26:44','status': 'Traitée','client': 'ANONYME','caissier': 'William', 'total': '10.00€',},
    {'Reference': 'Shop/0025','date': '20/05/2022 19:26:44','status': 'payée','client': 'ANONYME','caissier': 'Salomon', 'total': '13.00€',},
    {'Reference': 'Shop/0022','date': '20/05/2022 19:26:44','status': 'Nouveau','client': 'ANONYME', 'caissier': 'Salomon', 'total': '13.00€',},
    {'Reference': 'Shop/0007','date': '20/05/2022 19:26:44','status': 'Nouveau','client': 'ANONYME','caissier': 'William', 'total': '15.00€',},
    {'Reference': 'Shop/0061','date': '20/05/2022 19:26:44','status': 'En cours','client': 'ANONYME','caissier': 'William', 'total': '11.00€',},
    {'Reference': 'Shop/0042','date': '20/05/2022 19:26:44','status': 'Traitée','client': 'ANONYME','caissier': 'Salomon', 'total': '17.00€',},
    {'Reference': 'Shop/0020','date': '20/05/2022 19:26:44','status': 'Nouveau','client': 'ANONYME','caissier': 'Salomon', 'total': '19.00€',},
    {'Reference': 'Shop/0134','date': '20/05/2022 19:26:44','status': 'En cours','client': 'ANONYME','caissier': 'William', 'total': '13.00€',},
    {'Reference': 'Shop/0033','date': '20/05/2022 19:26:44','status': 'En cours','client': 'ANONYME','caissier': 'William', 'total': '10.00€',},
    {'Reference': 'Shop/0025','date': '20/05/2022 19:26:44','status': 'Nouveau','client': 'ANONYME','caissier': 'Salomon', 'total': '13.00€',},
  ];
  final List<String> employee = [
    'Tous les employés',
    'Salomon',
    'Shakib',
    'William',
  ];
  final List<String> status = [
    'Tous les status',
    'Nouveau',
    'En cours',
    'Traité',
    'Payé'
  ];

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

  @override
  Widget build(BuildContext context){
    return Material(
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    double radius = 10;
    return Container(
      padding: EdgeInsets.all(10),
      color: backgroundColor,
      child:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Palette.background,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Rapports", style: TextStyle(color: appColor, fontSize: 30),),
                        Spacer(),
                        Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: 40,
                            child: TextFormField(
                              //controller: dateController,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.only(top: 10),
                                fillColor: background,
                                prefixIcon: Icon(Icons.search),
                                hintText: "Rechercher le client",
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                              ),
                              validator: (String? value) {
                                return (value != null && value.isEmpty)
                                    ? 'field required!'
                                    : null;
                              },
                            )
                        ),
                        SizedBox(width: 10),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          padding: EdgeInsets.all(2),
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              color: Palette.background,
                              border: Border.all(color: inactive)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isListView ? primaryColor : null
                                ),
                                child: IconButton(onPressed: (){
                                  setState(() {
                                    isListView = true;
                                    isBlockView = false;
                                  });
                                },
                                    icon: Icon(Icons.list)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isBlockView ? primaryColor : null
                                ),
                                child: IconButton(onPressed: (){
                                  setState(() {
                                    isBlockView = true;
                                    isListView = false;
                                  });
                                },
                                    icon: Icon(Icons.dashboard)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          width: MediaQuery.of(context).size.width / 5,
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
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonPadding: EdgeInsets.only(left: 10),
                            buttonWidth: MediaQuery.of(context).size.width / 8,
                            buttonHeight: 40,
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: background,
                            ),
                            hint: Text(
                              'Trier par Employee',
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
                            value: selectedEmployee,
                            onChanged: (value) {
                              setState(() {
                                selectedEmployee = value as String;
                              });
                            },
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            itemHeight: 40,
                          ),
                        ),
                        SizedBox(width: 5),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonPadding: EdgeInsets.only(left: 10),
                            buttonWidth: MediaQuery.of(context).size.width / 8,
                            buttonHeight: 40,
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: background,
                            ),
                            hint: Text(
                              'Trier par Status',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme
                                    .of(context)
                                    .hintColor,
                              ),
                            ),
                            items: status
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
                            value: selectedStatus,
                            onChanged: (value) {
                              setState(() {
                                selectedStatus = value as String;
                              });
                            },
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            itemHeight: 40,
                          ),
                        ),
                        /*Container(
                          width: 40,
                          height: 40,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: inactive)
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: primaryColor,
                            child: Icon(Icons.refresh, color: Palette.background),
                          ),
                        ),*/
                        Spacer(),
                        InkWell(
                          onTap: (){},
                          child: Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: background,
                                  border: Border.all(color: inactive)
                              ),
                              child: Icon(Icons.download)
                          ),
                        ),
                      ],
                    )
                  ],
                )
            ),
            isListView ?
            buildListRapport(context) :
            buildBlockRapports(context),
            Container(
              width: MediaQuery.of(context).size.width,
              color: background,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 8,
                      padding: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(color: appColor)
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("490.0€", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                        ],
                      )
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  buildListRapport(BuildContext context){
    double width = MediaQuery.of(context).size.width / 7;
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 5),
        height: MediaQuery.of(context).size.height / 1.5,
        child: Column(
          children: [
            Expanded(
                child: GroupedListView<dynamic, String>(
                  elements: _elements,
                  groupBy: (element) => element['client'],
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1['total'].compareTo(item2['total']),
                  order: GroupedListOrder.ASC,
                  useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) => Container(
                      decoration: BoxDecoration(
                          color: background,
                          //borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(width: width - 50,child: Text(
                            "Ref. Commande",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                          SizedBox(width: width,child: Text(
                            "Date",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          )),

                          SizedBox(width: width,child: Text(
                            "Client",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                          SizedBox(width: width+50,child: Text(
                            "Employé",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                          SizedBox(width: width,child: Text(
                            "Status",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                          Spacer(),
                          SizedBox(width: 50,child: Text(
                            "Total",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ))
                        ],
                      )
                  ),
                  itemBuilder: (c, element) {
                    return InkWell(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (_){
                              return OrderDetails();
                            }
                          );
                        },
                        hoverColor: inactive,
                        splashColor: inactive,
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: backgroundColor),
                                color: Palette.background
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width: width - 50,
                                        child: Text(element['Reference'])),
                                    SizedBox(width: width, child: Text(element['date']),),
                                    SizedBox(width: width, child: Text(element['client']),),
                                    Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage("assets/images/photo_2022-11-23_04-40-34.jpg"), fit: BoxFit.fill
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SizedBox(
                                            width: width - 60,
                                            child: Text(element['caissier'])),
                                      ],
                                    ),
                                    SizedBox(width: width,
                                      child: Column(
                                        children: [
                                          element['status'] == "Nouveau" ? Container(
                                              padding: EdgeInsets.only(top: 10, bottom: 10),
                                              width: width /2,
                                              decoration: BoxDecoration(
                                                  color: newStatus.withOpacity(0.2),
                                                  borderRadius: BorderRadius.all(Radius.circular(30))
                                              ),
                                              child: Center(child: Text(element['status'], style: TextStyle(color: newStatus, fontWeight: FontWeight.bold)))
                                          ) : element['status'] == "En cours" ?
                                          Container(
                                              padding: EdgeInsets.only(top: 10, bottom: 10),
                                              width: width /2,
                                              decoration: BoxDecoration(
                                                  color: pendingStatus.withOpacity(0.2),
                                                  borderRadius: BorderRadius.all(Radius.circular(30))
                                              ),
                                              child: Center(child: Text(element['status'], style: TextStyle(color: pendingStatus, fontWeight: FontWeight.bold)))
                                          ) : element['status'] == "Traitée" ?
                                          Container(
                                              padding: EdgeInsets.only(top: 10, bottom: 10),
                                              width: width /2,
                                              decoration: BoxDecoration(
                                                  color: doneStatus.withOpacity(0.2),
                                                  borderRadius: BorderRadius.all(Radius.circular(30))
                                              ),
                                              child: Center(child: Text(element['status'], style: TextStyle(color: doneStatus, fontWeight: FontWeight.bold)))
                                          ) : element['status'] == "payée" ?
                                          Container(
                                              padding: EdgeInsets.only(top: 10, bottom: 10),
                                              width: width /2,
                                              decoration: BoxDecoration(
                                                  color: validateColor.withOpacity(0.2),
                                                  borderRadius: BorderRadius.all(Radius.circular(30))
                                              ),
                                              child: Center(child: Text(element['status'], style: TextStyle(color: validateColor, fontWeight: FontWeight.bold)))
                                          ) : SizedBox(),
                                        ],
                                      )
                                    ),
                                    Spacer(),
                                    SizedBox(width: 50, child: Text(element['total']),),
                                  ],
                                ),
                              ],
                            )
                        )
                    );
                  },
                )
            ),
          ],
        )
    );
  }

  buildBlockRapports(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Expanded(
              child: GridView.builder(
                  itemCount: _elements.length,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.isDesktop(context) ? 3 : 2, mainAxisExtent: 200.0, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0),
                  itemBuilder: (context, index) {
                    //articles?.sort((a, b) => b.date.compareTo(a.date));
                    return InkWell(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (_) {
                              return OrderDetails();
                            },
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(Radius.circular(5))
                                        ),
                                        child: Text(_elements[index]["total"], style: TextStyle(color: validateColor, fontWeight: FontWeight.bold))
                                    )
                                ),
                                Container(
                                  width: 350,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              width: 150,
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(width: 2.0, color: primaryColor),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Réf. Commande", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                                                  Text("Employée", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                                                  Text("Date", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                                                  Text("Client", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                                                ],
                                              )
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(_elements[index]["Reference"]),
                                              Text(_elements[index]["caissier"]),
                                              Text(_elements[index]["date"]),
                                              Text(_elements[index]["client"])
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: "Numéro de reçu: ", style: TextStyle(color: appColor, fontSize: 15)),
                                        TextSpan(text: _elements[index]["receipt"], style: TextStyle(color: inactive, fontSize: 12))
                                      ]
                                    )
                                )
                              ],
                            )
                        )
                    );
                  }
              )
          ),
        ],
      )
    );
  }

}