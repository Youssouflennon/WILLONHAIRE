import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../color_constants.dart';

class DaysOff extends StatefulWidget {

  const DaysOff({
    Key? key
  }) : super(key: key);

  @override
  State<DaysOff> createState() => DaysOffState();

}

class DaysOffState extends State<DaysOff>{

  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    dateController.text = "17/01/2023";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Palette.background,
        child: Column(
          children: [
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
                  label: Text("Date", style: TextStyle(color: Color(0xFF032252), fontSize: 15),),
                ),
                DataColumn(
                    label: Text("Nom de l'Employée", style: TextStyle( fontSize: 15))
                ),
              ],
              rows: List.generate(
                5,
                    (index) => DataRow(
                        cells: [
                          DataCell( Text( dateController.text, style: TextStyle(color: Color(0xFF032252), fontSize: 15)) ),
                          DataCell( Text("Alpha Midoriya", style: TextStyle(color: Color(0xFF032252), fontSize: 15)) ),
                        ]
                    ),
              ),
            ),
            InkWell(
              onTap: (){
                selectDate();
              },
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.add_circle_rounded, color: Colors.blue),
                  SizedBox(width: 10),
                  Text("Ajouter un jour de congé", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold, fontSize: 15))
                ],
              ),
            )
          ],
        )
    );
  }

  Future selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2030),
      selectableDayPredicate: (DateTime dateTime) {
        if (dateTime == DateTime(2022, 12, 23) || dateTime == DateTime(2022, 12, 28)) {
          return false;
        }
        return true;
      },
    );
    String formattedDate = DateFormat("dd/MM/yyyy").format(pickedDate!);
    if(pickedDate != null ){
      setState(() {
        dateController.text = formattedDate; //set output date to TextField value.
      });
    }
  }

}