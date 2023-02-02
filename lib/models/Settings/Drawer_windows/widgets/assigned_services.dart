import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../color_constants.dart';

class AssignedServices extends StatefulWidget {

  const AssignedServices({
    Key? key
  }) : super(key: key);

  @override
  State<AssignedServices> createState() => AssignedServicesState();

}

class AssignedServicesState extends State<AssignedServices>{

  List categories = ["New1", "Finger Nails", "Low cuts"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Palette.background,
      child: Column(
        children: [
          for(var i=0; i<categories.length; i++)...[
            DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              dataRowHeight: 50,
              dividerThickness: 0,
              showCheckboxColumn: false,
              headingRowColor:
              MaterialStateColor.resolveWith((states) => background),
              headingRowHeight: 50,
              columns: [
                DataColumn(
                  label: Text(categories[i], style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                ),
                DataColumn(
                  label: Text("Spots", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                ),
                DataColumn(
                  label: Text("Prix", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                ),
              ],
              rows: List.generate(

                categories.length,
                    (index) => services(context),
              ),
            )
          ]
        ],
      )
    );
  }
}
DataRow services(BuildContext context){
  return DataRow(
      onSelectChanged: (_){

      },
      cells: [
        DataCell( Text("Rio Saeba", style: TextStyle(color: Color(0xFF032252), fontSize: 15)) ),
        DataCell(
          Row(

            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.all(Radius.circular(2))
                  ),
                  child: Text("1", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
              ),
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.all(Radius.circular(2))
                  ),
                  child: Text("2", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
              )
            ],
          )
        ),
        DataCell(
            Container(
                padding: EdgeInsets.all(10),
                width: 100,
                decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.all(Radius.circular(2))
                ),
                child: Text("€2.00", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
            )
        ),
      ]
  );
}
