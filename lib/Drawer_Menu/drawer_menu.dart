
import 'package:admin/models/AvisClients.dart';
import 'package:admin/models/InterfacePOS.dart';
import 'package:admin/models/Planning.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../color_constants.dart';
import '../controllers/menu_animation.dart';
import '../models/scan_qrCode.dart';

class MenuDrawer extends StatefulWidget{

  const MenuDrawer({
    Key? key
  }) : super(key: key);

  @override
  State<MenuDrawer> createState() => MenuDrawerState();
}

class MenuDrawerState extends State<MenuDrawer>{


  String barcode = "";

  @override
  Widget build(BuildContext context) {
    return MenuAnimation(delay: 50,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.only(left: 0, right: MediaQuery.of(context).size.width / 1.5),
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
                      leading: Icon(Icons.dashboard, color: Colors.white, size: 30),
                      title: Text("Tableau de board", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      onTap: (){
                        Navigator.push(
                          context,
                          PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                              child: MainScreen()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.calendar_today_sharp, color: Colors.white, size: 25),
                      title: Text("Planning", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      onTap: (){
                        Navigator.push(
                          context,
                          PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                              child: Planning()),
                        );
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
                      leading: Icon(Icons.comment, color: Colors.white, size: 25),
                      title: Text("Avis Clients", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      onTap: (){
                        Navigator.push(
                          context,
                          PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                              child: AvisClients()),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                        onPressed: (){
                          Navigator.push(
                            context,
                            PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                                child: ScanQrCodeScreen()),
                          );
                        },
                        icon: Icon(Icons.qr_code_scanner_outlined),
                        label: Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("Scanner le Code")
                        )
                    )
                  ],
                ),
              )
          ),
      )
    );
  }
}