import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warung_test/details/Makanan/makanan.dart';
import 'package:warung_test/model/model.dart';
import 'package:http/http.dart' as http;

class EditFood extends StatefulWidget {
  ProductMakanan productMakanan;
  VoidCallback onRefreshMakanan;

  EditFood({required this.productMakanan, required this.onRefreshMakanan});

  @override
  State<EditFood> createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  final formkey = GlobalKey<FormState>();

  late TextEditingController namaMakanan;
  late TextEditingController hargaMakanan;

  setUp(){
    namaMakanan = TextEditingController(text: widget.productMakanan.namaMakanan);
    hargaMakanan = TextEditingController(text: widget.productMakanan.hargaMakanan);
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
    http.Response response = await http.post(Uri.http("10.0.2.2", "latihan_iv/makanan/editMakanan.php"),
        body: {
          "namaMakanan" : namaMakanan.text,
          "hargaMakanan" : hargaMakanan.text,
          "id" : widget.productMakanan.id,
        });
    final message = json.decode(response.body);
    if (message == "Data telah berhasil di update"){
      formkey.currentState!.save();
      print("Status Code : ${response.statusCode.toInt().toString()}");
      print("Response : ${response.body.toString()}");
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>Makanan()));
    }else{
      formkey.currentState!.reset();
      print("Status Code : ${response.statusCode.toInt().toString()}");
    }
    return jsonEncode(response.body);
  }

  Widget BoxEditNamaMakanan(){
    return TextFormField(
      controller: namaMakanan,
      readOnly: true,
      maxLength: 255,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(2.0),
        ),
        labelText: "Nama Product Makanan",
        labelStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
        isDense: true,
        suffixIcon: Icon(Icons.fastfood, size: 20, color: Colors.white),
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

  Widget BoxEditHargaMakanan(){
    return TextFormField(
      controller: hargaMakanan,
      keyboardType: TextInputType.number,
      maxLength: 255,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(2.0),
        ),
        labelText: "Harga Product Makanan",
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
                child: BoxEditNamaMakanan(),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: BoxEditHargaMakanan(),
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
        title: Text("Edit Food My Warung Test",
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