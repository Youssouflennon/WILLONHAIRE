
import 'package:admin/Caisse/paiement.dart';
import 'package:admin/Popup%20Windows/EndDrawer.dart';
import 'package:admin/controllers/animatonFadeIn.dart';
import 'package:admin/models/selectioner_client.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

import '../Popup Windows/Pourboire.dart';
import '../Popup Windows/Remise.dart';
import '../Popup Windows/Transfer.dart';
import '../color_constants.dart';
import '../responsive.dart';

class InterfacePOS extends StatefulWidget {

  const InterfacePOS({
    Key? key
  }) : super(key: key);

  @override
  State<InterfacePOS> createState() => InterfacePOSState();

}

class InterfacePOSState extends State<InterfacePOS>{

  int selected = 0;
  bool styleSelected = false;
  List hairStyleAdded = [];
  String selectedClient = "";
  double total = 0;
  String clientName = "";
  double remise = 0;
  double pourboire = 0;

  int selectedIndex = 0;
  final box = Hive.box("myBox");

  onSelected(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  void initState() {
    super.initState();
    initialValues();
  }

  initialValues(){
    if(box.get("getPourboire") != null){
      pourboire = double.parse(box.get("getPourboire"));
    }
    if(box.get("getRemise") != null){
      remise = double.parse(box.get("getRemise"));
    }
    if(box.get("getClient") != null){
      clientName = box.get("getClient");
    }
    if(box.get("listOfServices") != null){
      hairStyleAdded = box.get("listOfServices");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FadeIn(delay: 20,
          child: _buildStyles(context)
      )
    );
  }

  _buildStyles(BuildContext context){
    double customWidth = Responsive.isDesktop(context) ? (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width /1.5) :
      (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width /1.6);
    double width = 180;
    return Container(
        height: MediaQuery.of(context).size.height,
        margin: Responsive.isDesktop(context) ? null: EdgeInsets.only(top: 30),
        child: Row(
          children: [
            Container(
                color: background,
                width: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width / 1.5 :
                Responsive.isTablet(context) ? MediaQuery.of(context).size.width /1.6 :
                MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: IconButton(onPressed: (){
                            Navigator.push(
                              context,
                              PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                                  child: MainScreen()),
                            );
                            Hive.box('myBox').clear();
                          }, icon: Icon(Icons.arrow_back_ios_rounded)),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/logoWillOnHair.png")
                              )
                          ),
                        ),
                        Text("MANAGER", style: TextStyle(color: appColor,letterSpacing: 2, fontSize: 15)),
                        Spacer(flex: 2),
                        Container(
                            width: MediaQuery.of(context).size.width / 6,
                            height: 30,
                            child: TextFormField(
                              //controller: ,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: backgroundColor,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                  hintText: "Rechercher des services",
                                  hintStyle: TextStyle(fontSize: 12),
                                  suffixIcon: InkWell(
                                      onTap: (){
                                        print("Searching...");
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5)
                                          ),
                                          color: Colors.blue,
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: Center(
                                            child: Icon(Icons.search, color: Palette.background)
                                        ),
                                      )
                                  )
                              ),
                              validator: (String? value) {
                                return (value != null && value.isEmpty)
                                    ? 'field required!'
                                    : null;
                              },
                            )
                        ),
                        SizedBox(width: 10),
                        ElevatedButton.icon(onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => EndMenu());
                        },
                            icon: Icon(Icons.recommend),
                            label: Text("Commandes")
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      width: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(right: 10.0, top: 8.0),
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: selected == index ? blue : Color.fromRGBO(248,248,248,1),
                              ),
                              child: Center(
                                child: Text(
                                  "Coupes hommes",
                                  style: TextStyle(
                                      color: selected == index ? CupertinoColors.white : appColor, letterSpacing: 2),
                                ),
                              ),
                            ),
                            onTap: ()async{
                              //getCategoryById(category![index].id);
                              setState(() {
                                selected = index;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: GridView(
                        padding: EdgeInsets.only(
                            top: 12, left: 12, right: 12),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: List<Widget>.generate(
                          12,
                              (int index) {
                            return AspectRatio(
                              aspectRatio: 1.5,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: <Widget>[
                                    Positioned.fill(
                                        child: InkWell(
                                          onTap: ()async{
                                            setState(() {
                                              onSelected(index);
                                              styleSelected = true;
                                              hairStyleAdded.add("Coupe enfant");
                                            });
                                            box.put("listOfServices", hairStyleAdded);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(top: 10, bottom: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: Colors.white
                                                //border: Border.all(width: 3, color: Colors.grey)
                                              ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: 130,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage("assets/images/240_F_265073366_wXcritZmlOMNsxq2DsgkiCJJeJ9p1eKo.jpeg"),
                                                      fit: BoxFit.cover,
                                                      //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
                                                    ),
                                                    borderRadius: BorderRadius.circular(15),

                                                    //border: Border.all(width: 3, color: Colors.grey)
                                                  ),
                                                  child: styleSelected && selectedIndex == index ? Align(
                                                      alignment: Alignment.topRight,
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        radius: 20,
                                                        child: Icon(Icons.check_circle, color: CupertinoColors.activeGreen, size: 40),
                                                      )
                                                  ) : null,
                                                ),
                                                Text("Coupe enfants")
                                              ],
                                            )
                                          )
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
                          mainAxisSpacing: 12.0,
                          crossAxisSpacing: 12.0,
                          childAspectRatio: 1.5,
                        ),
                      ),
                    )
                  ],
                )
            ),
            if(MediaQuery.of(context).size.width > 850)
              Container(
                  color: Palette.background,
                  width: customWidth,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                            itemCount: hairStyleAdded.length,
                            itemBuilder: (context, item){

                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                                    child: Row(
                                      children: [
                                        IconButton(onPressed: (){
                                          setState(() {
                                            hairStyleAdded.removeAt(item);
                                          });
                                          box.deleteAt(item);
                                        }, icon: Icon(Icons.delete, color: Colors.red)),
                                        SizedBox(width: 10),
                                        RichText(
                                          text: TextSpan(
                                              children: [
                                                TextSpan(text: hairStyleAdded[item], style: TextStyle(fontSize: 20, color: appColor)),
                                                TextSpan(text: "\n1 coupe à 15€ / unité", style: TextStyle(fontSize: 15, color: CupertinoColors.systemGrey)),
                                              ]
                                          ),
                                        ),
                                        Spacer(flex: 2),
                                        Text("15.O €", style: TextStyle(fontSize: 15, color: CupertinoColors.destructiveRed, fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                  Divider(color: CupertinoColors.black),
                                ],
                              );
                            }),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child:
                          Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            color: CupertinoColors.black,
                            padding: EdgeInsets.all(5),
                            width: customWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width / 7,
                                      child: RichText(
                                          text: TextSpan(
                                              children: [
                                                TextSpan(text: "Remise: ", style: TextStyle(color: Colors.white, letterSpacing: 1, fontSize: 15)),
                                                TextSpan(text: remise.toString(), style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 20, fontWeight: FontWeight.bold))
                                              ]
                                          )
                                      ),
                                    ),
                                    Spacer(flex: 2),
                                    Container(
                                        width: MediaQuery.of(context).size.width / 7,
                                        child: RichText(
                                            text: TextSpan(
                                                children: [
                                                  TextSpan(text: "Taxes: ", style: TextStyle(color: Colors.white, letterSpacing: 1, fontSize: 15)),
                                                  TextSpan(text: "0 EUR", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 20, fontWeight: FontWeight.bold))
                                                ]
                                            )
                                        )
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width / 7,
                                      child: RichText(
                                          text: TextSpan(
                                              children: [
                                                TextSpan(text: "Pourboire: ", style: TextStyle(color: Colors.white, letterSpacing: 1, fontSize: 15)),
                                                TextSpan(text: pourboire.toString(), style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 20, fontWeight: FontWeight.bold))
                                              ]
                                          )
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 7,
                                      child: RichText(
                                          text: TextSpan(
                                              children: [
                                                TextSpan(text: "Total: ", style: TextStyle(color: Colors.white, letterSpacing: 1, fontSize: 15)),
                                                TextSpan(text: total.toString(), style: TextStyle(color: validateColor, letterSpacing: 2, fontSize: 20, fontWeight: FontWeight.bold))
                                              ]
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.white),
                                //SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(onTap: (){
                                      Navigator.of(context).push( MaterialPageRoute<Null>(
                                          builder: (BuildContext context) {
                                            return SelectClient();
                                          },
                                          fullscreenDialog: true));
                                    },child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue, width: 2),
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                      ),
                                      width: width,
                                      height: 40,
                                        padding: EdgeInsets.only(left: 5, right: 5),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: AssetImage("assets/images/man.png"),
                                                  )
                                              ),
                                            ),
                                            Text(clientName.isEmpty ? "ANONYME" : clientName, style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 20)
                                            ),
                                          ],
                                        ),
                                      )
                                    ),
                                    ),

                                    InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blue, width: 2),
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                        ),
                                        width: width,
                                        height: 40,
                                          padding: EdgeInsets.only(left: 5, right: 5),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage("assets/images/data-transfer.png"),
                                                    )
                                                ),
                                              ),
                                              Text("TRANSFER", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 20)
                                              ),
                                            ],
                                          ),
                                        )
                                      ),
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) => Transfer());
                                      },
                                    )
                                  ],
                                ),
                                //SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) => Remise());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blue, width: 2),
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                        ),
                                        width: width,
                                        padding: EdgeInsets.only(left: 5, right: 5),
                                        height: 40,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage("assets/images/offer.png"),
                                                    )
                                                ),
                                              ),
                                              Text("REMISE", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 20)
                                              ),
                                            ],
                                          ),
                                        )
                                      ),
                                    ),
                                    InkWell(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) => Pourboire());
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.blue, width: 2),
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                          ),
                                          width: width,
                                            padding: EdgeInsets.only(left: 5, right: 5),
                                          height: 40,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage("assets/images/gift.png"),
                                                      )
                                                  ),
                                                ),
                                                Text("POURBOIRE", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 20)
                                                ),
                                              ],
                                            ),
                                          )
                                        )
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                    });
                                    if(clientName.isEmpty){
                                      box.put("getClient", "ANONYME");
                                    }else{
                                      box.put("getClient", clientName);
                                    }
                                    if(hairStyleAdded.isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            child: CashPayment()),
                                      );
                                    }else{
                                      final snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.fixed,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Attention!',
                                          message:
                                          'Vous devez choisir au moins un service',
                                          contentType: ContentType.warning,
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(snackBar);
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2.1,
                                    height: 40,
                                    margin: EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: validateColor,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Center(child: Text("PAYER", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 20))),
                                  ),
                                ),
                                //SizedBox(height: 20),
                              ],
                            ),
                          ))
                    ],
                  )
              )
          ],
        )
    );
  }
}
