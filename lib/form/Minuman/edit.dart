import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warung_test/details/Minuman/minuman.dart';
import 'package:warung_test/model/model.dart';
import 'package:http/http.dart' as http;

class EditDrink extends StatefulWidget {
  ProductMinuman productMinuman;
  VoidCallback onRefreshMinuman;

  EditDrink({required this.productMinuman, required this.onRefreshMinuman});

  @override
  State<EditDrink> createState() => _EditDrinkState();
}

class _EditDrinkState extends State<EditDrink> {
  final formkey = GlobalKey<FormState>();

  late TextEditingController namaMinuman;
  late TextEditingController hargaMinuman;
  late TextEditingController stockMinuman;

  setUp(){
    namaMinuman = TextEditingController(text: widget.productMinuman.namaMinuman);
    hargaMinuman = TextEditingController(text: widget.productMinuman.hargaMinuman);
    stockMinuman = TextEditingController(text: widget.productMinuman.stockMinuman);
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
    http.Response response = await http.post(Uri.http("10.0.2.2", "latihan_iv/minuman/editMinuman.php"),
        body: {
          "namaMinuman" : namaMinuman.text,
          "hargaMinuman" : hargaMinuman.text,
          "stockMinuman" : stockMinuman.text,
          "id" : widget.productMinuman.id,
        });
    final message = json.decode(response.body);
    if (message == "Data telah berhasil di update"){
      formkey.currentState!.save();
      print("Status Code : ${response.statusCode.toInt().toString()}");
      print("Response : ${response.body.toString()}");
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>Minuman()));
    }else{
      formkey.currentState!.reset();
      print("Status Code : ${response.statusCode.toInt().toString()}");
    }
    return jsonEncode(response.body);
  }

  Widget BoxEditNamaMinuman(){
    return TextFormField(
      controller: namaMinuman,
      readOnly: true,
      maxLength: 255,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(2.0),
        ),
        labelText: "Nama Product Minuman",
        labelStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
        isDense: true,
        suffixIcon: Icon(Icons.local_drink, size: 20, color: Colors.white),
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

  Widget BoxEditHargaMinuman(){
    return TextFormField(
      controller: hargaMinuman,
      keyboardType: TextInputType.number,
      maxLength: 13,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(2.0),
          ),
          labelText: "Harga Product Minuman",
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
          isDense: true,
          suffixIcon: Icon(Icons.payment, size: 20, color: Colors.white)
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

  Widget BoxEditStockMinuman(){
    return TextFormField(
      controller: stockMinuman,
      keyboardType: TextInputType.number,
      maxLength: 13,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(2.0),
          ),
          labelText: "Stock Product Minuman",
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
          isDense: true,
          suffixIcon: Icon(Icons.score, size: 20, color: Colors.white)
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
                child: BoxEditNamaMinuman(),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: BoxEditHargaMinuman(),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: BoxEditStockMinuman(),
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
        title: Text("Edit Drink My Warung Test",
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