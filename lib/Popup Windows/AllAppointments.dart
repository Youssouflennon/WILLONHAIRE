import 'package:flutter/material.dart';

import '../color_constants.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            getAppBarUI(),
            Card(
              color: Palette.background,
              elevation: 5,
              margin: EdgeInsets.fromLTRB(32, 32, 64, 32),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text("All Appointments"),
                        ),
                      ],
                    )
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget getAppBarUI() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        color: Colors.lightBlueAccent.withOpacity(0.7),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)
                )
              ),
            ),
            Expanded(
              child: Center(
                child: Text('All Appointments',
                    overflow: TextOverflow.ellipsis,
                    style:
                    TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20, letterSpacing: 2)),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
