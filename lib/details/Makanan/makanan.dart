import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warung_test/details/Makanan/buy.dart';
import 'package:warung_test/details/Makanan/details.dart';
import 'package:warung_test/form/Makanan/FormEat.dart';
import 'package:warung_test/form/Makanan/edit.dart';
import 'package:warung_test/model/model.dart';
import 'package:http/http.dart' as http;

class Makanan extends StatefulWidget {
  @override
  State<Makanan> createState() => _MakananState();
}

class _MakananState extends State<Makanan> {
  late Future<List<ProductMakanan>> productmakanan;
  bool isLoading = false;

  Future <void> _onRefreshMakanan() async {
    setState(() {
      productmakanan = RefreshProductMakanan();
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
    productmakanan = RefreshProductMakanan();
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

  _delete(String id) async{
    http.Response response = await http.post(Uri.http("10.0.2.2", "latihan_iv/makanan/deleteMakanan.php"),
        body: {
          "id": id,
        });
    final message = jsonDecode(response.body);
    if (message == "Data berhasil dihapus") {
      debugPrint("Response : " + response.body);
      debugPrint("Status Code : " + (response.statusCode).toString());
      debugPrint("Headers : " + (response.headers.toString()));
      setState(() {
        _onRefreshMakanan();
      });
    } else {
      print('Data tidak terhapus');
    }
    return jsonEncode(response.body);
  }

  final list = [];
  Future<List<ProductMakanan>> RefreshProductMakanan() async {
    list.clear();
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.http("10.0.2.2", "latihan_iv/makanan/getMakanan.php"),
    headers: {"Content-Type" : "application/json"});
    final items = jsonDecode(response.body).cast<Map<String, dynamic>>();
    List<ProductMakanan> product = items.map<ProductMakanan>((json){
      return ProductMakanan.fromJson(json);
    }).toList();
    setState(() {
      isLoading = false;
    });
    return product;
  }

  Widget ListProductMakanan(){
    return RefreshIndicator(
      onRefresh: _onRefreshMakanan,
      child: Container(
        child: FutureBuilder(
          future: RefreshProductMakanan(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasData){
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index){
                  ProductMakanan productMakanan = snapshot.data![index];
                  return Card(
                    color: Colors.grey[400],
                    child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("ID Product Makanan : ${productMakanan.id.toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, fontStyle: FontStyle.normal)),
                          Text("Nama Makanan : ${productMakanan.namaMakanan.toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, fontStyle: FontStyle.normal)),
                          Text("Harga Makanan : ${productMakanan.hargaMakanan.toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, fontStyle: FontStyle.normal)),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.delete, size: 18, color: Colors.white),
                                  onPressed: (){
                                    _delete(productMakanan.id);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit, size: 18, color: Colors.white),
                                  onPressed: (){
                                    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>EditFood(productMakanan: productMakanan, onRefreshMakanan: _onRefreshMakanan)));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.sell, size: 18, color: Colors.white),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentFood(productMakanan: productMakanan))).ignore();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailMakanan(productMakanan: productMakanan))).ignore();
                      },
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
        title: Text("- Product Makanan - Warung Test",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 16),
            onPressed: (){
              var Created = MaterialPageRoute(builder: (context)=>FormEatCategory());
              Navigator.pushReplacement(context, Created).ignore();
            },
          ),
        ],
        centerTitle: true,
      ),
      body: ListProductMakanan(),
      backgroundColor: Color.fromRGBO(100, 127, 99, 1),
    );
  }
}
