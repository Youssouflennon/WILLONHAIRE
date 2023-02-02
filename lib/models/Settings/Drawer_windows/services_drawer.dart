import 'package:flutter/material.dart';

import '../../../color_constants.dart';
import '../../../controllers/animation.dart';
import 'Services_Widgets/Details.dart';
import 'Services_Widgets/Extra.dart';
import 'Services_Widgets/Gallery.dart';
import 'Services_Widgets/duratiion_and_pricing.dart';

class ServicesDrawer extends StatefulWidget {

  const ServicesDrawer({
    Key? key
  }) : super(key: key);

  @override
  State<ServicesDrawer> createState() => ServicesDrawerState();
}

class ServicesDrawerState extends State<ServicesDrawer> {


  String? categoryValue;
  String? serviceValue;
  String? placeValue;
  String? employeeValue;
  String? hourValue;
  bool onSaveLoading = false;
  int indexSelected = 0;

  /*@override
  void initState() {
    // TODO: implement initState
    categoryValue = category.elementAt(0);
    serviceValue = service.elementAt(0);
    placeValue = emplacements.elementAt(0);
    employeeValue = employee.elementAt(0);
    super.initState();
  }*/

  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: 100,
      child: Container(
          width: MediaQuery.of(context).size.width / 4,
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.8, right: 0),
          child: Drawer(
              backgroundColor: Palette.background,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text("Nouvel Employée"),
                      Spacer(flex: 2),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      },
                          icon: Icon(Icons.close))
                    ],
                  ),
                  Divider(color: Colors.grey),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: (){
                            setState((){
                              indexSelected = 0;
                            });

                          }, child:
                      Text("Details", style: TextStyle(color: indexSelected == 0 ? Colors.blue : appColor))
                      ),
                      TextButton(
                          onPressed: (){
                            setState((){
                              indexSelected = 1;
                            });
                          }, child:
                      Text("Duré & Pricing", style: TextStyle(color: indexSelected == 1 ? Colors.blue : appColor))
                      ),
                      TextButton(
                          onPressed: (){
                            setState((){
                              indexSelected = 2;
                            });

                          }, child:
                      Text("Gallery", style: TextStyle(color: indexSelected == 2 ? Colors.blue : appColor))
                      ),
                      TextButton(
                          onPressed: (){
                            setState((){
                              indexSelected = 3;
                            });

                          }, child:
                      Text("Extra", style: TextStyle(color: indexSelected == 3 ? Colors.blue : appColor))
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  Expanded(
                    child: ListView(
                      children: [
                        indexSelected == 0 ? ServicesDetails() : indexSelected == 1 ? DurationPricing() : indexSelected == 2 ? Gallery() : indexSelected == 3 ? ExtraService() : SizedBox(),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey),
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                      child: Row(
                        children: [
                          Spacer(flex: 2),
                          InkWell(
                            child: Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color: Colors.black12)
                                ),
                                child: Text("Annuler", style: TextStyle(color: Colors.grey.withOpacity(0.6)),)
                            ),
                            onTap: (){
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  onSaveLoading = !onSaveLoading;
                                });
                              },
                              child: Container(
                                  width: 140,
                                  height: 40,
                                  padding: EdgeInsets.all(5),
                                  child: Center(
                                    child: onSaveLoading ? SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 1.5,
                                        )) : Text("Enregistrer"),
                                  )
                              )
                          ),
                        ],
                      )
                  ),
                ],
              )
          )
      )
    );
  }
}
