import 'package:admin/controllers/animatonFadeIn.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:hive/hive.dart';
import '../color_constants.dart';

class CashPayment extends StatefulWidget {

  const CashPayment({
    Key? key
  }) : super(key: key);

  @override
  State<CashPayment> createState() => CashPaymentState();

}

class CashPaymentState extends State<CashPayment>{

  double due = 13.00;
  double change = 0.00;
  double secondChange = 0.00;
  double finalChange = 0.00;
  double validateChange = -1.00;
  bool readOnly = false;

  var paymentMethod = "Choisir";
  var paymentMethod2 = "Choisir";
  var paymentMethod3 = "Choisir";
  bool onClick = false;
  bool onClick2 = false;
  bool showButton = false;
  bool selectPaymentMethod = false;
  List  hairStyles = [];
  double pourboire = 0;
  double remise = 0;
  String client = "";

  String? selectedMethod;
  String? selectedMethod2;

  final TextEditingController _myController = TextEditingController();
  final TextEditingController restController = TextEditingController();
  final TextEditingController thirdRestController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialValues();
  }

  final box = Hive.box("myBox");

  initialValues(){
    if(box.get("getPourboire") != null){
      pourboire = double.parse(box.get("getPourboire"));
    }
    if(box.get("getRemise") != null){
      remise = double.parse(box.get("getRemise"));
    }
      client = box.get("getClient");
      hairStyles = box.get("listOfServices");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
          height: MediaQuery.of(context).size.height,
          color: Palette.background,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: background,
                    child: Row(
                      children: [
                        ElevatedButton.icon(onPressed: (){
                          Navigator.pop(context);
                        },
                            icon: Icon(Icons.arrow_back_ios_outlined, size: 15),
                            label: Text("RETOUR", style: TextStyle(fontSize: 20))
                        ),
                        Spacer(),
                        Text("Paiement", style: TextStyle(fontSize: 20, color: appColor)),
                        Spacer(),

                        validateChange >= 0 ?
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: validateColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: (){

                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 6,
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.recommend),
                                  SizedBox(width: 10),
                                  Text("Valider", style: TextStyle(fontSize: 20))
                                ],
                              ),
                            )
                        ) : Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: CupertinoColors.inactiveGray
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.recommend, color: Colors.white),
                              SizedBox(width: 10),
                              Text("Valider", style: TextStyle(fontSize: 20, color: Colors.white))
                            ],
                          ),
                        )
                      ],
                    ),
                  )

              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        color: background,
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height -70,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectPaymentMethod = !selectPaymentMethod;
                                    paymentMethod = "Espèces";
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: appColor,
                                  ),
                                  padding: EdgeInsets.all(25),
                                  child: Row(
                                    children: [
                                      Icon(Icons.attach_money_rounded, color: background,size: 30),
                                      Spacer(),
                                      Text("Espèces",style: TextStyle(color: background, fontSize: 20)),
                                      Spacer(),
                                    ],
                                  ),

                                ),
                              ),
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectPaymentMethod = !selectPaymentMethod;
                                    paymentMethod = "Carte Bancaire";
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: appColor,
                                  ),
                                  padding: EdgeInsets.all(25),
                                  child: Row(
                                    children: [
                                      Icon(Icons.payment, color: background,size: 30),
                                      Spacer(),
                                      Text("Carte Bancaire",style: TextStyle(color: background, fontSize: 20)),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => FadeIn(delay: 200,
                                          child: AlertDialog(
                                              contentPadding: EdgeInsets.all(10),
                                              backgroundColor: background,
                                              content: Container(
                                                height: MediaQuery.of(context).size.height /3,
                                                width: MediaQuery.of(context).size.width /2,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text("Choisissez un bonus a utiliser", style: TextStyle(fontSize: 20)),
                                                    SizedBox(height: 30),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        InkWell(
                                                            onTap: (){
                                                              setState(() {
                                                                selectPaymentMethod = !selectPaymentMethod;
                                                                paymentMethod = "Bonus 10";
                                                                _myController.text = "10";
                                                                onClick = true;
                                                                change = double.parse(_myController.text) - due;
                                                              });
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.height /7,
                                                              height: MediaQuery.of(context).size.height /7,
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage("assets/images/photo_2023-01-12_17-47-37.png")
                                                                  )
                                                              ),
                                                            )
                                                        ),
                                                        InkWell(
                                                            onTap: (){
                                                              setState(() {
                                                                selectPaymentMethod = !selectPaymentMethod;
                                                                paymentMethod = "Bonus 13";
                                                                _myController.text = "13";
                                                                onClick = true;
                                                                change = double.parse(_myController.text) - due;
                                                              });
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.height /7,
                                                              height: MediaQuery.of(context).size.height /7,
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage("assets/images/photo_2023-01-12_17-47-32.png")
                                                                  )
                                                              ),
                                                            )
                                                        ),
                                                        InkWell(
                                                            onTap: (){
                                                              setState(() {
                                                                selectPaymentMethod = !selectPaymentMethod;
                                                                paymentMethod = "Bonus 15";
                                                                _myController.text = "15";
                                                                onClick = true;
                                                                change = double.parse(_myController.text) - due;
                                                              });
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.height /7,
                                                              height: MediaQuery.of(context).size.height /7,
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage("assets/images/photo_2023-01-12_17-47-41.png")
                                                                  )
                                                              ),
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                          )
                                      )
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: appColor,
                                  ),
                                  padding: EdgeInsets.all(25),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: background,
                                            shape: BoxShape.circle
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage("assets/images/trophy (1).png"),
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text("Bonus",style: TextStyle(color: background, fontSize: 20)),
                                      Spacer(),
                                    ],
                                  ),

                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: MediaQuery.of(context).size.height / 1.7,
                                width: MediaQuery.of(context).size.width / 4,
                                color: Palette.background,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text("Pourboire: $pourboire", style: TextStyle(fontSize: 20)),
                                      subtitle: Text("Remise: $remise", style: TextStyle(fontSize: 15)),
                                    ),
                                    SizedBox(height: 10),
                                    Text("Détails de la commande:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: hairStyles.length,
                                          itemBuilder: (context, item){

                                            return Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 10),
                                                      RichText(
                                                        text: TextSpan(
                                                            children: [
                                                              TextSpan(text: hairStyles[item], style: TextStyle(fontSize: 20, color: appColor)),
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
                                    )
                                  ],
                                ),
                              ),
                              if(!Responsive.isDesktop(context))
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  decoration: BoxDecoration(
                                    color: background,
                                  ),
                                  padding: EdgeInsets.all(25),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage("assets/images/man.png"),
                                                )
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text("William",style: TextStyle(color: appColor, fontSize: 20)),
                                          Spacer(),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.star, color: appColor,size: 30),
                                          SizedBox(width: 10),
                                          Text("Points",style: TextStyle(color: appColor, fontSize: 20)),
                                          Spacer(),
                                          Text("8",style: TextStyle(color: CupertinoColors.systemRed, fontSize: 20)),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage("assets/images/trophy (1).png"),
                                                )
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text("Bonus",style: TextStyle(color: appColor, fontSize: 20)),
                                          Spacer(),
                                          Text("2",style: TextStyle(color: CupertinoColors.systemRed, fontSize: 20)),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          )
                        )
                    ),
                    Container(
                        color: Palette.background,
                        width: MediaQuery.of(context).size.width / 1.5,
                        padding: EdgeInsets.all(20),
                        child: _buildBilling(context)
                    ),
                  ],
                )
              ),
            ],
          )
      ),
    );
  }

  Widget _buildBilling(BuildContext context){
    //var customWidth = MediaQuery.of(context).size.width / 3;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: selectPaymentMethod ? GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 100 / 25,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text('Due', style: TextStyle(fontSize: 20)),
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text('Reçu', style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text('Rendu', style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text('Méthode', style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        child: Text(due.toString(), style: TextStyle(fontSize: 30, color: background)),
                        color: Colors.black
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: background,
                            border: Border.all(color: blue, width: 2)
                        ),
                        child: TextFormField(
                          controller: _myController,
                          textAlign: TextAlign.center,
                          showCursor: false,
                          readOnly: readOnly,
                          onChanged: (value){
                            if(double.parse(value) >= due){
                              setState(() {
                                showButton = true;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              filled: true,
                              hintText: "0",
                              fillColor: Palette.background
                          ),
                          style: const TextStyle(fontSize: 40),
                          keyboardType: TextInputType.none,
                        )
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        child: Text(change.toString(), style: TextStyle(fontSize: 25,color: Palette.background)),
                        color: Colors.black.withOpacity(0.8)
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text(paymentMethod, style: TextStyle(fontSize: 15, color: Palette.background)),
                            Spacer(),
                            IconButton(onPressed: (){

                            }, icon: Icon(Icons.close, color: Palette.background))
                          ],
                        ),
                        color: Colors.black
                    ),
                    if(change < 0 && onClick)...[
                      Container(
                          padding: EdgeInsets.all(8),
                          child: Text(change.toString(), style: TextStyle(fontSize: 30, color: background)),
                          color: Colors.black
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: background,
                              border: Border.all(color: blue, width: 2)
                          ),
                          child: TextFormField(
                            controller: restController,
                            textAlign: TextAlign.center,
                            readOnly: readOnly,
                            showCursor: false,
                            onChanged: (value){
                              if(double.parse(value) >= due){
                                setState(() {
                                  showButton = true;
                                });
                              }
                            },
                            decoration: InputDecoration(
                                filled: true,
                                hintText: "0",
                                fillColor: Palette.background
                            ),
                            style: const TextStyle(fontSize: 40),
                            // Disable the default soft keyboard
                            keyboardType: TextInputType.none,
                          )
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          child: Text(secondChange.toString(), style: TextStyle(fontSize: 25,color: Palette.background)),
                          color: Colors.black.withOpacity(0.8)
                      ),
                      Container(
                          color: Colors.black,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(paymentMethod2, style: TextStyle(fontSize: 15, color: Palette.background)),
                              ),
                              Spacer(flex: 2),
                              FocusedMenuHolder(
                                blurSize: 1,
                                menuItemExtent: 40,
                                menuWidth: defaultPadding * 15,
                                menuBoxDecoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0))),
                                duration: Duration(
                                    milliseconds: 100),
                                animateMenuItems: true,
                                //blurBackgroundColor: Colors.black12.withOpacity(0.5),
                                openWithTap: true,
                                // Open Focused-Menu on Tap rather than Long Press
                                menuOffset: 10.0,
                                // Offset value to show menuItem from the selected item
                                bottomOffsetHeight: 30.0,
                                onPressed: () {

                                },
                                menuItems: <FocusedMenuItem>[
                                  FocusedMenuItem(title: Text("Espèces",style: TextStyle(color: appColor, letterSpacing: 2),),
                                      trailingIcon: Icon(Icons.attach_money_rounded, color: appColor),
                                      onPressed: (){
                                        setState(() {
                                          paymentMethod2 = "Espèces";
                                        });
                                      }),
                                  FocusedMenuItem(title: Text("Carte Bancaire",style: TextStyle(color: appColor, letterSpacing: 2),),
                                      trailingIcon: Icon(Icons.credit_card, color: appColor),
                                      onPressed: (){
                                        setState(() {
                                          paymentMethod2 = "Carte Bancaire";
                                        });
                                      }),
                                  FocusedMenuItem(title: Text("Bonus 10",style: TextStyle(color: appColor, letterSpacing: 2),),
                                      trailingIcon: Icon(Icons.star, color: pointColor),
                                      onPressed: (){
                                        setState(() {
                                          paymentMethod2 = "Bonus 10";
                                          if(!onClick2){
                                            setState(() {
                                              restController.text = "10";
                                              secondChange = double.parse(restController.text) + change;
                                              validateChange = secondChange;
                                            });
                                          }else{
                                            setState(() {
                                              thirdRestController.text = "10";
                                              finalChange = double.parse(thirdRestController.text) + secondChange;
                                              validateChange = finalChange;
                                            });
                                          }
                                        });
                                      }),
                                  FocusedMenuItem(title: Text("Bonus 13",style: TextStyle(color: appColor, letterSpacing: 2),),
                                      trailingIcon: Icon(Icons.star, color: pointColor),
                                      onPressed: (){
                                        setState(() {
                                          paymentMethod2 = "Bonus 13";
                                        });
                                        if(!onClick2){
                                          setState(() {
                                            restController.text = "13";
                                            secondChange = double.parse(restController.text) + change;
                                            validateChange = secondChange;
                                          });
                                        }else{
                                          setState(() {
                                            thirdRestController.text = "13";
                                            finalChange = double.parse(thirdRestController.text) + secondChange;
                                            validateChange = finalChange;
                                          });
                                        }
                                      }),
                                  FocusedMenuItem(title: Text("Bonus 15",style: TextStyle(color: appColor, letterSpacing: 2),),
                                      trailingIcon: Icon(Icons.star, color: pointColor),
                                      onPressed: (){
                                        setState(() {
                                          paymentMethod2 = "Bonus 15";
                                        });
                                        if(!onClick2){
                                          setState(() {
                                            restController.text = "15";
                                            secondChange = double.parse(restController.text) + change;
                                            validateChange = secondChange;
                                          });
                                        }else{
                                          setState(() {
                                            thirdRestController.text = "15";
                                            finalChange = double.parse(thirdRestController.text) + secondChange;
                                            validateChange = finalChange;
                                          });
                                        }
                                      }),
                                ],
                                child: Icon(Icons.keyboard_arrow_down, color: Palette.background),
                              ),
                            ],
                          )
                      ),
                    ],
                    if(secondChange < 0 && onClick2)...[
                      Container(
                          padding: EdgeInsets.all(8),
                          child: Text(secondChange.toString(), style: TextStyle(fontSize: 30, color: background)),
                          color: Colors.black
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: background,
                              border: Border.all(color: blue, width: 2)
                          ),
                          child: TextFormField(
                            controller: thirdRestController,
                            textAlign: TextAlign.center,
                            showCursor: false,
                            readOnly: readOnly,
                            onChanged: (value){
                              if(double.parse(value) >= due){
                                setState(() {
                                  showButton = true;
                                });
                              }
                            },
                            decoration: InputDecoration(
                                filled: true,
                                hintText: "0",
                                fillColor: Palette.background
                            ),
                            style: const TextStyle(fontSize: 40),
                            // Disable the default soft keyboard
                            keyboardType: TextInputType.none,
                          )
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          child: Text(finalChange.toString(), style: TextStyle(fontSize: 25,color: Palette.background)),
                          color: Colors.black.withOpacity(0.8)
                      ),
                      Container(
                          color: Colors.black,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(paymentMethod3, style: TextStyle(fontSize: 15, color: Palette.background)),
                              ),
                              Spacer(flex: 2),
                              FocusedMenuHolder(
                                blurSize: 1,
                                menuItemExtent: 40,
                                menuWidth: defaultPadding * 15,
                                menuBoxDecoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0))),
                                duration: Duration(
                                    milliseconds: 100),
                                animateMenuItems: true,
                                //blurBackgroundColor: Colors.black12.withOpacity(0.5),
                                openWithTap: true,
                                // Open Focused-Menu on Tap rather than Long Press
                                menuOffset: 10.0,
                                // Offset value to show menuItem from the selected item
                                bottomOffsetHeight: 30.0,
                                onPressed: () {

                                },
                                menuItems: <FocusedMenuItem>[
                                  FocusedMenuItem(title: Text("Espèces",style: TextStyle(color: appColor, letterSpacing: 2),),
                                      trailingIcon: Icon(Icons.attach_money_rounded, color: appColor),
                                      onPressed: (){
                                        setState(() {
                                          paymentMethod3 = "Espèces";
                                        });
                                      }),
                                  FocusedMenuItem(title: Text("Carte Bancaire",style: TextStyle(color: appColor, letterSpacing: 2),),
                                      trailingIcon: Icon(Icons.credit_card, color: appColor),onPressed: (){
                                        setState(() {
                                          paymentMethod3 = "Carte Bancaire";
                                        });
                                      }),
                                  FocusedMenuItem(title: Text("Bonus 10",style: TextStyle(color: appColor, letterSpacing: 2),),
                                      trailingIcon: Icon(Icons.star, color: pointColor),
                                      onPressed: (){
                                        setState(() {
                                          paymentMethod3 = "Bonus 10";
                                          if(!onClick2){
                                            setState(() {
                                              restController.text = "10";
                                              secondChange = double.parse(restController.text) + change;
                                              validateChange = secondChange;
                                            });
                                          }else{
                                            setState(() {
                                              thirdRestController.text = "10";
                                              finalChange = double.parse(thirdRestController.text) + secondChange;
                                              validateChange = finalChange;
                                            });
                                          }
                                        });
                                      }),
                                  FocusedMenuItem(title: Text("Bonus 13",style: TextStyle(color: appColor, letterSpacing: 2),),
                                      trailingIcon: Icon(Icons.star, color: pointColor),
                                      onPressed: (){
                                        setState(() {
                                          paymentMethod3 = "Bonus 13";
                                        });
                                        if(!onClick2){
                                          setState(() {
                                            restController.text = "13";
                                            secondChange = double.parse(restController.text) + change;
                                            validateChange = secondChange;
                                          });
                                        }else{
                                          setState(() {
                                            thirdRestController.text = "13";
                                            finalChange = double.parse(thirdRestController.text) + secondChange;
                                            validateChange = finalChange;
                                          });
                                        }
                                      }),
                                  FocusedMenuItem(title: Text("Bonus 15",style: TextStyle(color: appColor, letterSpacing: 2),),
                                      trailingIcon: Icon(Icons.star, color: pointColor),
                                      onPressed: (){
                                        setState(() {
                                          paymentMethod3 = "Bonus 15";
                                        });
                                        if(!onClick2){
                                          setState(() {
                                            restController.text = "15";
                                            secondChange = double.parse(restController.text) + change;
                                            validateChange = secondChange;
                                          });
                                        }else{
                                          setState(() {
                                            thirdRestController.text = "15";
                                            finalChange = double.parse(thirdRestController.text) + secondChange;
                                            validateChange = finalChange;
                                          });
                                        }
                                      }),
                                ],
                                child: Icon(Icons.keyboard_arrow_down, color: Palette.background),
                              ),
                            ],
                          )
                      ),
                    ]
                  ]
              ) : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("$due €", style: TextStyle(fontSize: 80)),
                  Text("Veuillez sélectionner une méthode de paiement", style: TextStyle(fontSize: 15)),
                ],
              )
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectPaymentMethod ?
              Container(
                  height: MediaQuery.of(context).size.height / 2,
                  /*decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),*/
                  width: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width / 3 : MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(!onClick) {
                                  _myController.text += "1";
                                  change = double.parse(_myController.text) - due;
                                  validateChange = change;
                                }
                                else{
                                  if(onClick2){
                                    thirdRestController.text += "1";
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                    validateChange = finalChange;
                                  }else{
                                    restController.text += "1";
                                    secondChange = double.parse(restController.text) + change;
                                    validateChange = secondChange;
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Text('1', style: TextStyle(fontSize: 20))),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(!onClick) {
                                  _myController.text += "2";
                                  change = double.parse(_myController.text) - due;
                                  validateChange = change;
                                }else{
                                  if(onClick2){
                                    thirdRestController.text += "2";
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                    validateChange = finalChange;
                                  }else{
                                    restController.text += "2";
                                    secondChange = double.parse(restController.text) + change;
                                    validateChange = secondChange;
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Text('2', style: TextStyle(fontSize: 20))),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(!onClick) {
                                  _myController.text += "3";
                                  change = double.parse(_myController.text) - due;
                                  validateChange = change;
                                }else{
                                  if(onClick2){
                                    thirdRestController.text += "3";
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                    validateChange = finalChange;
                                  }else{
                                    restController.text += "3";
                                    secondChange = double.parse(restController.text) + change;
                                    validateChange = secondChange;
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Text('3', style: TextStyle(fontSize: 20))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(!onClick) {
                                  _myController.text += "4";
                                  change = double.parse(_myController.text) - due;
                                  validateChange = change;
                                }
                                else{
                                  if(onClick2){
                                    thirdRestController.text += "4";
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                    validateChange = finalChange;
                                  }else{
                                    restController.text += "4";
                                    secondChange = double.parse(restController.text) + change;
                                    validateChange = secondChange;
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Text('4', style: TextStyle(fontSize: 20))),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(!onClick) {
                                  _myController.text += "5";
                                  change = double.parse(_myController.text) - due;
                                  validateChange = change;
                                }
                                else{
                                  if(onClick2){
                                    thirdRestController.text += "5";
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                    validateChange = finalChange;
                                  }else{
                                    restController.text += "5";
                                    secondChange = double.parse(restController.text) + change;
                                    validateChange = secondChange;
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Text('5', style: TextStyle(fontSize: 20))),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(!onClick) {
                                  _myController.text += "6";
                                  change = double.parse(_myController.text) - due;
                                  validateChange = change;
                                }
                                else{
                                  if(onClick2){
                                    thirdRestController.text += "6";
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                    validateChange = finalChange;
                                  }else{
                                    restController.text += "6";
                                    secondChange = double.parse(restController.text) + change;
                                    validateChange = secondChange;
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Text('6', style: TextStyle(fontSize: 20))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(!onClick) {
                                  _myController.text += "7";
                                  change = double.parse(_myController.text) - due;
                                  validateChange = change;
                                }
                                else{
                                  if(onClick2){
                                    thirdRestController.text += "7";
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                    validateChange = finalChange;
                                  }else{
                                    restController.text += "7";
                                    secondChange = double.parse(restController.text) + change;
                                    validateChange = secondChange;
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Text('7', style: TextStyle(fontSize: 20))),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(!onClick) {
                                  _myController.text += "8";
                                  change = double.parse(_myController.text) - due;
                                  validateChange = change;
                                }
                                else{
                                  if(onClick2){
                                    thirdRestController.text += "8";
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                    validateChange = finalChange;
                                  }else{
                                    restController.text += "8";
                                    secondChange = double.parse(restController.text) + change;
                                    validateChange = secondChange;
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Text('8', style: TextStyle(fontSize: 20))),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(!onClick) {
                                  _myController.text += "9";
                                  change = double.parse(_myController.text) - due;
                                  validateChange = change;
                                }
                                else{
                                  if(onClick2){
                                    thirdRestController.text += "9";
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                    validateChange = finalChange;
                                  }else{
                                    restController.text += "9";
                                    secondChange = double.parse(restController.text) + change;
                                    validateChange = secondChange;
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Text('9', style: TextStyle(fontSize: 20))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              if(!onClick) {
                                if(_myController.text.isNotEmpty) {
                                  setState(() {
                                    _myController.text = _myController.text
                                        .substring(0, _myController.text.length - 1);
                                    change = double.parse(_myController.text) - due;
                                    validateChange = change;
                                  });
                                }else{
                                  setState(() {
                                    change = 0;
                                  });
                                }
                              }
                              else{
                                if(onClick2){
                                  if(thirdRestController.text.isNotEmpty) {
                                    setState(() {
                                      thirdRestController.text = thirdRestController.text
                                          .substring(0, thirdRestController.text.length - 1);
                                    });
                                  }else{
                                    setState(() {
                                      finalChange = 0;
                                    });
                                  }
                                  setState(() {
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                    validateChange = finalChange;
                                  });
                                }else{
                                  if(restController.text.isNotEmpty) {
                                    setState(() {
                                      restController.text = restController.text
                                          .substring(0, restController.text.length - 1);
                                    });
                                  }else{
                                    setState(() {
                                      secondChange = 0;
                                    });
                                  }
                                }
                                setState(() {
                                  secondChange = double.parse(restController.text) + change;
                                  validateChange = secondChange;
                                });
                              }
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Icon(Icons.backspace_outlined)),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(!onClick) {
                                  _myController.text += "0";
                                  change = double.parse(_myController.text) - due;
                                  validateChange = change;
                                }
                                else{
                                  if(onClick2){
                                    thirdRestController.text += "0";
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                    validateChange = finalChange;
                                  }else{
                                    restController.text += "0";
                                    secondChange = double.parse(restController.text) + change;
                                    validateChange = secondChange;
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Text('0', style: TextStyle(fontSize: 20))),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(!onClick) {
                                  _myController.text += ".";
                                  change = double.parse(_myController.text) - due;
                                }
                                else{
                                  if(onClick2){
                                    thirdRestController.text += ".";
                                    finalChange = double.parse(thirdRestController.text) + secondChange;
                                  }else{
                                    restController.text += ".";
                                    secondChange = double.parse(restController.text) + change;
                                  }
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appColor),
                                  color: background
                              ),
                              child: Center(child: Text(',', style: TextStyle(fontSize: 30))),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              if(onClick){
                                setState(() {
                                  onClick2 = true;
                                });
                              }else{
                                setState(() {
                                  onClick = true;
                                });
                              }
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: validateColor,
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Center(child: Text("OK", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 25))),
                            ),
                          ),
                          if(_myController.text.isNotEmpty)
                            InkWell(
                              onTap: (){
                                setState(() {
                                  selectPaymentMethod = false;
                                  change = 0;
                                  validateChange = -1;
                                  onClick = false;
                                  onClick2 = false;
                                  _myController.clear();
                                  restController.clear();
                                  thirdRestController.clear();
                                });
                              },
                              child: Container(
                                width: 160,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: inactive,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Center(child: Text("Annuler", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 25))),
                              ),
                            ),
                        ],
                      )
                    ],
                  )
              ) : Container(
                height: MediaQuery.of(context).size.height / 2,
                width: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width / 3 : MediaQuery.of(context).size.width / 2,
                color: background,
              ),
              if(Responsive.isDesktop(context))
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    color: background,
                  ),
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/man.png"),
                                )
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(client,style: TextStyle(color: appColor, fontSize: 20)),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.star, color: pointColor,size: 30),
                          SizedBox(width: 10),
                          Text("Points",style: TextStyle(color: appColor, fontSize: 20)),
                          Spacer(),
                          Text("8",style: TextStyle(color: CupertinoColors.systemRed, fontSize: 20)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/trophy (1).png"),fit: BoxFit.contain
                                )
                            ),
                          ),
                          SizedBox(width: 10),
                          Text("Bonus",style: TextStyle(color: appColor, fontSize: 20)),
                          Spacer(),
                          Text("2",style: TextStyle(color: CupertinoColors.systemRed, fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                )
            ],
          ),
        ],
      )
    );
  }
}
