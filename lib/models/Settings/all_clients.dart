import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../color_constants.dart';
import '../../controllers/animatonFadeIn.dart';
import 'Drawer_windows/employee_drawer.dart';

class AllClients extends StatefulWidget {

  const AllClients({
    Key? key
  }) : super(key: key);

  @override
  State<AllClients> createState() => AllClientsState();

}

class AllClientsState extends State<AllClients>{

  final List<String> services = [
    'ADULT',
    'ADO',
    'ENFANT'
  ];
  String? selectedService;
  String? selectedPlace;
  bool isBlockView = true;
  bool isListView = false;

  @override
  Widget build(BuildContext context){
    return Material(
      child: FadeIn(delay: 50, child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 80,
      color: background,
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
                Text("Tous les Clients", style: TextStyle(color: appColor, fontSize: 20),),
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

                }, icon: Icon(Icons.add), label: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("Ajouter un Client"),
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
                            hintText: "chercher un client",
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                          ),
                          validator: (String? value) {
                            return (value != null && value.isEmpty)
                                ? 'field required!'
                                : null;
                          },
                        )
                    ),
                    Spacer(),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        buttonPadding: EdgeInsets.only(left: 10),
                        buttonWidth: MediaQuery.of(context).size.width / 6,
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
          if(isBlockView)
            Expanded(
                child: GridView.builder(
                    itemCount: 5,
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisExtent: 150.0, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.star, size: 20),
                                      Text("13", style: TextStyle(fontSize: 15)),
                                      SizedBox(width: 10),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage("assets/images/trophy (1).png"))
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text("2", style: TextStyle(color: specialColor, fontSize: 15))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage("assets/images/photo_2022-11-23_04-40-50.jpg"), fit: BoxFit.fill
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Rio Saeba", style: TextStyle(color: appColor, fontSize: 20)),
                                          Text("saeba.rio@gmail.com", style: TextStyle(color: Colors.grey, fontSize: 15)),
                                          Text("+32 543647859", style: TextStyle(color: Colors.grey, fontSize: 15)),
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
                    label: Text("Cleint", style: TextStyle( fontSize: 15),),
                  ),
                  DataColumn(
                    label: Text("Photo de profile", style: TextStyle( fontSize: 15),),
                  ),
                  DataColumn(
                    label: Text("Dernier rendez-vous", style: TextStyle( fontSize: 15),),
                  ),
                  DataColumn(
                    label: Text("Points", style: TextStyle(fontSize: 15),),
                  ),
                  DataColumn(
                    label: Text("Bonus", style: TextStyle(color: specialColor, fontSize: 15),),
                  ),
                ],
                rows: List.generate(
                  5,
                      (index) => employee(context),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
DataRow employee(BuildContext context){
  return DataRow(
      onSelectChanged: (_){
        showDialog(
          context: context,
          builder: (_) {
            return EmployeeDrawer();
          },
        );
      },
      cells: [
        DataCell(Text("Rio Kusanaki", style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("assets/images/photo_2022-11-23_04-40-50.jpg"), fit: BoxFit.fill
              )
          ),
        ),),
        DataCell(Text("13/12/2022", style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("13", style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text("2", style: TextStyle(color: specialColor, fontWeight: FontWeight.bold))),
      ]
  );
}