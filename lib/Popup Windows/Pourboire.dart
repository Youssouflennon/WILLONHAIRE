import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

import '../color_constants.dart';
import '../models/InterfacePOS.dart';
import '../num_pad.dart';

class Pourboire extends StatefulWidget {
  const Pourboire({Key? key}) : super(key: key);

  @override
  State<Pourboire> createState() => _PourboireState();
}

class _PourboireState extends State<Pourboire> {

  final TextEditingController _myController = TextEditingController();

  final box = Hive.box("myBox");

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: Color(0xFFE5F0FA),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              height: 70,
              child: Center(
                  child: TextFormField(
                    controller: _myController,
                    textAlign: TextAlign.center,
                    showCursor: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Palette.background
                    ),
                    style: const TextStyle(fontSize: 40),
                    // Disable the default soft keybaord
                    keyboardType: TextInputType.none,
                  )),
            ),
          ),
          // implement the custom NumPad
          NumPad(
            buttonSize: 75,
            buttonColor: Colors.white,
            iconColor: Colors.blueGrey,
            controller: _myController,
            delete: () {
              _myController.text = _myController.text
                  .substring(0, _myController.text.length - 1);
            },
            // do something with the input numbers
            onSubmit: () {
              debugPrint('Your code: ${_myController.text}');
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Text(
                      "You code is ${_myController.text}",
                      style: const TextStyle(fontSize: 30),
                    ),
                  ));
            },
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  if(_myController.text.isNotEmpty) {
                    box.put("getPourboire", _myController.text);
                    Navigator.push(
                      context,
                      PageTransition(type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 500),
                          child: InterfacePOS()),
                    );
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 8,
                  height: 50,
                  decoration: BoxDecoration(
                    color: validateColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Center(child: Text("OK", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 15))),
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 8,
                  height: 50,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Center(child: Text("ANNULER", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 15))),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
