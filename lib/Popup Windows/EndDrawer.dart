import 'package:admin/controllers/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color_constants.dart';


class EndMenu extends StatefulWidget {

  const EndMenu({
    Key? key
  }) : super(key: key);

  @override
  State<EndMenu> createState() => EndMenuState();
}

class EndMenuState extends State<EndMenu> {
  int currentIndex = 0;
  int indexSelected = 0;
  String? categoryValue;
  String? serviceValue;
  String? placeValue;
  String? employeeValue;
  String? hourValue;
  bool treated = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(delay: 50,
        child: Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.7, right: 0),
            child: Drawer(
                backgroundColor: Palette.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                            icon: Icon(Icons.arrow_back_ios_rounded)
                        ),
                        Text(" Tous les Rendez-Vous", style: TextStyle(color: appColor, fontSize: 17, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Container(
                            width: MediaQuery.of(context).size.width / 5,
                            margin: EdgeInsets.only(right: 10),
                            height: 40,
                            child: TextFormField(
                              //controller: dateController,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.only(top: 10),
                                fillColor: background,
                                prefixIcon: Icon(Icons.search),
                                hintText: "Rechercher...",
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                              ),
                              validator: (String? value) {
                                return (value != null && value.isEmpty)
                                    ? 'field required!'
                                    : null;
                              },
                            )
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Material(
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      treated = !treated;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 5, bottom: 10, left: 15, right: 15),
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: appColor),
                                      )
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage("assets/images/man.png"),
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        RichText(
                                          text: TextSpan(
                                              children: [
                                                TextSpan(text: "Blaise Onizuka", style: TextStyle(fontSize: 18, color: appColor)),
                                                TextSpan(text: "\nsamedi, 12/06/2023", style: TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
                                              ]
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                            width: 80,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color: treated ? validateColor.withOpacity(0.2) : doneStatus.withOpacity(0.2),
                                            ),
                                            padding: EdgeInsets.all(5),
                                            child: Center(
                                              child: Text(treated ? "Traité" : "Traiter", style: TextStyle(fontSize: 15, color: treated ? validateColor : doneStatus)),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                )
            )
        )
    );
  }
}
