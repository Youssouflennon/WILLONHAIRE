import 'package:admin/Drawer_Menu/drawer_menu.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../color_constants.dart';
import '../../models/InterfacePOS.dart';
import '../../models/Planning.dart';
import '../../models/AvisClients.dart';
import '../../models/notifiacation_push.dart';
import '../../models/rapport/Rapports.dart';
import '../../models/Reglages.dart';
import 'components/end_drawer.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({
    Key? key
  }) : super(key: key);

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  int currentIndex = 0;
  bool settings = false;

  List<Widget> myScreens = [
    DashboardScreen(),
    Planning(),
    AvisClients(),
    Rapports(),
    PushNotification(),
    Reglages(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      bottomSheet: Container(
        height: 40,
        color: backgroundColor,
        width: MediaQuery.of(context).size.width / 6,
        child: Wrap(
          runAlignment: WrapAlignment.spaceEvenly,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: " 2022 © Developed By", style: TextStyle(color: appColor, fontSize: 15, letterSpacing: 2)),
                    TextSpan(text: "\n SHINTHEO OÜ", style: TextStyle(color: specialColor,fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 2)),
                  ]
              ),
            )
          ],
        )
      ),
      endDrawer: SideMenu(),
      drawer: MenuDrawer(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: Drawer(
                  backgroundColor: drawerColor,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .30,
                          child: DrawerHeader(
                            child: Image.asset("assets/images/logoWillOnHair.png"),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                            ),
                            padding: EdgeInsets.only(bottom: 40, top: 40),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.dashboard, color: currentIndex == 0
                              ? Colors.cyanAccent
                              : Colors.white, size: currentIndex == 0 ? 40 : 30),
                          title: Text("Tableau de board", style: TextStyle(color: currentIndex == 0
                              ? Colors.cyanAccent
                              : Colors.white, fontWeight: currentIndex == 0 ? FontWeight.bold : null)),
                          onTap: (){
                            setState((){
                              settings = false;
                              currentIndex = 0;
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.calendar_today_sharp, color: currentIndex == 1
                              ? Colors.cyanAccent
                              : Colors.white, size: currentIndex == 1 ? 30 : 25),
                          title: Text("Planning", style: TextStyle(color: currentIndex == 1
                              ? Colors.cyanAccent
                              : Colors.white, fontWeight: currentIndex == 1 ? FontWeight.bold : null)),
                          onTap: (){
                            setState(() {
                              currentIndex = 1;
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.view_module_rounded, color: Colors.white, size: 25),
                          title: Text("Interface POS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          onTap: (){
                            Navigator.push(
                              context,
                              PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                                  child: InterfacePOS()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.comment, color: currentIndex == 2
                              ? Colors.cyanAccent
                              : Colors.white, size: currentIndex == 2 ? 30 : 25),
                          title: Text("Avis Clients", style: TextStyle(color: currentIndex == 2
                              ? Colors.cyanAccent
                              : Colors.white, fontWeight: currentIndex == 2 ? FontWeight.bold : null)),
                          onTap: (){
                            setState(() {
                              currentIndex = 2;
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.insert_drive_file_sharp, color: currentIndex == 3
                              ? Colors.cyanAccent
                              : Colors.white, size: currentIndex == 3 ? 30 : 25),
                          title: Text("Rapports", style: TextStyle(color: currentIndex == 3
                              ? Colors.cyanAccent
                              : Colors.white, fontWeight: currentIndex == 3 ? FontWeight.bold : null)),
                          onTap: (){
                            setState(() {
                              currentIndex = 3;
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.notifications_rounded, color: currentIndex == 4
                              ? Colors.cyanAccent
                              : Colors.white, size: currentIndex == 4 ? 30 : 25),
                          title: Text("Notification push", style: TextStyle(color: currentIndex == 4
                              ? Colors.cyanAccent
                              : Colors.white, fontWeight: currentIndex == 4 ? FontWeight.bold : null)),
                          onTap: (){
                            setState(() {
                              currentIndex = 4;
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: currentIndex == 5
                              ? Colors.cyanAccent
                              : Colors.white, size: currentIndex == 5 ? 30 : 25),
                          title: Text("Réglages", style: TextStyle(color: currentIndex == 5
                              ? Colors.cyanAccent
                              : Colors.white, fontWeight: currentIndex == 5 ? FontWeight.bold : null)),
                          onTap: (){
                            setState(() {
                              currentIndex = 5;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: myScreens.elementAt(currentIndex)
            ),
          ],
        ),
      ),
    );
  }
}
