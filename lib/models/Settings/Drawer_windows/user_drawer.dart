import 'package:admin/controllers/animation.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../color_constants.dart';
import '../../../widgets/input_widget.dart';

class UserDrawer extends StatefulWidget {

  const UserDrawer({
    Key? key
  }) : super(key: key);

  @override
  State<UserDrawer> createState() => UserDrawerState();
}

class UserDrawerState extends State<UserDrawer> {


  String? phoneNumber;
  bool onSaveLoading = false;
  int indexSelected = 0;
  bool _obscureText = true;
  String? roleValue;

  final List<String> roles = [
    'CLIENT',
    'EMPLOYEE',
    'MANAGER'
  ];
  /*@override
  void initState() {
    // TODO: implement initState
    categoryValue = category.elementAt(0);
    serviceValue = service.elementAt(0);
    placeValue = emplacements.elementAt(0);
    employeeValue = employee.elementAt(0);
    super.initState();
  }*/

  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(delay: 50,
        child: Container(
            width: MediaQuery.of(context).size.width / 3,
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.5, right: 0),
            child: Drawer(
                backgroundColor: Palette.background,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text("Nouvel Utilisateur", style: TextStyle(fontSize: 20)),
                          Spacer(flex: 2),
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          },
                              icon: Icon(Icons.close))
                        ],
                      ),
                      Divider(color: Colors.grey),
                      SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height - 150,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height:120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: background,
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/man.png')
                                  )
                              ),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    height:50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: background,
                                      border: Border.all(width: 3, color: Colors.white),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(onPressed: (){
                                      //imagePicker();
                                    },
                                        icon: Icon(Icons.photo_camera, size: 20, color: CupertinoColors.systemBlue,)
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 10),
                            InputWidget(
                              //kController: firstNameController,
                              onSaved: (String? value) {},
                              onChanged: (String? value) {},
                              validator: (String? value) {
                                return (value != null && value.isEmpty)
                                    ? 'field required!'
                                    : null;
                              },

                              topLabel: "Nom ",
                              prefixIcon: Icon(Icons.person),
                            ),
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

                              topLabel: "Prénom",
                              prefixIcon: Icon(Icons.person_pin_rounded),
                            ),
                            SizedBox(height: 10),
                            InputWidget(
                              //kController: firstNameController,
                              onSaved: (String? value) {},
                              onChanged: (String? value) {},
                              validator: (String? value) {
                                return (value != null && value.isEmpty)
                                    ? 'field required!'
                                    : null;
                              },

                              topLabel: "Email ",
                              prefixIcon: Icon(Icons.mail),
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Téléphone:"),
                                Container(
                                  width: double.infinity,
                                  height: 60,
                                  child: IntlPhoneField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: textFieldColor,
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(2),),
                                      contentPadding: EdgeInsets.only(top: 5, bottom: 5),
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      suffixIcon: Icon(Icons.phone_android_outlined),
                                    ),
                                    initialCountryCode: 'BE',
                                    onChanged: (phone) {
                                      phoneNumber = phone.completeNumber;
                                      //telController.text = phoneNumber;
                                    },
                                  ),
                                )
                              ],
                            ),
                            InputPasswordWidget(
                                topLabel: "Mot de Passe",
                                obscureText: _obscureText,
                                //kController: passwordController,
                                onSaved: (String? uPassword) {},
                                onChanged: (String? value) {},
                                validator: (String? value) {
                                  return (value != null && value.isEmpty)
                                      ? 'field required!'
                                      : null;
                                },
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                        _obscureText ? Icons.visibility : Icons.visibility_off
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    }
                                )
                            ),
                            SizedBox(height: 10),
                            InputPasswordWidget(
                                topLabel: "Confirmer le mot de Passe",
                                obscureText: _obscureText,
                                //kController: passwordController,
                                onSaved: (String? uPassword) {},
                                onChanged: (String? value) {},
                                validator: (String? value) {
                                  return (value != null && value.isEmpty)
                                      ? 'field required!'
                                      : null;
                                },
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                        _obscureText ? Icons.visibility : Icons.visibility_off
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    }
                                )
                            ),
                            SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Rôle: ", style: TextStyle(fontSize: 15)),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    buttonPadding: EdgeInsets.only(left: 10),
                                    buttonWidth: 150,
                                    buttonHeight: 40,
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),

                                      color: textFieldColor,
                                    ),
                                    hint: Text(
                                      'rôle',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme
                                            .of(context)
                                            .hintColor,
                                      ),
                                    ),
                                    items: roles
                                        .map((item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ))
                                        .toList(),
                                    value: roleValue,
                                    onChanged: (value) {
                                      setState(() {
                                        roleValue = value.toString();
                                      });
                                    },
                                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                                    itemHeight: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                          child: Row(
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
                                            )) : Text("Enregistrer"),
                                      )
                                  )
                              ),
                            ],
                          )
                      ),
                    ],
                  )
                )
            )
        )
    );
  }
}
