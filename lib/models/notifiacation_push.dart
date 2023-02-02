import 'package:admin/controllers/menu_animation.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../color_constants.dart';
import '../widgets/input_widget.dart';

class PushNotification extends StatefulWidget {

  const PushNotification({
    Key? key
  }) : super(key: key);

  @override
  State<PushNotification> createState() => PushNotificationState();

}

class PushNotificationState extends State<PushNotification>{

  List notifications = [
    {'client': 'John Snow','email': 'john.snow@gmail.com','profilePic': 'assets/images/man.png', 'role': 'Client', 'date': 'Lundi,13 Jan', 'content': 'Fermeture du salon ce jour à \npartir de demain mardi 14 jan pour le néttoyage', 'titre': 'Fermeture', 'status': 'Envoyé'},
    {'client': 'Will Baratheon','email': 'will.baratheon@gmail.com','profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'content': 'Fermeture du salon ce jour à partir de demain mardi 14 jan pour le néttoyage', 'date': '11:30', 'titre': 'Fermeture', 'status': 'Envoyé'},
    {'client': 'Beth Salma','email': 'beth.salma@gmail.com','profilePic': 'assets/images/photo_2022-11-23_04-40-50.jpg', 'content': 'Pour les fetes de noels réduction de 10% de chaques coupe chez Wiill on hair', 'date': 'Lundi,13 Jan', 'titre': 'Spéciale Réducton', 'status': 'Envoyé'},
    {'client': 'Miranda Abigelle','email': 'abigaelle@gmail.com','profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'content': 'Fermeture du salon ce jour à partir de demain mardi \n14 jan pour le néttoyage', 'date': 'Lundi,13 Jan', 'titre': 'Fermeture', 'status': 'échec'},
    {'client': 'Will Smith','email': 'will@smithy.com','profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'content': 'Fermeture du salon ce jour à partir de demain mardi 14 jan pour le néttoyage', 'date': 'Mercredi,15 Jan', 'titre': 'Fermeture', 'status': 'échec'},
    {'client': 'Bethy Bones','email': 'bethy.bones@hotmail.com','profilePic': 'assets/images/man.png', 'content': 'Fermeture du salon ce jour à partir de demain \n\nmardi 14 jan pour le néttoyage', 'date': 'Lundi,13 Jan', 'titre': 'Fermeture', 'status': 'Envoyé'},
    {'client': 'Miranda Show','email': 'miranda.show@gmail.com','profilePic': 'assets/images/photo_2022-11-23_04-40-34.jpg', 'content': 'Fermeture du salon \n\nce jour à partir de demain mardi 14 jan pour \nle néttoyage', 'date': 'Lundi,13 Jan', 'titre': 'Fermeture', 'status': 'échec'},
  ];

  String? selectedService;
  String? selectedPlace;
  bool onSaveLoading = false;

  @override
  Widget build(BuildContext context){
    return Material(
      child: MenuAnimation(delay: 50, child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height - 50,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Palette.background,
            child: Row(
              children: [
                Text("Notifications", style: TextStyle(color: appColor, fontSize: 30, fontWeight: FontWeight.bold),),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: background,
                  child: Center(
                    child: Text(notifications.length.toString()),
                  ),
                ),
                SizedBox(width: 10),
                Text("Total", style: TextStyle(color: Colors.grey, fontSize: 20),),
                Spacer(flex: 2),
                ElevatedButton.icon(onPressed: (){
                  showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        child: Container(
                          width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.height/2,
                          padding: EdgeInsets.only(top: 10, bottom: 10,left: 30, right: 30),
                          color: Palette.background,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Envoyer une Notification", style: TextStyle(fontSize: 20, color: doneStatus, fontWeight: FontWeight.bold,letterSpacing: 2)),
                              SizedBox(height: 20),
                              InputWidget(
                                //kController: firstNameController,
                                onSaved: (String? value) {},
                                onChanged: (String? value) {},
                                validator: (String? value) {
                                  return (value != null && value.isEmpty)
                                      ? 'field required!'
                                      : null;
                                },

                                topLabel: "Entrez le Titre",
                              ),
                              SizedBox(height: 10),
                              InputMultilineWidget(
                                //kController: firstNameController,
                                onSaved: (String? value) {},
                                onChanged: (String? value) {},
                                minLines: 4,
                                maxLines: 6,
                                validator: (String? value) {
                                  return (value != null && value.isEmpty)
                                      ? 'field required!'
                                      : null;
                                },
                                topLabel: "Entrez votre Message",
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Spacer(),
                                  InkWell(
                                    child: Container(
                                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                            border: Border.all(color: inactive)
                                        ),
                                        child: Text("Annuler", style: TextStyle(color: inactive),)
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
                                                )) : Text("Envoyer"),
                                          )
                                      )
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }, icon: Icon(Icons.add), label: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("Nouvel Notification"),
                ))
              ],
            ),
          ),
          SizedBox(height: 3),
          Container(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                children: [
                  Expanded(
                      child: GroupedListView<dynamic, String>(
                        elements: notifications,
                        groupBy: (element) => element['date'],
                        groupComparator: (value1, value2) => value2.compareTo(value1),
                        itemComparator: (item1, item2) =>
                            item1['client'].compareTo(item2['client']),
                        order: GroupedListOrder.ASC,
                        useStickyGroupSeparators: true,
                        groupSeparatorBuilder: (String value) => Container(
                            color: background,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
                              child: Text(
                                value,
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            )
                        ),
                        itemBuilder: (c, element) {
                          return Container(
                            padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: backgroundColor)
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(element['profilePic']), fit: BoxFit.fill
                                            )
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 20),
                                          alignment: Alignment.centerLeft,
                                          width: 160,
                                          child: Text("${element['client']}\n${element['date']}"),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.topLeft,
                                    width: MediaQuery.of(context).size.width/1.6,
                                    color: background,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width/2,
                                          child: RichText(
                                            text: TextSpan(
                                                children: [
                                                  TextSpan(text: "${element['titre']}", style: TextStyle(color: doneStatus, fontWeight: FontWeight.bold,letterSpacing: 2)),
                                                  TextSpan(text: "\n\n${element['content']}", style: TextStyle(letterSpacing: 1, color: appColor)),
                                                ]
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        element["status"] == "Envoyé" ? Container(
                                            padding: EdgeInsets.all(10),
                                            width: 100,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: validateColor.withOpacity(0.2),
                                                borderRadius: BorderRadius.all(Radius.circular(30))
                                            ),
                                            child: Text(element["status"], style: TextStyle(color: validateColor, fontWeight: FontWeight.bold))
                                        ) : Container(
                                            padding: EdgeInsets.all(10),
                                            width: 100,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: specialColor.withOpacity(0.2),
                                                borderRadius: BorderRadius.all(Radius.circular(30))
                                            ),
                                            child: Text(element["status"], style: TextStyle(color: specialColor, fontWeight: FontWeight.bold))
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                          );
                        },
                      )
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}