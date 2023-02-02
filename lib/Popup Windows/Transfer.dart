import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color_constants.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {

  int selectedIndex = 0;
  bool styleSelected = false;
  onSelected(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: [
            Text("Transférer la commande", style: TextStyle(color: appColor, fontSize: 30, letterSpacing: 2, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Sélectionnez le coiffeur à qui transferer la commande",textAlign: TextAlign.center, style: TextStyle(color: appColor, fontSize: 25, letterSpacing: 2)),

            SizedBox(height: 40),
            Expanded(
              child: GridView(
                padding: EdgeInsets.only(
                    top: 0, left: 12, right: 12),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: List<Widget>.generate(
                  4,
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
                                  onTap: (){
                                    setState(() {
                                      onSelected(index);
                                      styleSelected = !styleSelected;
                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/images/man.png"),
                                        fit: BoxFit.contain,
                                      ),

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
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: 1.5,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {

                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: 60,
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeGreen,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(child: Text("OK", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 30))),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: (){
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: 60,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(child: Text("ANNULER", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 30))),
                  ),
                )
              ],
            )
          ],
        )
      )
    );
  }
}
