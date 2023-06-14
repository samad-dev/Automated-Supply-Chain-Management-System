import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:asms/Constants/ColorConstants.dart';
import 'package:asms/Constants/PicConstants.dart';
import 'package:asms/Screens/fluidBtmNav.dart';
import 'package:asms/Widgets.dart/loginSignupTextField.dart';
import 'package:asms/model/loginModel.dart';
import 'package:flutter/material.dart';

class Myloginpage extends StatefulWidget {
  Myloginpage({super.key});

  @override
  State<Myloginpage> createState() => _MyloginpageState();
}

class _MyloginpageState extends State<Myloginpage> {
  TextEditingController email = TextEditingController();
  bool pass = false;
  TextEditingController password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(PicConstants.cnergicoLogo),
              height: 70,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Cnergyico',
              style: TextStyle(
                  color: Color(ColorConstants.drkGreen1),
                  fontSize: 40,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Login",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: <Widget>[
                LoginTextField(
                  hint: 'Email or Phone Number',
                  cont: email,
                  hide: false,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    obscureText: pass,
                    controller: password,
                    cursorColor: Color(ColorConstants.drkGreen1),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(ColorConstants.drkGreen1)),
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                        hintText: 'Password',
                      suffixIcon: IconButton(
                    icon: Icon(
                    pass
                    ? Icons.visibility
                      : Icons.visibility_off,
                      color: Color(ColorConstants.drkGreen1),
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        pass = !pass;
                      });
                    },
                  ),
                    ),

                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(ColorConstants.drkGreen1)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                _getData(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: 200,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(ColorConstants.drkGreen1)),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<LoginModel>> _getData(context) async {
    var url = Uri.parse(
        'http://151.106.17.246:8080/byco/api/asmslogin.php?accesskey=12345&email=${email.text.toString()}&pass=${password.text.toString()}');
    print(url);
    var client = http.Client();
    var response = await client.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse.length);
      if (jsonResponse.length > 0) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email.text.toString());
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FluidBottomNav()));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Incorrect Credentials',
                  style: TextStyle(color: Colors.red,),
                ),
                content: Text('The email or password you entered is incorrect. Try again!'),
                actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Ok', style: TextStyle(color: Color(ColorConstants.drkGreen1)),))],
              );
            });
      }
      return jsonResponse.map((data) => LoginModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
