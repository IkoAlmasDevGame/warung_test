import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:warung_test/details/Makanan/makanan.dart';

class FormEatCategory extends StatefulWidget {
  @override
  State<FormEatCategory> createState() => _FormEatCategoryState();
}

class _FormEatCategoryState extends State<FormEatCategory> {
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

  final TextEditingController namaMakananController = TextEditingController();
  final TextEditingController hargaMakananController = TextEditingController();
  final TextEditingController stockMakananController = TextEditingController();


  Future CreateFormEat() async {
    var data = {"namaMakanan" : namaMakananController.text, "hargaMakanan" : hargaMakananController.text, "stockMakanan" : stockMakananController.text};
    formkey.currentState!.validate();
    http.Response response = await http.post(Uri.http("10.0.2.2", "latihan_iv/makanan/addMakanan.php"),
        body: jsonEncode(data), headers: {"Accept" : "application/json"});
    final message = json.decode(response.body);
    if (message == "data telah ditambahkan"){
      formkey.currentState!.save();
      print("Status Code : ${response.statusCode.toInt().toString()}");
      print("Message : ${response.body.toString()}");
      print("Header : ${response.headers.length.toString()}");
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>Makanan()));
    }else{
      print("Status Code : ${response.statusCode.toInt().toString()}");
      formkey.currentState!.reset();
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>FormEatCategory()));
    }
  }

  Widget NamaMakananBox(){
    return TextFormField(
      controller: namaMakananController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      maxLength: 255,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, fontStyle: FontStyle.normal, color: Colors.white),
        labelText: "Nama Product Makanan",
        hintText: "Tuliskan nama Product Makanan Warung",
        suffixIcon: Icon(Icons.fastfood, color: Colors.white),
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

  Widget HargaMakananBox(){
    return TextFormField(
      controller: hargaMakananController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      maxLength: 13,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, fontStyle: FontStyle.normal, color: Colors.white),
        labelText: "Harga Product Makanan",
        hintText: "Tuliskan Harga Product Makanan Warung",
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

  Widget StockMakananBox(){
    return TextFormField(
      controller: stockMakananController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      maxLength: 13,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, fontStyle: FontStyle.normal, color: Colors.white),
        labelText: "Stock Product Makanan",
        hintText: "Tuliskan Stock Product Makanan Warung",
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
              Padding(padding: EdgeInsets.all(15.0), child: NamaMakananBox()),
              Padding(padding: EdgeInsets.all(15.0), child: HargaMakananBox()),
              Padding(padding: EdgeInsets.all(15.0), child: StockMakananBox()),
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
        title: Text("Form Create Eat",
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
