import 'package:admin/controllers/animatonFadeIn.dart';
import 'package:admin/models/Settings/Services.dart';
import 'package:admin/models/Settings/employee.dart';
import 'package:admin/models/Settings/location.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../color_constants.dart';
import '../controllers/menu_animation.dart';
import 'Settings/all_clients.dart';
import 'Settings/users.dart';
import 'package:http/http.dart' as http;

class Reglages extends StatefulWidget {

  const Reglages({
    Key? key
  }) : super(key: key);

  @override
  State<Reglages> createState() => ReglagesState();

}

class ReglagesState extends State<Reglages>{

  int currentState = 0;
  int otherState = 0;
  int points = 10;
  TextEditingController bonusController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Material(
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    double width = 120;
    return Container(
      padding: EdgeInsets.all(5),
      color: background,
      child:  Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            color: Palette.background,
            child: Row(
              children: [
                Text("Reglages", style: TextStyle(color: appColor, fontSize: 30)),
                SizedBox(width: 10),
                Container(
                  width: 3,
                  height: 50,
                  color: background,
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: (){
                    setState(() {
                      currentState = 0;
                    });
                  },
                  child: Container(
                    width: width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: currentState == 0 ? background : null,
                        border: currentState == 0 ? Border(
                            bottom: BorderSide(width: 4, color: validateColor)
                        ): null
                    ),
                    child: Text("Employee"),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      currentState = 1;
                    });
                  },
                  child: Container(
                    width: width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: currentState == 1 ? background : null,
                        border: currentState == 1 ? Border(
                            bottom: BorderSide(width: 4, color: validateColor)
                        ): null
                    ),
                    child: Text("Services"),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      currentState = 2;
                    });
                  },
                  child: Container(
                    width: width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: currentState == 2 ? background : null,
                        border: currentState == 2 ? Border(
                            bottom: BorderSide(width: 4, color: validateColor)
                        ): null
                    ),
                    child: Text("Emplacements"),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      currentState = 3;
                    });
                  },
                  child: Container(
                    width: width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: currentState == 3 ? background : null,
                        border: currentState == 3 ? Border(
                            bottom: BorderSide(width: 4, color: validateColor)
                        ): null
                    ),
                    child: Text("Clients"),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      currentState = 4;
                    });
                  },
                  child: Container(
                    width: width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: currentState == 4 ? background : null,
                        border: currentState == 4 ? Border(
                            bottom: BorderSide(width: 4, color: validateColor)
                        ): null
                    ),
                    child: Text("Autre"),
                  ),
                ),
              ],
            ),
          ),
          currentState == 0 ? Employee() :
              currentState == 1 ? Services() :
                  currentState == 2 ? Location() :
                      currentState == 3 ? AllClients() :
                        buildOther(context)
        ],
      ),
    );
  }

  Widget buildOther(BuildContext context){
    return FadeIn(delay: 50,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          color: Palette.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        otherState = 0;
                      });
                    },
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: otherState == 0 ? background : null,
                          border: otherState == 0 ? Border(
                              bottom: BorderSide(width: 4, color: validateColor)
                          ): null
                      ),
                      child: Text("Utilisateurs"),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        otherState = 1;
                      });
                    },
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: otherState == 1 ? background : null,
                          border: otherState == 1 ? Border(
                              bottom: BorderSide(width: 4, color: validateColor)
                          ): null
                      ),
                      child: Text("Stratégie de fidélisation"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              otherState == 0 ? Users() : buildBonusStrategy(context),

            ],
          )
        ),
    );
  }

  Widget buildBonusStrategy(BuildContext context){
    return Container(
      padding: EdgeInsets.all(10),
      child: MenuAnimation(delay: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Nombre de points", style: TextStyle(color: appColor, fontSize: 20)),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: background,
                  child: Center(
                    child: Text(points.toString()),
                  ),
                ),
                SizedBox(width: 10),
                Text("Total", style: TextStyle(color: Colors.grey, fontSize: 20),),
                Spacer(flex: 2),
              ],
            ),
            SizedBox(height: 20),
            Text("Gagnez un bonus après ${points.toString()} points", style: TextStyle(color: appColor, fontSize: 20)),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Modifiez le nombre de points: ", style: TextStyle(color: appColor, fontSize: 15)),
                Container(
                    width: MediaQuery.of(context).size.width / 8,
                    height: 40,
                    child: TextFormField(
                      controller: bonusController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        fillColor: background,
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Theme
                              .of(context)
                              .hintColor,
                        ),
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
            SizedBox(height: 50),
            Row(
              children: [
                InkWell(
                  onTap: (){                                      
                    if(bonusController.text.isNotEmpty){
                      setState(() {
                        points = int.parse(bonusController.text);
                      });
                        putBonusFidel();
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 8,
                    height: 50,
                    decoration: BoxDecoration(
                      color: validateColor,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(child: Text("ENREGISTRER", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 15))),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: (){
                     
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 8,
                    height: 50,
                    decoration: BoxDecoration(
                      color: inactive,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(child: Text("ANNULER", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 15))),
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }
  
   putBonusFidel()async {

    var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('PUT', Uri.parse('http://192.168.16.116:3000/api/settings/fidelity-card/points-to-bonus?value=element'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
    final snackBar = SnackBar(
      elevation: 2,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Succès',
        message:
        'Nombre de points Modifié avec succès!',
        contentType: ContentType.success,
      ),
    );
    
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
        bonusController.clear();
                    
}
else {
  print(response.reasonPhrase);
  final snackBar = SnackBar(
      elevation: 2,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Echec',
        message:
        'OUPSS!',
        contentType: ContentType.failure,
      ),
    );
    
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
}

    
   }
}


