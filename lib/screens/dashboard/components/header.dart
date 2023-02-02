import 'dart:convert';

import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focused_menu/modals.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:focused_menu/focused_menu.dart';

import '../../../Drawer_Menu/drawer_menu.dart';
import '../../../color_constants.dart';
import '../../login/login_screen.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => HeaderState();

}

class HeaderState extends State<Header> {

  final box = Hive.box("myBox");
  String firstName = "";
  String lastName = "";
  String email = "";
  String type = "";
  String phone = "";
  String gender = "";

  @override
  void initState() {
    super.initState();
    initializePage();
  }


  initializePage()async{
    if(box.get("userDto") != null){
      final userDto = box.get("userDto");
      firstName = json.decode(userDto)["user"]["firstName"];
      lastName = json.decode(userDto)["user"]["lastName"];
      email = json.decode(userDto)["user"]["email"];
      type = json.decode(userDto)["user"]["type"];
      phone = json.decode(userDto)["user"]["phone"];
      gender = json.decode(userDto)["user"]["gender"];
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
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
            if (!Responsive.isMobile(context))
              Text(
                "Tableau de board",
                style: TextStyle(color: appColor, fontSize: 30),
              ),
            if (!Responsive.isMobile(context))
              Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            ProfileCard()
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: gender == "MALE" ? "Bonjour M. $firstName $lastName 👋🏼" : "Bonjour Mme. $firstName $lastName 👋🏼",
                  style: TextStyle(color: appColor, fontSize: 30)),
                TextSpan(text: "\nVous avez ✅ 0 rendez-vous approuvés et ⏰ 0 rendez-vous en attente pour aujourd'hui",
                    style: TextStyle(color: appColor, fontSize: 15)),
              ],

            ),
          ),
        ),
      ],
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => ProfileCardState();

}

class ProfileCardState extends State<ProfileCard> {

  @override
  void initState() {
    super.initState();
    initializePage();
  }

  final box = Hive.box("myBox");
  String firstName = "";
  String lastName = "";
  String email = "";
  String type = "";
  String phone = "";
  String gender = "";

  initializePage()async{
    if(box.get("userDto") != null){
      final userDto = box.get("userDto");
      firstName = json.decode(userDto)["user"]["firstName"];
      lastName = json.decode(userDto)["user"]["lastName"];
      email = json.decode(userDto)["user"]["email"];
      type = json.decode(userDto)["user"]["type"];
      phone = json.decode(userDto)["user"]["phone"];
      gender = json.decode(userDto)["user"]["gender"];
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Palette.background,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 5, color: appColor),
                    image: DecorationImage(
                        image: AssetImage('assets/images/photo_2022-11-23_02-21-05.jpg')
                    )
                ),
              ),
              if (!Responsive.isMobile(context))
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                      child: Text("$firstName $lastName", style: TextStyle(color: appColor, fontSize: 20)),
                    ),
                    if (!Responsive.isMobile(context))
                      Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                          child: Row(
                            children: [
                              Icon(Icons.person_sharp, color: appColor, size: 15,),
                              Text(" $type", style: TextStyle(color: appColor, fontSize: 15),
                              ),
                            ],
                          )),
                    if (!Responsive.isMobile(context))
                      Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                          child: Row(
                            children: [
                              Icon(Icons.mail_rounded, color: appColor, size: 15,),
                              Text(" $email", style: TextStyle(color: appColor, fontSize: 13),
                              ),
                            ],
                          )),
                    if (!Responsive.isMobile(context))
                      Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                          child: Row(
                            children: [
                              Icon(Icons.phone_android_outlined, color: Color(0xFFFF160E), size: 13),
                              Text(" $phone", style: TextStyle(color: appColor, fontSize: 15),
                              ),
                            ],
                          )),
                  ],
                ),
              FocusedMenuHolder(
                blurSize: 1,
                menuItemExtent: 40,
                menuWidth: defaultPadding * 15,
                menuBoxDecoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                        Radius.circular(5.0))),
                duration: Duration(
                    milliseconds: 100),
                animateMenuItems: true,
                //blurBackgroundColor: Colors.black12.withOpacity(0.5),
                openWithTap: true,
                // Open Focused-Menu on Tap rather than Long Press
                menuOffset: 10.0,
                // Offset value to show menuItem from the selected item
                bottomOffsetHeight: 30.0,
                onPressed: () {

                },
                menuItems: <FocusedMenuItem>[
                  FocusedMenuItem(title: Text("Déconnexion",style: TextStyle(color: appColor, letterSpacing: 2),),
                      trailingIcon: Icon(Icons.logout, color: appColor),
                      onPressed: (){
                        Navigator.push(
                          context,
                          PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                              child: Login()),
                        );
                      }),
                  FocusedMenuItem(title: Text("Settings",style: TextStyle(color: appColor, letterSpacing: 2),),
                      trailingIcon: Icon(Icons.settings, color: appColor),
                      onPressed: (){

                      }),
                ],
                child: Icon(Icons.keyboard_arrow_down, color: appColor),
              ),
            ],
          ),
        ],
      )
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Colors.blueGrey,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
class ItemModel {
  String title;
  IconData icon;

  ItemModel(this.title, this.icon);
}