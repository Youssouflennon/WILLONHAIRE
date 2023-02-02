import 'package:admin/color_constants.dart';
import 'package:admin/responsive.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../models/ComingAppointments.dart';


class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Palette.background,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rendez-vous à venir", style: TextStyle(color: Color(0xFF032252), fontSize: 20),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Date/Heure:", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                ),
                DataColumn(
                  label: Text("Client:", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                ),
                if(Responsive.isDesktop(context))
                DataColumn(
                  label: Text("Assigné à:", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                ),
                DataColumn(label: Text("Service:", style: TextStyle(color: appColor, fontSize: 15))
                ),

                  DataColumn(label: Text("Durée:", style: TextStyle(color: appColor, fontSize: 15))
                  ),

                  DataColumn(label: Text("Paiement:", style: TextStyle(color: appColor, fontSize: 15))
                  ),
                  DataColumn(label: Text("Statut:", style: TextStyle(color: appColor, fontSize: 15))
                  ),
              ],
              rows: List.generate(
                comingEvents.length,
                (index) => recentFileDataRow(comingEvents[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(ListAppointmentsState fileInfo, BuildContext context) {
  double width = 80;
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.date!, style: TextStyle(color: Color(0xFF032252), fontSize: 15))),
      DataCell(Text(fileInfo.client!, style: TextStyle(color: Color(0xFF032252), fontSize: 15))),
      if(Responsive.isDesktop(context))
      DataCell(Text(fileInfo.assign!, style: TextStyle(color: Color(0xFF032252), fontSize: 15))),
      DataCell(Text(fileInfo.service!, style: TextStyle(color: Color(0xFF032252), fontSize: 15))),

      DataCell(Text(fileInfo.timeLast!, style: TextStyle(color: Color(0xFF032252), fontSize: 15))),

      DataCell(Text(fileInfo.payment!, style: TextStyle(color: Color(0xFF032252), fontSize: 15))),
      DataCell(
        Row(
          children: [
            fileInfo.status! == "Nouveau" ? Container(
                margin: EdgeInsets.all(5),
                width: width,
                decoration: BoxDecoration(
                    color: newStatus.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Center(child: Text(fileInfo.status!, style: TextStyle(color: newStatus, fontWeight: FontWeight.bold)))
            ) : fileInfo.status! == "En cours" ?
            Container(
                margin: EdgeInsets.all(5),
                width: width,
                decoration: BoxDecoration(
                    color: pendingStatus.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Center(child: Text(fileInfo.status!, style: TextStyle(color: pendingStatus, fontWeight: FontWeight.bold)))
            ) : fileInfo.status! == "Traitée" ?
            Container(
                margin: EdgeInsets.all(5),
                width: width,
                decoration: BoxDecoration(
                    color: doneStatus.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Center(child: Text(fileInfo.status!, style: TextStyle(color: doneStatus, fontWeight: FontWeight.bold)))
            ) : fileInfo.status! == "Payée" ?
            Container(
                margin: EdgeInsets.all(5),
                width: width,
                decoration: BoxDecoration(
                    color: validateColor.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Center(child: Text(fileInfo.status!, style: TextStyle(color: validateColor, fontWeight: FontWeight.bold)))
            ) : SizedBox(),
            SizedBox(width: 10),
            InkWell(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: inactive)
                ),
                child: Icon(Icons.edit, color: inactive),
              ),
            )
          ],
        )
      ),
        /*DataCell(
          TextButton(
            child: Text('View', style: TextStyle(color: greenColor)),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                        title: Center(
                          child: Column(
                            children: [
                              Icon(Icons.warning_outlined,
                                  size: 36, color: Colors.red),
                              SizedBox(height: 20),
                              Text("Confirm Deletion", style: TextStyle(color: Color(0xFF032252))),
                            ],
                          ),
                        ),
                        content: Container(
                          //color: Palette.background,
                          height: 70,
                          child: Column(
                            children: [
                              Text(
                                  "Are you sure want to delete?", style: TextStyle(color: Color(0xFF032252))),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.close,
                                        size: 14,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.grey),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      label: Text("Cancel")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 14,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      onPressed: () {},
                                      label: Text("Delete"))
                                ],
                              )
                            ],
                          ),
                        ));
                  });
            },
          ),),*/
    ],
  );
}
