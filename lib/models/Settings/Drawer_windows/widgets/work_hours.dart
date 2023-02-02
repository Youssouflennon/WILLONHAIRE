import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../color_constants.dart';

class WorkHours extends StatefulWidget {

  const WorkHours({
    Key? key
  }) : super(key: key);

  @override
  State<WorkHours> createState() => WorkHoursState();

}

class WorkHoursState extends State<WorkHours>{
  List categories = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samed", "Dimanche"];

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
                    label: Row(
                      children: [
                        Spacer(flex: 2),
                        if(i == 0)
                        Text("Appliquer sur tous", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold, fontSize: 15)),
                        SizedBox(width: 10),
                        Icon(Icons.add_circle_rounded, color: Colors.blue)
                      ],
                    )
                  ),
                ],
                rows: List.generate(
                1,
                      (index) => jours(context),
                ),
              )
            ]
          ],
        )
    );
  }
}
DataRow jours(BuildContext context){
  return DataRow(
      onSelectChanged: (_){

      },
      cells: [
        DataCell( Text("09:00 - 17:00", style: TextStyle(color: Color(0xFF032252), fontSize: 15)) ),
        DataCell(
            Row(
              children: [
                Spacer(flex: 2),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.grey)),
                IconButton(onPressed: (){}, icon: Icon(Icons.remove_circle_outline, color: Colors.red.withOpacity(0.3),)),
              ],
            )
        ),
      ]
  );
}