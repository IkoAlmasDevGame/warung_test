import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warung_test/details/Minuman/buy.dart';
import 'package:warung_test/details/Minuman/details.dart';
import 'package:warung_test/form/Minuman/FormDrink.dart';
import 'package:warung_test/form/Minuman/edit.dart';
import 'package:warung_test/model/model.dart';
import 'package:http/http.dart' as http;

class Minuman extends StatefulWidget {
  @override
  State<Minuman> createState() => _MinumanState();
}

class _MinumanState extends State<Minuman> {
  late Future<List<ProductMinuman>> productminuman;
  bool isLoading = false;

  Future <void> _onRefreshMinuman() async {
    setState(() {
      productminuman = RefreshProductMinuman();
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
    productminuman = RefreshProductMinuman();
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
    http.Response response = await http.post(Uri.http("10.0.2.2", "latihan_iv/minuman/deleteMinuman.php"),
        body: {
          "id": id,
        });
    final message = jsonDecode(response.body);
    if (message == "Data berhasil dihapus") {
      debugPrint("Response : " + response.body);
      debugPrint("Status Code : " + (response.statusCode).toString());
      debugPrint("Headers : " + (response.headers.toString()));
      setState(() {
        _onRefreshMinuman();
      });
    } else {
      print('Data tidak terhapus');
    }
    return jsonEncode(response.body);
  }

  final list = [];
  Future<List<ProductMinuman>> RefreshProductMinuman() async {
    list.clear();
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.http("10.0.2.2", "latihan_iv/minuman/getMinuman.php"),
        headers: {"Content-Type" : "application/json"});
    final items = jsonDecode(response.body).cast<Map<String, dynamic>>();
    List<ProductMinuman> product = items.map<ProductMinuman>((json){
      return ProductMinuman.fromJson(json);
    }).toList();
    setState(() {
      isLoading = false;
    });
    return product;
  }

  Widget ListProductMakanan(){
    return RefreshIndicator(
      onRefresh: _onRefreshMinuman,
      child: Container(
        child: FutureBuilder(
          future: RefreshProductMinuman(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasData){
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index){
                  ProductMinuman productMinuman = snapshot.data![index];
                  return Card(
                    color: Colors.grey[400],
                    child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("ID Product Minuman : ${productMinuman.id.toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, fontStyle: FontStyle.normal)),
                          Text("Nama Minuman : ${productMinuman.namaMinuman.toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, fontStyle: FontStyle.normal)),
                          Text("Harga Minuman : ${productMinuman.hargaMinuman.toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, fontStyle: FontStyle.normal)),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.delete, size: 18, color: Colors.white),
                                  onPressed: (){
                                    _delete(productMinuman.id);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit, size: 18, color: Colors.white),
                                  onPressed: (){
                                    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>EditDrink(productMinuman: productMinuman, onRefreshMinuman: _onRefreshMinuman)));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.sell, size: 18, color: Colors.white),
                                  onPressed: (){
                                    Navigator.push(context, new MaterialPageRoute(builder: (context)=>PaymentDrink(productMinuman: productMinuman))).ignore();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailMinuman(productMinuman: productMinuman))).ignore();
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
        title: Text("- Product Minuman - Warung Test",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 16),
            onPressed: (){
              var Created = MaterialPageRoute(builder: (context)=>FormDrinkCategory());
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
