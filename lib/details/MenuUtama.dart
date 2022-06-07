import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warung_test/Lobby.dart';
import 'package:warung_test/details/Makanan/makanan.dart';
import 'package:warung_test/details/Minuman/minuman.dart';
import 'package:warung_test/form/Registeration/EditAccount.dart';
import 'package:warung_test/model/model.dart';

class UtamaHome extends StatefulWidget {
  @override
  State<UtamaHome> createState() => _UtamaHomeState();
}

class _UtamaHomeState extends State<UtamaHome> {
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

  Widget Category(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      padding: EdgeInsets.only(top: 150.1),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("CATEGORY WARUNG TEST", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 21, fontWeight: FontWeight.w700)),
            Padding(
              padding: EdgeInsets.only(top: 130.1, left: 13, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton.icon(
                    icon: Icon(Icons.fastfood, size: 18, color: Colors.white),
                    label: Text("MAKANAN", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, wordSpacing: 2)),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Makanan())).ignore();
                    },
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.local_drink, size: 18, color: Colors.white),
                    label: Text("MINUMAN", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, wordSpacing: 2)),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Minuman()));
                    },
                  ),
                ],
              ),
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
        title: Text("Menu Utama Warung Test",
            style: TextStyle(fontStyle: FontStyle.italic,
                fontSize: 19,
                fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[500],
      body: Category(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Pemilik Toko Warung Test",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 620.1),
              child: ListTile(
                trailing: Icon(Icons.edit),
                leading: Icon(Icons.arrow_forward),
                title: Text("Edit Account"),
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                          ProfileAccount()));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.1),
              child: ListTile(
                trailing: Icon(Icons.logout),
                title: Text("Logout"),
                leading: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (context) => HomeLobby()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
