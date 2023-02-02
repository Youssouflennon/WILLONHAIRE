import 'package:flutter/material.dart';

import '../../../../color_constants.dart';

class ExtraService extends StatefulWidget {

  const ExtraService({
    Key? key
  }) : super(key: key);

  @override
  State<ExtraService> createState() => ExtraServiceState();

}

class ExtraServiceState extends State<ExtraService>{

  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        color: Palette.background,
        child: Column(
          children: [

            InkWell(
              onTap: (){

              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.blue
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Ajouter un Extra", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 15))
                  ],
                ),
              )
            )
          ],
        )
    );
  }
}