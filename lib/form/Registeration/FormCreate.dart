import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warung_test/Lobby.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountForm extends StatefulWidget {
  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final formkey = GlobalKey<FormState>();

  bool _HidePassword = false;
  bool _HideRepassword = false;

  void _onHidePasswordVisibility(){
    setState(() {
      _HidePassword = !_HidePassword;
    });
  }

  void _onHideRepasswordVisibility(){
    setState(() {
      _HideRepassword = !_HideRepassword;
    });
  }

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

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  Future CreateAccount() async {
    var data = {"username" : usernameController.text, "password" : passwordController.text, "repassword" : repasswordController.text};
    formkey.currentState!.validate();
    http.Response response = await http.post(Uri.http("10.0.2.2", "latihan_iv/register/addRegister.php"),
    body: jsonEncode(data), headers: {"Accept" : "application/json"});
    final message = json.decode(response.body);
    if (message == "Data berhasil ditambah"){
      formkey.currentState!.save();
      print("Status Code : ${response.statusCode.toInt().toString()}");
      print("Message : ${response.body.toString()}");
      print("Header : ${response.headers.length.toString()}");
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>HomeLobby()));
    }else{
      print("Status Code : ${response.statusCode.toInt().toString()}");
      formkey.currentState!.reset();
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>AccountForm()));
    }
  }

  Widget usernameTextForm(){
    return TextFormField(
      controller: usernameController,
      maxLength: 255,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
        border: OutlineInputBorder(),
        labelText: "Username",
        labelStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        hintText: "Masukkan Username yang anda inginkan",
        isDense: true,
        suffixIcon: Icon(Icons.account_circle, size: 19, color: Colors.lightBlue),
      ),
      validator: (value){
        if (value!.isEmpty){
          return "";
        }else{
          return null;
        }
      },
    );
  }

  Widget passwordTextForm(){
    return TextFormField(
      controller: passwordController,
      obscureText: !_HidePassword,
      maxLength: 255,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(12, 10, 10, 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.21, color: Colors.white38, style: BorderStyle.solid),
        ),
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        hintText: "Masukkan Password anda",
        isDense: true,
        suffixIcon: GestureDetector(
          child: Icon(!_HidePassword ? Icons.visibility_off : Icons.visibility, color: !_HidePassword ? Colors.blueGrey : Colors.green, size: 18,),
          onTap: (){
            _onHidePasswordVisibility();
          },
        ),
      ),
      validator: (value){
        if (value!.length < 6 == value.toString()){
          return "Tidak boleh kurang dari 6 character";
        }else{
          return null;
        }
      },
    );
  }

  Widget repasswordTextForm(){
    return TextFormField(
      controller: repasswordController,
      obscureText: !_HideRepassword,
      maxLength: 255,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(12, 10, 10, 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.21, color: Colors.white38, style: BorderStyle.solid),
        ),
        labelText: "Repassword",
        labelStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        hintText: "Masukkan Repassword anda",
        isDense: true,
        suffixIcon: GestureDetector(
          child: Icon(!_HideRepassword ? Icons.visibility_off : Icons.visibility, color: !_HideRepassword ? Colors.blueGrey : Colors.green, size: 18,),
          onTap: (){
            _onHideRepasswordVisibility();
          },
        ),
      ),
      validator: (value){
        if (value!.length < 6 == value.toString()){
          return "Tidak boleh kurang dari 6 character";
        }else{
          return null;
        }
      },
    );
  }

  Widget FormAccount(){
    return SingleChildScrollView(
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
                padding: EdgeInsets.all(20),
                child: usernameTextForm(),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: passwordTextForm(),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: repasswordTextForm(),
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
        title: Text("Form Account Warung Test",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white38,
      body: FormAccount(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white38,
        child: TextButton(
          child: Text("SELESAI",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, fontFamily: "Arial",
            color: Colors.white),
          ),
          onPressed: (){
            CreateAccount();
          },
        ),
      ),
    );
  }
}
