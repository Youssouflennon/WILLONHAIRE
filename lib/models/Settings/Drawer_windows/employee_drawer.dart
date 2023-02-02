import 'package:admin/controllers/animation.dart';
import 'package:admin/models/Settings/Drawer_windows/widgets/assigned_services.dart';
import 'package:admin/models/Settings/Drawer_windows/widgets/days_off.dart';
import 'package:admin/models/Settings/Drawer_windows/widgets/Employee_details.dart';
import 'package:admin/models/Settings/Drawer_windows/widgets/work_hours.dart';
import 'package:flutter/material.dart';

import '../../../color_constants.dart';

class EmployeeDrawer extends StatefulWidget {

  const EmployeeDrawer({
    Key? key
  }) : super(key: key);

  @override
  State<EmployeeDrawer> createState() => EmployeeDrawerState();
}

class EmployeeDrawerState extends State<EmployeeDrawer> {


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
    return DelayedAnimation(delay: 50,
        child: Container(
            width: MediaQuery.of(context).size.width / 3,
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
                        Text("Services assigné", style: TextStyle(color: indexSelected == 1 ? Colors.blue : appColor))
                        ),
                        TextButton(
                            onPressed: (){
                              setState((){
                                indexSelected = 2;
                              });

                            }, child:
                        Text("Heures de travail", style: TextStyle(color: indexSelected == 2 ? Colors.blue : appColor))
                        ),
                        TextButton(
                            onPressed: (){
                              setState((){
                                indexSelected = 3;
                              });

                            }, child:
                        Text("Jour de Congés", style: TextStyle(color: indexSelected == 3 ? Colors.blue : appColor))
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey),
                    Expanded(
                      child: ListView(
                        children: [
                          indexSelected == 0 ? Details() : indexSelected == 1 ? AssignedServices() : indexSelected == 2 ? WorkHours() : indexSelected == 3 ? DaysOff() : SizedBox(),
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
