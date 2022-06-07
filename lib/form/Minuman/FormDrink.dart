import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:warung_test/details/Minuman/minuman.dart';

class FormDrinkCategory extends StatefulWidget {
  @override
  State<FormDrinkCategory> createState() => _FormDrinkCategoryState();
}

class _FormDrinkCategoryState extends State<FormDrinkCategory> {
  final formkey = GlobalKey<FormState>();

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

  final TextEditingController namaMinumanController = TextEditingController();
  final TextEditingController hargaMinumanController = TextEditingController();
  final TextEditingController stockMinumanController = TextEditingController();

  Future CreateFormEat() async {
    var data = {"namaMinuman" : namaMinumanController.text, "hargaMinuman" : hargaMinumanController.text, "stockMinuman" : stockMinumanController.text};
    formkey.currentState!.validate();
    http.Response response = await http.post(Uri.http("10.0.2.2", "latihan_iv/minuman/addMinuman.php"),
        body: jsonEncode(data), headers: {"Accept" : "application/json"});
    final message = json.decode(response.body);
    if (message == "data telah ditambahkan"){
      formkey.currentState!.save();
      print("Status Code : ${response.statusCode.toInt().toString()}");
      print("Message : ${response.body.toString()}");
      print("Header : ${response.headers.length.toString()}");
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>Minuman()));
    }else{
      print("Status Code : ${response.statusCode.toInt().toString()}");
      formkey.currentState!.reset();
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>FormDrinkCategory()));
    }
  }

  Widget NamaMinumanBox(){
    return TextFormField(
      controller: namaMinumanController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      maxLength: 255,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, fontStyle: FontStyle.normal, color: Colors.white),
        labelText: "Nama Product Minuman",
        hintText: "Tuliskan nama Product Minuman Warung",
        suffixIcon: Icon(Icons.local_drink, color: Colors.white),
        isDense: true,
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

  Widget HargaMinumanBox(){
    return TextFormField(
      controller: hargaMinumanController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      maxLength: 13,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, fontStyle: FontStyle.normal, color: Colors.white),
        labelText: "Harga Product Minuman",
        hintText: "Tuliskan Harga Product Minuman Warung",
        suffixIcon: Icon(Icons.payment, color: Colors.white),
        isDense: true,
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

  Widget StockMinumanBox(){
    return TextFormField(
      controller: stockMinumanController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      maxLength: 13,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, fontStyle: FontStyle.normal, color: Colors.white),
        labelText: "Stock Product Minuman",
        hintText: "Tuliskan Stock Product Minuman Warung",
        suffixIcon: Icon(Icons.score, color: Colors.white),
        isDense: true,
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

  Widget FormCategoryEat(){
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 35),
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(15.0), child: NamaMinumanBox()),
              Padding(padding: EdgeInsets.all(15.0), child: HargaMinumanBox()),
              Padding(padding: EdgeInsets.all(15.0), child: StockMinumanBox()),
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
        title: Text("Form Create Drink",
          style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, fontFamily: "Times New Roman"),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueAccent,
      body: FormCategoryEat(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: TextButton(
          child: Text("SELESAI", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 18, fontWeight: FontWeight.bold)),
          onPressed: (){
            CreateFormEat();
          },
        ),
      ),
    );
  }
}
