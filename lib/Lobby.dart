import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warung_test/details/MenuUtama.dart';
import 'package:warung_test/form/Registeration/FormCreate.dart';
import 'package:http/http.dart' as http;

class HomeLobby extends StatefulWidget {
  @override
  State<HomeLobby> createState() => _HomeLobbyState();
}

class _HomeLobbyState extends State<HomeLobby> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  final formkey = GlobalKey<FormState>();
  bool _HidePassword = false;

  void _onHidePassword() async {
    setState(() {
      _HidePassword = !_HidePassword;
    });
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future LoginAccount() async {
    var data = {"username" : usernameController.text, "password" : passwordController.text};
    formkey.currentState!.validate();
    http.Response response = await http.post(Uri.http("10.0.2.2", "latihan_iv/register/login.php"),
    body: json.encode(data), headers: {"Accept" : "application/json"});
    final message = json.decode(response.body);
    if (message == "Login Matched") {
      print("Status Code : ${response.statusCode.toInt().toString()}");
      print(response.body.toString());
      formkey.currentState!.save();
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>UtamaHome()));
    }else{
      formkey.currentState!.reset();
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>HomeLobby()));
    }
  }

  Widget usernameBox(){
    return TextFormField(
      controller: usernameController,
      maxLength: 255,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(12, 10, 10, 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.21, color: Colors.white38, style: BorderStyle.solid),
        ),
        labelText: "Username",
        labelStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        isDense: true,
        suffixIcon: Icon(Icons.account_circle, size: 18, color: Colors.blue),
      ),
      validator: (value){
        if (value!.isEmpty){
          return "Tidak boleh kosong";
        }else{
          return null;
        }
      },
    );
  }

  Widget passwordBox(){
    return TextFormField(
      controller: passwordController,
      obscureText: !_HidePassword,
      keyboardType: TextInputType.text,
      maxLength: 255,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(12, 10, 10, 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.21, color: Colors.white38, style: BorderStyle.solid),
        ),
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        isDense: true,
        suffixIcon: GestureDetector(
          child: Icon(!_HidePassword ? Icons.visibility_off : Icons.visibility, color: !_HidePassword ? Colors.blueGrey : Colors.green, size: 18,),
          onTap: (){
            _onHidePassword();
          },
        ),
      ),
      validator: (value){
        if (value!.isEmpty){
          return "Tidak boleh kosong";
        }else{
          return null;
        }
      },
    );
  }

  Widget HomeLogin(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      padding: EdgeInsets.only(top: 100, left: 10.5, right: 10.5),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(158, 167, 135, 1),
            border: Border.all(width: 1.1, color: Colors.black, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Form(
            key: formkey,
            child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12.5),
                child: usernameBox(),
              ),
              Padding(
                padding: EdgeInsets.all(12.5),
                child: passwordBox(),
              ),
              Padding(
                padding: EdgeInsets.all(27.1),
                child: TextButton(
                  child: Text("Login Menu",
                    style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, fontSize: 19, letterSpacing: 1, wordSpacing: 3,
                    color: Colors.black, backgroundColor: Colors.white38),
                  ),
                  onPressed: (){
                    LoginAccount();
                    },
                  ),
                ),
              TextButton(
                child: Text("Exit", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 23, fontWeight: FontWeight.bold)),
                onPressed: (){
                  exit(0);
                },
              ),
              Padding(
                padding: EdgeInsets.all(11),
                child: TextButton(
                  child: Text("Created Account Warung Test",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, fontStyle: FontStyle.italic, color: Colors.white70),
                  ),
                  onPressed: (){
                    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>AccountForm()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warung Tester", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      body: HomeLogin(),
    );
  }
}
