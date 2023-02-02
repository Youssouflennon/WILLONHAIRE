
import 'dart:convert';

import 'package:admin/color_constants.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:page_transition/page_transition.dart';

import '../../responsive.dart';
import '../../widgets/app_button_widget.dart';
import '../../widgets/input_widget.dart';
//import '../main/main_screen.dart';
import '../main/main_screen.dart';
import 'components/slider_widget.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {

  const Login({
    Key? key
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));
  var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
      .chain(CurveTween(curve: Curves.ease));

  AnimationController? _animationController;

  var _isMoved = false;
  bool _obscureText = true;
  bool isSigninLoading = false;
  bool isSignupLoading = false;

  bool isChecked = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
  var server = "http://192.168.16.116:3000";
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Row(
            children: <Widget>[
              if(Responsive.isDesktop(context))
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                color: Colors.white,
                child: SliderWidget(),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width,
                color: backgroundColor,
                child: Center(
                  child: Card(
                    //elevation: 5,
                    color: Palette.Text,
                    child: Container(
                      padding: EdgeInsets.all(42),
                      width: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width / 3.6 : MediaQuery.of(context).size.width / 1.8,
                      height: MediaQuery.of(context).size.height/1.1,
                      child: Column(
                        children: <Widget>[
                          //Flexible(
                          //  child: _loginScreen(context),
                          //),
                          Flexible(
                            child: Stack(
                              children: [
                                SlideTransition(
                                  position:
                                      _animationController!.drive(tweenRight),
                                  child: Stack(
                                      fit: StackFit.loose,
                                      clipBehavior: Clip.none,
                                      children: [
                                        _loginScreen(context),
                                      ]),
                                ),
                                SlideTransition(
                                  position:
                                      _animationController!.drive(tweenLeft),
                                  child: Stack(
                                      fit: StackFit.loose,
                                      clipBehavior: Clip.none,
                                      children: [
                                        _registerScreen(context),
                                      ]),
                                ),
                              ],
                            ),
                          ),

                          //Flexible(
                          //  child: SlideTransition(
                          //    position: _animationController!.drive(tweenLeft),
                          //    child: Stack(
                          //        fit: StackFit.loose,
                          //        clipBehavior: Clip.none,
                          //        children: [
                          //          _registerScreen(context),
                          //        ]),
                          //  ),
                          //),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
   
   authentificat()async{
    var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('http://192.168.16.116:3000/api/v1/auth/authenticate'));
request.body = json.encode({
  "email": emailController.text,
  "password": passwordController.text,
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
   setState(() {
        isSigninLoading = false;
      });
      final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Succès',
                      message:
                      'Bienvenue M/Mme ${emailController.text}',
                      contentType: ContentType.success,
                    ),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                      Navigator.push(
                    context,
                    PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                        child: MainScreen()),
                  );
}
else {
    final error = await response.stream.bytesToString();
      var errorMessage = json.decode(error)["error"];
       setState(() {
        isSigninLoading=false;
      });
 final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Echec Authentification',
                      message: errorMessage,
                      contentType: ContentType.failure,
                    ),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
     
}

   }

   registerUser()async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$server/api/v1/auth/register'));
    request.body = json.encode({
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "gender": "MALE",
      "phone": "237698726972"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
  
      setState(() {
        isSigninLoading = false;
      });
      final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Succès',
                      message:
                      'Bienvenue M/Mme $firstNameController $lastNameController',
                      contentType: ContentType.success,
                    ),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                      Navigator.push(
                    context,
                    PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                        child: MainScreen()),
                  );
    }
    else {
      final error = await response.stream.bytesToString();
      var errorMessage = json.decode(error)["error"];
 final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'echec',
                      message: errorMessage,
                      contentType: ContentType.failure,
                    ),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
      setState(() {
        isSigninLoading=false;
      });
    }

  }
  Container _registerScreen(BuildContext context) {

    final signupFormKey = GlobalKey<FormState>();

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 0.0,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: signupFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/15),
              Text("Créer un Compte", style: TextStyle(color: Colors.blueGrey, fontSize: 25)),
              SizedBox(height: 30),
              InputWidget(
                kController: firstNameController,
                onSaved: (String? value) {},
                onChanged: (String? value) {},
                validator: (String? value) {
                  return (value != null && value.isEmpty)
                      ? 'field required!'
                      : null;
                },

                topLabel: "Nom",
                prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: 8.0),
              InputWidget(
                kController: lastNameController,
                onSaved: (String? value) {},
                onChanged: (String? value) {},
                validator: (String? value) {
                  return (value != null && value.isEmpty)
                      ? 'field required!'
                      : null;
                },

                topLabel: "Prénom",
                prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: 8.0),
              InputWidget(
                keyboardType: TextInputType.emailAddress,
                kController: emailController,
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                onChanged: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && !value.contains('@'))
                      ? 'Enter a valid email!'
                      : null;
                },

                topLabel: "Email",
                prefixIcon: Icon(Icons.email),
              ),
              SizedBox(height: 8.0),
              InputPasswordWidget(
                topLabel: "Mot de Passe",
                kController: passwordController,
                obscureText: _obscureText,
                hintText: "Enter Password",
                onSaved: (String? uPassword) {},
                onChanged: (String? value) {},
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return "field Required!";
                  }
                },
                prefixIcon: Icon(Icons.lock),
              ),
              SizedBox(height: 8.0),
              InputPasswordWidget(
                topLabel: "Confirmer Mot de Passe",
                obscureText: _obscureText,
                kController: confirmController,
                onSaved: (String? uPassword) {

                },
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return "field Required!";
                  }else if(value != passwordController.text){
                    return "Password do not match!";
                  }
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
              SizedBox(height: 24.0),
              AppButton(
                type: ButtonType.PRIMARY,
                text: "Soumetre",
                onPressed: () {
                  if (signupFormKey.currentState!.validate() && confirmController.text == passwordController.text) {
                    setState(() {
                      isSignupLoading = true;
                       registerUser();
                    });
                    /*MotionToast.info(
                      description:  Text("everything is OK! 👍", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                      height: 90,
                    ).show(context);*/
                  }
                  Navigator.push(
                    context,
                    PageTransition(type: PageTransitionType.fade,duration: const Duration(milliseconds: 500),
                        child: MainScreen()),
                  );
                }, loading: isSignupLoading,
              ),
              SizedBox(height: 24.0),
              Center(
                child: Wrap(
                  children: [
                    Text(
                      "Vous avez déjà un compte?",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w300, color: Colors.black)
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () {
                        if (_isMoved) {
                          _animationController!.reverse();
                        } else {
                          _animationController!.forward();
                        }
                        _isMoved = !_isMoved;
                      },
                      child: Text("Connexion",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w400, color: Colors.green)),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      )
    );
  }

  Container _loginScreen(BuildContext context) {

    final loginFormKey = GlobalKey<FormState>();

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 0.0,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/10),
              Text("Connexion", style: TextStyle(color: Colors.blueGrey, fontSize: 25)),
              SizedBox(height: 25),
              InputWidget(
                keyboardType: TextInputType.emailAddress,
                kController: emailController,
                onSaved: (String? value) {},
                onChanged: (String? value) {},
                validator: (String? value) {
                  return (value != null && !value.contains('@') || value!.isEmpty)
                      ? 'enter a valid email'
                      : null;
                },

                topLabel: "Email",
                prefixIcon: Icon(Icons.email),
              ),
              SizedBox(height: 8.0),
              InputPasswordWidget(
                topLabel: "Mot de Passe",
                obscureText: _obscureText,
                kController: passwordController,
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
              SizedBox(height: 24.0),
              AppButton(
                loading: isSigninLoading,
                type: ButtonType.PRIMARY,
                text: "Connexion",
                onPressed: () {
                  if (loginFormKey.currentState!.validate()) {
                    setState(() {
                      isSigninLoading = true;
                     authentificat();
                    });
                  }
                  
                
                },
              ),
              SizedBox(height: 24.0),
              Wrap(
                runAlignment: WrapAlignment.spaceEvenly,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Wrap(
                    runAlignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        value: isChecked,
                        activeColor: Colors.blueAccent,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text("Se souvenir de moi",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w300, color: Colors.black)
                      )
                    ],
                  ),
                  if (Responsive.isDesktop(context))
                    SizedBox(width: 20),
                  if (Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Mot de passe oublié?",
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.green),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              if(Responsive.isDesktop(context))
              Center(
                child: Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Vous n'avezz pas encore de compte?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w300, color: Colors.black),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () {
                        if (_isMoved) {
                          _animationController!.reverse();
                        } else {
                          _animationController!.forward();
                        }
                        _isMoved = !_isMoved;
                      },
                      child: Text("Créer un compte",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w400, color: Colors.green)),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      )
    );
  }

  void authenticateUser() async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://saas24.shintheo.com:7000/email/validation'));
    request.body = json.encode({
      "email": emailController.text
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(await response.stream.bytesToString());
      setState(() {
        isSigninLoading = false;
      });

      showDialog(
          context: context,
          builder: (_) {

            bool isCodeLoading = false;

            return AlertDialog(
                title: Center(
                  child: Text("Vérification en 2 étapes",
                      style: TextStyle(color: appColor, fontSize: 20, letterSpacing: 1, fontWeight: FontWeight.bold)),
                ),
                content: Container(
                  color: Palette.Text,
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                            "An email with a validation code has been sent to ${emailController.text}",
                            style: TextStyle(color: appColor, fontSize: 15, letterSpacing: 1)),
                        Text(
                            "Please enter the code below",
                            style: TextStyle(color: appColor, fontSize: 15, letterSpacing: 1)),
                        SizedBox(
                          height: 16,
                        ),
                        InputWidget(
                          kController: emailController,
                          hintText: "email",
                          onSaved: (String? uPassword) {},
                          onChanged: (String? value) {},
                          validator: (String? value) {},
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InputWidget(
                          kController: codeController,
                          hintText: "Enter Code here",
                          onSaved: (String? uPassword) {},
                          onChanged: (String? value) {},
                          validator: (String? value) {},
                          prefixIcon: Icon(Icons.code, color: Colors.white),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                                icon: Icon(
                                  Icons.close,
                                  size: 14,
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                label: Text("Cancel")),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton.icon(
                                icon: !isCodeLoading ? Icon(
                                  Icons.check, color: Colors.white,
                                  size: 14,
                                ) : SizedBox(),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                                onPressed: () {
                                  setState(() {
                                    if(codeController.text.isNotEmpty) {
                                      setState(() {
                                        isCodeLoading = true;
                                      });
                                      verifyCode(emailController.text, isCodeLoading);
                                    }else{
                                      MotionToast.info(
                                        description:  Text("Please enter the code", style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                        width:  300,
                                        height: 90,
                                      ).show(context);
                                    }
                                  });
                                },
                                label: isCodeLoading ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1.5,
                                    )) : Text("Confirm"))
                          ],
                        )
                      ],
                    ),
                  )
                ));
          });
    }else if(response.statusCode == 500){
      final info = await response.stream.bytesToString();
      setState(() {
        isSigninLoading = false;
      });
      if(json.decode(info)['message'] == "A validation code was already sent to you less than 24 hours ago"){
        showDialog(
            context: context,
            builder: (_) {

              bool isCodeLoading = false;

              return AlertDialog(
                  title: Center(
                    child: Text("Vérification en 2 étapes",
                        style: TextStyle(color: appColor, fontSize: 20, letterSpacing: 1, fontWeight: FontWeight.bold)),
                  ),
                  content: Container(
                      color: Palette.Text,
                      padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                                "${json.decode(info)["message"]}",
                                style: TextStyle(color: appColor, fontSize: 15, letterSpacing: 1)),
                            Text(
                                "Please enter the code below",
                                style: TextStyle(color: appColor, fontSize: 15, letterSpacing: 1)),
                            SizedBox(
                              height: 16,
                            ),
                            InputWidget(
                              kController: emailController,
                              hintText: "email",
                              onSaved: (String? uPassword) {},
                              onChanged: (String? value) {},
                              validator: (String? value) {},
                              prefixIcon: Icon(Icons.email, color: Colors.white),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            InputWidget(
                              kController: codeController,
                              hintText: "Enter Code here",
                              onSaved: (String? uPassword) {},
                              onChanged: (String? value) {},
                              validator: (String? value) {},
                              prefixIcon: Icon(Icons.code, color: Colors.white),
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                    icon: Icon(
                                      Icons.close,
                                      size: 14,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.grey),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    label: Text("Cancel")),
                                SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton.icon(
                                    icon: !isCodeLoading ? Icon(
                                      Icons.check, color: Colors.white,
                                      size: 14,
                                    ) : SizedBox(),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                    onPressed: () {
                                      setState(() {
                                        if(codeController.text.isNotEmpty) {
                                          setState(() {
                                            isCodeLoading = true;
                                          });
                                          verifyCode(emailController.text, isCodeLoading);
                                        }else{
                                          MotionToast.info(
                                            description:  Text("Please enter the code", style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                            width:  300,
                                            height: 90,
                                          ).show(context);
                                        }
                                      });
                                    },
                                    label: isCodeLoading ? SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 1.5,
                                        )) : Text("Confirm"))
                              ],
                            )
                          ],
                        ),
                      )
                  ));
            });
      }
      else if(json.decode(info)["message"] == "This email is already validated"){
        Navigator.pop(context);
      }
      else{
        setState(() {
          isSigninLoading = false;
        });
        MotionToast.error(
          description: Text(json.decode(info)["message"], style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold)),
          height: 90,
        ).show(context);
      }
    }
    else {
      final error = await response.stream.bytesToString();
      setState(() {
        isSigninLoading = false;
      });
        MotionToast.error(
          description: Text(json.decode(error)["message"], style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold)),
          height: 90,
        ).show(context);
    }
  }

  void verifyCode(String email, bool isCodeLoading) async{

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('PATCH', Uri.parse('http://saas24.shintheo.com:7000/email/validation'));
    request.body = json.encode({
      "email": email,
      "code": codeController.text
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      //final answer = await response.stream.bytesToString();
      setState(() {
        isCodeLoading = false;
      });
      MotionToast.success(
        description:  Text("👍 Validation Successful", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
        height: 90,
        width: 300,
      ).show(context);

      Navigator.pop(context);
    }
    else {
      setState(() {
        isCodeLoading = false;
      });
      print(response.reasonPhrase);
      final error = await response.stream.bytesToString();
      MotionToast.error(
        description:  Text(json.decode(error)["message"], style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold)),
        height: 90,
      ).show(context);
    }
  }
}
