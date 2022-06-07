import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warung_test/model/model.dart';

class PaymentFood extends StatefulWidget {
  ProductMakanan productMakanan;

  PaymentFood({required this.productMakanan});

  @override
  State<PaymentFood> createState() => _PaymentFoodState();
}

class _PaymentFoodState extends State<PaymentFood> {

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

  double cash = 0;
  double total = 0;
  int _counter = 0;

  void _incerementCounter(){
    setState(() {
      _counter++;
    });
  }

  void minIncerementCounter(){
    setState(() {
      _counter--;
    });
  }

  Widget _ViewPaymentFood(){
    return Builder(
      builder: (BuildContext context){
        return SingleChildScrollView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 150),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Icon(Icons.fastfood, size: 30, color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 35, 10, 10),
                  child: Expanded(
                    child: Text("Nama Product Makanan : ${widget.productMakanan.namaMakanan.toString()}", style: TextStyle(
                      fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white,
                    )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
                  child: Expanded(
                    child: Text("Harga Product Makanan : ${widget.productMakanan.hargaMakanan.toString()}", style: TextStyle(
                      fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white,
                    )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Center(
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: _incerementCounter,
                            tooltip: "Incerement",
                            child: Icon(Icons.add),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(12,0,12,0),
                            child: Text("${_counter}", style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                          FloatingActionButton(
                            onPressed: minIncerementCounter,
                            tooltip: "Incerement Minize",
                            child: Icon(Icons.minimize),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        TextButton(
                        onPressed: (){
                          print("${null}");
                        },
                          child: Text("Pembayaran",
                          style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white,
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi Fast Food Warung Test"),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue[700],
      body: _ViewPaymentFood(),
    );
  }
}
