import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../color_constants.dart';
import '../../controllers/animatonFadeIn.dart';
import '../../responsive.dart';
import 'Drawer_windows/location_drawer.dart';
import 'package:http/http.dart' as http;

class Location extends StatefulWidget {

  const Location({
    Key? key
  }) : super(key: key);

  @override
  State<Location> createState() => LocationState();

}

class LocationState extends State<Location>{
  List location = [];

  @override
  void initState() {
   
    super.initState();
    initializedPages();
  }

  initializedPages()async{
    getAllLocation();
    location = await getAllLocation();
    print(location);
  }

  Future getAllLocation()async{
    var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('GET', Uri.parse('http://192.168.16.116:3000/api/v1/locations'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  final data=await response.stream.bytesToString();
  return json.decode(data);

}
else {
  print(response.reasonPhrase);
}

  }

  final List<String> services = [
    'ADULT',
    'ADO',
    'ENFANT'
  ];
 
  String? selectedService;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FadeIn(delay: 50, child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      color: background,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Palette.background,
            child: Row(
              children: [
                Text("Emplacements", style: TextStyle(color: appColor, fontSize: 20),),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: background,
                  child: Center(
                    child: Text("2"),
                  ),
                ),
                SizedBox(width: 10),
                Text("Total", style: TextStyle(color: Colors.grey, fontSize: 20),),
                Spacer(flex: 2),
                ElevatedButton.icon(onPressed: (){
                  showDialog(
                    context: context,
                    builder: (_) {
                      return LocationDrawer();
                    },
                  );
                }, icon: Icon(Icons.add), label: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("Ajouter un Emplacement"),
                ))
              ],
            ),
          ),
          SizedBox(height: 3),
          Container(
              padding: EdgeInsets.only(left: 30,top: 10, right: 30),
              height: MediaQuery.of(context).size.height - 180,
              color: Palette.background,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: 40,
                          child: TextFormField(
                            //controller: dateController,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.only(top: 10),
                              fillColor: background,
                              prefixIcon: Icon(Icons.search),
                              hintText: "Rechercher un emplacement",
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
                      if (!Responsive.isMobile(context))
                        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonPadding: EdgeInsets.only(left: 10),
                          buttonWidth: MediaQuery.of(context).size.width / 4,
                          buttonHeight: 40,
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: background,
                          ),
                          hint: Text(
                            'Tous les services',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),
                          ),
                          items: services
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ))
                              .toList(),
                          value: selectedService,
                          onChanged: (value) {
                            setState(() {
                              selectedService = value as String;
                            });
                          },
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          itemHeight: 40,
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonPadding: EdgeInsets.only(left: 10),
                          buttonWidth: MediaQuery.of(context).size.width / 6,
                          buttonHeight: 40,
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: background,
                          ),
                          hint: Text(
                            'Trier par',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),
                          ),
                          items: services
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ))
                              .toList(),
                          value: selectedService,
                          onChanged: (value) {
                            setState(() {
                              selectedService = value as String;
                            });
                          },
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          itemHeight: 40,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: ListView(
                        children: [
                          buildLocations(context)
                        ],
                      )
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
  
  Widget buildLocations(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height - 80,
      padding: EdgeInsets.only(top: 30, left: 5, right: 5),
      child: GridView.builder(
          itemCount: location.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 130.0, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    color: Palette.background,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        color: Colors.blue
                      ),
                      child: Center(
                        child: Text(location[index]["pictureFullPath"], style: TextStyle(color: Palette.background, fontSize: 20)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 150,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(location[index]["name"], style: TextStyle(color: appColor, fontSize: 15)),
                            )
                        ),

                        Row(
                          children: [
                            Icon(Icons.location_pin, color: Colors.grey, size: 15,),
                            Container(
                              padding: EdgeInsets.all(5),
                              width: 150,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(location[index]["address"],overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey, fontSize: 13)),
                              )
                            )
                          ],
                        ),
                        Text(location[index]["phone"], style: TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                    Spacer(flex: 2),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Text("Modifier", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
                    ),
                  ],
                )
            );
          }
      ),
    );
  }
}
