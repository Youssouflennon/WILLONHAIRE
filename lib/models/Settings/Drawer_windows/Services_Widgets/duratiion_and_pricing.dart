import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../color_constants.dart';

class DurationPricing extends StatefulWidget {

  const DurationPricing({
    Key? key
  }) : super(key: key);

  @override
  State<DurationPricing> createState() => DurationPricingState();

}

class DurationPricingState extends State<DurationPricing>{

  TextEditingController dateController = TextEditingController();

  /*@override
  void initState() {
    // TODO: implement initState
    dateController.text = "17/01/2023";
    super.initState();
  }*/

  final List<String> duration = [
    '30min',
    '1hr',
    '1hr 30min',
    '2hr',
    '2hr 30min',
  ];
  final List<String> hours = [
    '12:00',
    '08:30',
    '09:30',
    '10:30',
    '11:30',
    '12:30',
    '13:30',
  ];
  String? durationValue;
  String? timeBefore;
  String? timeAfter;
  int min = 1;
  int max = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Palette.background,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Duré:"),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        buttonPadding: EdgeInsets.only(left: 10),
                        buttonWidth: MediaQuery.of(context).size.width / 5,
                        buttonHeight: 40,
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: background,
                        ),
                        hint: Text(
                          'Choisir',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: duration
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ))
                            .toList(),
                        value: durationValue,
                        onChanged: (value) {
                          setState(() {
                            durationValue = value.toString();
                          });
                        },
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                        itemHeight: 40,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Prix:"),
                    Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: 40,
                        child: TextFormField(
                          //controller: dateController,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: background,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
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
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Buffer Time Before:"),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        buttonPadding: EdgeInsets.only(left: 10),
                        buttonWidth: MediaQuery.of(context).size.width / 5,
                        buttonHeight: 40,
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: background,
                        ),
                        hint: Text(
                          'Choisir',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: hours
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ))
                            .toList(),
                        value: timeBefore,
                        onChanged: (value) {
                          setState(() {
                            timeBefore = value.toString();
                          });
                        },
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                        itemHeight: 40,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Buffer Time After:"),
                    Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: 40,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonPadding: EdgeInsets.only(left: 10),
                            buttonWidth: MediaQuery.of(context).size.width / 5,
                            buttonHeight: 40,
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: Colors.black,
                              ),
                              color: background,
                            ),
                            hint: Text(
                              'Choisir',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme
                                    .of(context)
                                    .hintColor,
                              ),
                            ),
                            items: hours
                                .map((item) =>
                                DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ))
                                .toList(),
                            value: timeAfter,
                            onChanged: (value) {
                              setState(() {
                                timeAfter = value.toString();
                              });
                            },
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            itemHeight: 40,
                          ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Capacité Minimal:"),
                    Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: background,
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                if(min != 1) {
                                  setState(() {
                                    min--;
                                  });
                                }
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  color: min != 1 ? Colors.blue : Colors.black12,
                                  child: Center(
                                    child: Icon(Icons.remove, color: Colors.white),
                                  )
                              ),
                            ),
                            Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width / 5 - 100,
                                child: Center(
                                    child: Text(min.toString())
                                )
                            ),
                            Spacer(flex: 2),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  min++;
                                });
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  color: Colors.blue,
                                  child: Center(
                                    child: Icon(Icons.add, color: Colors.white),
                                  )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Capacité Maximal:"),
                    Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: background,
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                if(max != 1) {
                                  setState(() {
                                    max--;
                                  });
                                }
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  color: max != 1 ? Colors.blue : Colors.black12,
                                  child: Center(
                                    child: Icon(Icons.remove, color: Colors.white),
                                  )
                              ),
                            ),
                            Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width / 5 - 100,
                                child: Center(
                                    child: Text(max.toString())
                                )
                            ),
                            Spacer(flex: 2),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  max++;
                                });
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  color: Colors.blue,
                                  child: Center(
                                    child: Icon(Icons.add, color: Colors.white),
                                  )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
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