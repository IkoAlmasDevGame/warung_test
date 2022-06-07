import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warung_test/model/model.dart';

class DetailMakanan extends StatefulWidget {
  ProductMakanan productMakanan;

  DetailMakanan({required this.productMakanan});

  @override
  State<DetailMakanan> createState() => _DetailMakananState();
}

class _DetailMakananState extends State<DetailMakanan> {
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

  Widget _ProductDetailFood() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                    padding: EdgeInsets.only(top: 99),
                    child: Container(
                      height: MediaQuery.of(context).size.width - 100,
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.2, color: Colors.white, style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.fastfood,
                            size: 85, color: Colors.white)),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Divider(
                height: 1.8,
                thickness: 2.1,
                color: Colors.white,
              ),
            ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 25.5, 10, 10),
                    child: Expanded(
                      child: Text(
                          "ID Product Food : ${widget.productMakanan.id}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 12.5, 10, 10),
                    child: Expanded(
                      child: Text(
                          "Name Product Food : ${widget.productMakanan.namaMakanan}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 12.5, 10, 10),
                    child: Expanded(
                      child: Text(
                          "Price Product Food : ${widget.productMakanan.hargaMakanan}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 12.5, 10, 10),
                    child: Expanded(
                      child: Text(
                          "Stock Product Food : ${widget.productMakanan.stockMakanan}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal)),
                    ),
                  ),
            Divider(
              height: 1.4,
              thickness: 2.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Product Food"),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueAccent,
      body: _ProductDetailFood(),
    );
  }
}
