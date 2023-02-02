import 'package:admin/controllers/menu_animation.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../color_constants.dart';
import '../../responsive.dart';
import 'Drawer_windows/user_drawer.dart';

class Users extends StatefulWidget {

  const Users({
    Key? key
  }) : super(key: key);

  @override
  State<Users> createState() => UsersState();

}

class UsersState extends State<Users>{

  final List<String> role = [
    'Tous',
    'MANAGER',
    'EMPLOYEE',
    'CLENT'
  ];

  List users = [
    {'client': 'John Snow','email': 'john.snow@gmail.com','profilePic': 'assets/images/man.png', 'role': 'Client', 'initTime': '12:00', 'status': 'En Attente', 'tel': '+237698765433'},
    {'client': 'Will Baratheon','email': 'will.baratheon@gmail.com','profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'role': 'Employé', 'initTime': '11:30', 'status': 'Annulé', 'tel': '+237698765433'},
    {'client': 'Beth Salma','email': 'beth.salma@gmail.com','profilePic': 'assets/images/photo_2022-11-23_04-40-50.jpg', 'role': 'Client', 'initTime': '15:00', 'status': 'Approuvé', 'tel': '+237698765433'},
    {'client': 'Miranda Abigelle','email': 'abigaelle@gmail.com','profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'role': 'Employé', 'initTime': '9:30', 'status': 'Annulé', 'tel': '+237698765433'},
    {'client': 'Will Smith','email': 'will@smithy.com','profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'role': 'Client', 'initTime': '14:30', 'status': 'En Attente', 'tel': '+237698765433'},
    {'client': 'Bethy Bones','email': 'bethy.bones@hotmail.com','profilePic': 'assets/images/man.png', 'role': 'Client', 'initTime': '13:00', 'status': 'Approuvé', 'tel': '+2376664425676'},
    {'client': 'Miranda Show','email': 'miranda.show@gmail.com','profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'role': 'Manager', 'initTime': '16:00', 'status': 'Approuvé', 'tel': '+326768495748'},
  ];

  String? selectedService;
  String? selectedPlace;
  bool isBlockView = true;
  bool isListView = false;

  @override
  Widget build(BuildContext context){
    return Material(
      child: MenuAnimation(delay: 50, child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      //color: background,
      height: MediaQuery.of(context).size.height/1.3,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Palette.background,
            child: Row(
              children: [
                Text("Tous les Utilisateurs", style: TextStyle(color: appColor, fontSize: 20),),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: background,
                  child: Center(
                    child: Text(users.length.toString()),
                  ),
                ),
                SizedBox(width: 10),
                Text("Total", style: TextStyle(color: Colors.grey, fontSize: 20),),
                Spacer(flex: 2),
                ElevatedButton.icon(onPressed: (){
                  showDialog(
                    context: context,
                    builder: (_) {
                      return UserDrawer();
                    },
                  );
                }, icon: Icon(Icons.add), label: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("Ajouter un Utilisateur"),
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
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        buttonPadding: EdgeInsets.only(left: 10),
                        buttonWidth: 300,
                        buttonHeight: 40,
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: backgroundColor,
                        ),
                        hint: Text(
                          'Trier par Role',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: role
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
                    Spacer(),
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
                    itemCount: users.length,
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.isDesktop(context) ? 3 : 2, mainAxisExtent: 160.0, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0),
                    itemBuilder: (context, index) {
                      //articles?.sort((a, b) => b.date.compareTo(a.date));
                      return Container(
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
                                  users[index]["role"] == "Client" ? Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 5),
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: validateColor.withOpacity(0.2),
                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                      ),
                                      child: Text(users[index]["role"], style: TextStyle(color: validateColor, fontWeight: FontWeight.bold))
                                  ) : users[index]["role"] == "Employé" ? Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 5),
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: pendingStatus.withOpacity(0.2),
                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                      ),
                                      child: Text(users[index]["role"], style: TextStyle(color: pendingStatus, fontWeight: FontWeight.bold))
                                  ) : Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 5),
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: doneStatus.withOpacity(0.2),
                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                      ),
                                      child: Text(users[index]["role"], style: TextStyle(color: doneStatus, fontWeight: FontWeight.bold))
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return UserDrawer();
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          border: Border.all(color: inactive)
                                      ),
                                      child: Icon(Icons.edit, color: inactive),
                                    ),
                                  )
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
                                            image: AssetImage(users[index]["profilePic"]), fit: BoxFit.fill
                                        )
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(users[index]["client"], style: TextStyle(color: appColor, fontSize: 20)),
                                      Text(users[index]["email"], style: TextStyle(color: Colors.grey, fontSize: 15)),
                                      Text(users[index]["tel"], style: TextStyle(color: Colors.grey, fontSize: 15)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )
                      );
                    }
                )
            ),
          if(isListView)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(),
                color: Palette.background,
              ),
              height: MediaQuery.of(context).size.height/1.7,
              child: DataTable2(
                columnSpacing: defaultPadding,
                minWidth: 600,
                dataRowHeight: 60,

                showCheckboxColumn: false,
                columns: [
                  DataColumn(
                    label: Text("Identifiant", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                  ),
                  DataColumn(
                    label: Text("E-mail", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                  ),
                  DataColumn(
                    label: Text("Téléphone", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                  ),
                  DataColumn(
                    label: Row(
                      children: [
                        Spacer(),
                        Text("Role", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                        SizedBox(width: 100)
                      ],
                    )
                  ),
                ],
                rows: List.generate(
                  users.length,
                      (index) => DataRow(
                          /*onSelectChanged: (_){
                            showDialog(
                              context: context,
                              builder: (_) {
                                return UserDrawer();
                              },
                            );
                          },*/
                          cells: [
                            DataCell(
                                Row(
                                  children: [
                                    Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(users[index]["profilePic"]), fit: BoxFit.fill))),
                                    SizedBox(width: 5),
                                    Text(users[index]["client"], style: TextStyle(color: Color(0xFF032252), fontSize: 15))
                                  ],
                                )
                            ),
                            DataCell(Text(users[index]["email"], style: TextStyle(color: Color(0xFF032252), fontSize: 15))),
                            DataCell(Text(users[index]["tel"], style: TextStyle(color: Color(0xFF032252), fontSize: 15))),

                            DataCell(
                              Row(
                                children: [
                                  Spacer(),
                                  users[index]["role"] == "Client" ? Container(
                                      margin: EdgeInsets.only(top: 10, bottom: 10),
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: validateColor.withOpacity(0.2),
                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                      ),
                                      child: Text(users[index]["role"], style: TextStyle(color: validateColor, fontWeight: FontWeight.bold))
                                  ) : users[index]["role"] == "Employé" ? Container(
                                      margin: EdgeInsets.only(top: 10, bottom: 10),
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: pendingStatus.withOpacity(0.2),
                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                      ),
                                      child: Text(users[index]["role"], style: TextStyle(color: pendingStatus, fontWeight: FontWeight.bold))
                                  ) : Container(
                                      margin: EdgeInsets.only(top: 10, bottom: 10),
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: doneStatus.withOpacity(0.2),
                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                      ),
                                      child: Text(users[index]["role"], style: TextStyle(color: doneStatus, fontWeight: FontWeight.bold))
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return UserDrawer();
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          border: Border.all(color: inactive)
                                      ),
                                      child: Icon(Icons.edit, color: inactive),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}