import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:warung_test/Lobby.dart';
import 'package:warung_test/model/model.dart';

class ProfileAccount extends StatefulWidget {
  @override
  State<ProfileAccount> createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  late Future<List<Registeration>> register;

  Future<void> _onRefreshAccount() async {
    setState(() {
      register = AccountEditor();
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
    register = AccountEditor();
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

  bool isLoading = false;
  bool _HidePassword = false;

  void _onHidePasswordVisibility(){
    setState(() {
      _HidePassword = !_HidePassword;
    });
  }

  final list = [];
  Future<List<Registeration>> AccountEditor() async {
    list.clear();
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.http("10.0.2.2", "latihan_iv/register/getRegister.php"));
    final items = jsonDecode(response.body).cast<Map<String, dynamic>>();
    List<Registeration> editaccount = items.map<Registeration>((json){
      return Registeration.fromJson(json);
    }).toList();
    setState(() {
      isLoading = false;
    });
    return editaccount;
  }

  _delete(String id) async {
    http.Response response = await http.post(Uri.http("10.0.2.2", "latihan_iv/register/deleteRegister.php"),
        body: {
          "id": id,
        });
    final message = jsonDecode(response.body);
    if (message == "Data berhasil dihapus") {
      debugPrint("Response : " + response.body);
      debugPrint("Status Code : " + (response.statusCode).toString());
      debugPrint("Headers : " + (response.headers.toString()));
      setState(() {
        _onRefreshAccount();
      });
    } else {
      print('Data tidak terhapus');
    }
    return jsonEncode(response.body);
  }

  Widget FormEditAccount(){
    return RefreshIndicator(
      onRefresh: _onRefreshAccount,
      child: Container(
        child: FutureBuilder(
          future: AccountEditor(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index){
                  Registeration register = snapshot.data![index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 39, left: 191),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            child: Icon(Icons.people, size: 50,),
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.5),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              label: Text(register.username.toString(),
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, fontStyle: FontStyle.normal)),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.5),
                          child: TextFormField(
                            obscureText: !_HidePassword,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              label: Text(register.password,
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, fontStyle: FontStyle.normal)),
                              border: OutlineInputBorder(),
                              suffixIcon: GestureDetector(
                                child: Icon(!_HidePassword ? Icons.visibility_off : Icons.visibility, size: 20, color: !_HidePassword ? Colors.grey : Colors.blue),
                                onTap: (){
                                  _onHidePasswordVisibility();
                                },
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(35),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>EditAccount(register: register, onRefreshAccount: _onRefreshAccount)));
                                },
                                child: Text("EDIT"),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(35),
                              child: TextButton(
                                onPressed: (){
                                  _delete(register.id);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeLobby())).ignore();
                                },
                                child: Text("DELETE"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Profile"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[700],
      body: FormEditAccount(),
    );
  }
}

class EditAccount extends StatefulWidget {
  Registeration register;
  VoidCallback onRefreshAccount;

  EditAccount({required this.register, required this.onRefreshAccount});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final formkey = GlobalKey<FormState>();
  bool _isHidePassword = false;
  bool _isHideRepassword = false;

  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController repassword;

  setUp(){
    username = TextEditingController(text: widget.register.username);
    password = TextEditingController(text: widget.register.password);
    repassword = TextEditingController(text: widget.register.repassword);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setUp();
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

  Future EditSaverForm() async {
    formkey.currentState!.validate();
    http.Response response = await http.post(Uri.http("10.0.2.2", "latihan_iv/register/editRegister.php"),
    body: {
      "username" : username.text,
      "password" : password.text,
      "repassword" : repassword.text,
      "id" : widget.register.id,
    });
    final message = json.decode(response.body);
    if (message == "Data berhasil ter-update"){
      formkey.currentState!.save();
      print("Status Code : ${response.statusCode.toInt().toString()}");
      print("Response : ${response.body.toString()}");
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>ProfileAccount()));
    }else{
      formkey.currentState!.reset();
      print("Status Code : ${response.statusCode.toInt().toString()}");
    }
    return jsonEncode(response.body);
  }

  void _onHidePasswordVisibility(){
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  void _onHideRepasswordVisibility(){
    setState(() {
      _isHideRepassword = !_isHideRepassword;
    });
  }

  Widget BoxEditUsername(){
    return TextFormField(
      controller: username,
      readOnly: true,
      maxLength: 255,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(2.0),
        ),
        labelText: "Username",
        labelStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
        isDense: true,
        suffixIcon: Icon(Icons.account_circle, size: 20, color: Colors.white),
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

  Widget BoxEditPassword(){
    return TextFormField(
      controller: password,
      obscureText: !_isHidePassword,
      keyboardType: TextInputType.visiblePassword,
      maxLength: 255,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(2.0),
        ),
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
        isDense: true,
        suffixIcon: GestureDetector(
          child: Icon(!_isHidePassword ? Icons.visibility_off : Icons.visibility, color: !_isHidePassword ? Colors.blueGrey : Colors.green, size: 18,),
          onTap: (){
            _onHidePasswordVisibility();
          },
        ),
      ),
      validator: (value){
        if (value!.length < 6){
          return "";
        }else{
          return null;
        }
      },
    );
  }

  Widget BoxEditRepassword(){
    return TextFormField(
      controller: repassword,
      obscureText: !_isHideRepassword,
      keyboardType: TextInputType.visiblePassword,
      maxLength: 255,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(2.0),
        ),
        labelText: "Repassword",
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
        isDense: true,
        suffixIcon: GestureDetector(
          child: Icon(!_isHideRepassword ? Icons.visibility_off : Icons.visibility, color: !_isHideRepassword ? Colors.blueGrey : Colors.green, size: 18,),
          onTap: (){
            _onHideRepasswordVisibility();
          },
        ),
      ),
      validator: (value){
        if (value!.length < 6){
          return "";
        }else{
          return null;
        }
      },
    );
  }

  Widget EditForm(){
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: BoxEditUsername(),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: BoxEditPassword(),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: BoxEditRepassword(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Account My Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Color.fromRGBO(135, 157, 105, 1),
      body: EditForm(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: TextButton(
          onPressed: () => EditSaverForm(),
          child: Text("EDIT SELESAI",
            style: TextStyle(fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

