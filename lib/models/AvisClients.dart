import 'package:admin/models/ListAvisClients.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../Drawer_Menu/drawer_menu.dart';
import '../color_constants.dart';
import '../responsive.dart';


class AvisClients extends StatefulWidget {

  const AvisClients({
    Key? key
  }) : super(key: key);

  @override
  State<AvisClients> createState() => AvisClientsState();

}

class AvisClientsState extends State<AvisClients>{

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: background,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: Responsive.isDesktop(context) ? 30 : 10, left: 5, right: 5),
              width: MediaQuery.of(context).size.width,
              color: Palette.background,
              child: Row(
                children: [
                  SizedBox(width: 5),
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
                  SizedBox(width: 10),
                  Text(
                    "Avis de nos Clients", style: TextStyle(color: Color(0xFF032252), fontSize: 30,letterSpacing: 1, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ),
            Container(
                margin: EdgeInsets.only(top: 5),
                color: Palette.background,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable2(
                    columnSpacing: defaultPadding,
                    minWidth: 600,
                    dataRowHeight: 60,
                    showCheckboxColumn: false,
                    columns: [
                      DataColumn(label: Text("Le Client:", style: TextStyle(color: appColor, fontSize: 15, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text("Evaluation:", style: TextStyle(color: appColor, fontSize: 15, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text("Commentaire:", style: TextStyle(color: appColor, fontSize: 15, fontWeight: FontWeight.bold)), tooltip: "Voir le commentaire"),
                      DataColumn(label: Text("Date:", style: TextStyle(color: appColor, fontSize: 15, fontWeight: FontWeight.bold))),
                      DataColumn(label: Text("Commande:", style: TextStyle(color: appColor, fontSize: 15, fontWeight: FontWeight.bold)))
                    ],
                    rows: List.generate(
                      avisList.length,
                          (index) => avisDesClients(avisList[index], context),
                    ),
                  ),
                )
            ),
          ],
        ),
      )
    );
  }
}

DataRow avisDesClients(ListAvisClientsState listAvis, BuildContext context) {
  return DataRow(
    onSelectChanged: (_){
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              scrollable: true,
              title: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(listAvis.profilePic!), fit: BoxFit.fill
                          )
                      ),
                    ),
                    SizedBox(width: 10),
                    RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: listAvis.name!, style: TextStyle(color: appColor, letterSpacing: 2)),
                              TextSpan(text: "\nLe ", style: TextStyle(color: appColor, letterSpacing: 2)),
                              TextSpan(text: listAvis.date, style: TextStyle(color: Colors.blue, letterSpacing: 2))
                            ]
                        )
                    )
                  ],
                ),
              ),
              content: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  color: backgroundColor,
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding),
                    child:
                    Text(listAvis.comment!, style: TextStyle(),),
                  )
              )
          );
        },
      );
    },
    cells: [
      DataCell(
        Row(children: [
          Container(
            width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  color: Colors.blue,
                  image: DecorationImage(
                      image: AssetImage(listAvis.profilePic!), fit: BoxFit.fill))),
          SizedBox(width: 10),
          Text(listAvis.name!, style: TextStyle(color: Color(0xFF032252), fontSize: 15))
    ],)
          ),
      DataCell(Text(listAvis.evaluation.toString(), style: TextStyle(color: Color(0xFF032252), fontSize: 15)),),
      DataCell(
        listAvis.comment!.length > 100 ?
        Column(
          children: [
            Text(listAvis.comment!.substring(0, 50),overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF032252), fontSize: 15)),
            Text("Voir plus", style: TextStyle(color: Colors.blue, fontSize: 15))
          ],
        ) : Text(listAvis.comment!, style: TextStyle(color: Color(0xFF032252), fontSize: 15)),
      ),
      DataCell(Text(listAvis.date!, style: TextStyle(color: Color(0xFF032252), fontSize: 15))),
      DataCell(Text(listAvis.order.toString(), style: TextStyle(color: Color(0xFF032252), fontSize: 15)))
    ],
  );
}