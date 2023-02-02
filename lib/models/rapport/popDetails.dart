
import 'package:admin/controllers/animatonFadeIn.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../color_constants.dart';


class OrderDetails extends StatefulWidget {

  const OrderDetails({
    Key? key
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => OrderDetailsState();

}

class OrderDetailsState extends State<OrderDetails>{

  List details = [
    {'Article': 'Coupe ADO [00:30]','quantité': '1','prix unitaire': '13.00€','remise': '2','taxe': '3.00€', 'sous-total hors TVA': '13.00€', 'sous-total': '13.00€',},
    {'Article': 'Coupe ADO [00:30]','quantité': '1','prix unitaire': '13.00€','remise': '3','taxe': '3.00€','sous-total hors TVA': '13.00€', 'sous-total': '15.00€',},
    {'Article': 'Coupe ADO [00:30]','quantité': '1','prix unitaire': '13.00€','remise': '2','taxe': '3.00€', 'sous-total hors TVA': '13.00€', 'sous-total': '13.00€',},
    {'Article': 'Coupe ADO [00:30]','quantité': '2','prix unitaire': '13.00€','remise': '3','taxe': '3.00€','sous-total hors TVA': '13.00€', 'sous-total': '15.00€',},
    {'Article': 'Coupe ADO [00:30]','quantité': '1','prix unitaire': '13.00€','remise': '2','taxe': '3.00€', 'sous-total hors TVA': '13.00€', 'sous-total': '13.00€',},
    {'Article': 'Coupe ADO [00:30]','quantité': '2','prix unitaire': '13.00€','remise': '3','taxe': '3.00€','sous-total hors TVA': '13.00€', 'sous-total': '15.00€',},
    {'Article': 'Coupe ADO [00:30]','quantité': '1','prix unitaire': '13.00€','remise': '2','taxe': '3.00€', 'sous-total hors TVA': '13.00€', 'sous-total': '13.00€',},
    {'Article': 'Coupe ADO [00:30]','quantité': '2','prix unitaire': '13.00€','remise': '3','taxe': '3.00€','sous-total hors TVA': '13.00€', 'sous-total': '15.00€',},
  ];

  @override
  Widget build(BuildContext context) {
    double width = 200;
    return FadeIn(delay: 50,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Palette.background,
          ),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    color: background,
                  ),
                  child: Text("Détails de la commande", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 25))
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 200,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(width: 2.0, color: primaryColor),
                                ),
                              ),
                              child: Text("Réf. Commande", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                            ),
                            Text("Shop/006")
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(width: 2.0, color: primaryColor),
                                ),
                              ),
                              child: Text("Employé", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                            ),
                            Text("Salomon", style: TextStyle(color: primaryColor, letterSpacing: 1))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 200,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(width: 2.0, color: primaryColor),
                                ),
                              ),
                              child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                            ),
                            Text("26/08/2022 15:38:05")
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(width: 2.0, color: primaryColor),
                                ),
                              ),
                              child: Text("Client", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                            ),
                            Text("ANONYME", style: TextStyle(color: primaryColor, letterSpacing: 1))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 5),
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    children: [
                      Expanded(
                          child: GroupedListView<dynamic, String>(
                            elements: details,
                            groupBy: (details) => details['Article'],
                            groupComparator: (value1, value2) => value2.compareTo(value1),
                            itemComparator: (item1, item2) =>
                                item1['sous-total'].compareTo(item2['sous-total']),
                            order: GroupedListOrder.ASC,
                            useStickyGroupSeparators: true,
                            groupSeparatorBuilder: (String value) => Container(
                                decoration: BoxDecoration(
                                  color: background,
                                  //borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                                ),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    SizedBox(width: width - 50,child: Text(
                                      "Article",
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(width: width - 50,child: Text(
                                      "Quantité",
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(width: width,child: Text(
                                      "Prix Unitaire",
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(width: width,child: Text(
                                      "Remise (%)",
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(width: width,child: Text(
                                      "Taxes",
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(width: width - 40,child: Text(
                                      "Sous-total hors TVA",
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(width: width,child: Text(
                                      "Sous -total",
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                )
                            ),
                            itemBuilder: (c, details) {
                              return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: backgroundColor),
                                      color: Palette.background
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: width - 50,
                                              child: Text(details['Article'])),
                                          SizedBox(
                                              width: width - 50,
                                              child: Text(details['quantité'])),
                                          SizedBox(width: width, child: Text(details['prix unitaire']),),
                                          SizedBox(width: width, child: Text(details['remise']),),
                                          SizedBox(width: width, child: Text(details['taxe']),),
                                          SizedBox(
                                              width: width - 40,
                                              child: Text(details['sous-total hors TVA'])),
                                          SizedBox(width: 50, child: Text(details['sous-total']),),
                                        ],
                                      ),
                                    ],
                                  )
                              );
                            },
                          )
                      ),
                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: appColor),
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Taxes: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5, left: 15),
                              child: Text("-11.05 ", style: TextStyle(color: primaryColor)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text("Total: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5, left: 15),
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide( color: appColor),
                                  )
                              ),
                              child: Text("65,35 ", style: TextStyle(fontSize: 20, color: primaryColor,fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text("Total Payé(avec arrondi): ", style: TextStyle(fontWeight: FontWeight.bold)),
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 25, left: 15),
                            child: Text("65,35 ", style: TextStyle(fontSize: 20, color: primaryColor,fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: validateColor
                        ),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: 50,
                            decoration: BoxDecoration(
                              color: validateColor,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Center(child: Text("OK", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 15))),
                          ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}