class ProductMakanan {
  String id;
  String namaMakanan;
  String hargaMakanan;
  String stockMakanan;

  ProductMakanan({required this.id, required this.namaMakanan, required this.hargaMakanan, required this.stockMakanan});

  factory ProductMakanan.fromJson(Map<String, dynamic> json){
    return ProductMakanan(
      id: json['id'],
      namaMakanan: json['namaMakanan'],
      hargaMakanan: json['hargaMakanan'],
      stockMakanan: json['stockMakanan'],
    );
  }

  Map<String, dynamic> toJson() =>{
    "namaMakanan" : namaMakanan,
    "hargaMakanan" : hargaMakanan,
    "stockMakanan" : stockMakanan,
  };
}

class ProductMinuman {
  String id;
  String namaMinuman;
  String hargaMinuman;
  String stockMinuman;

  ProductMinuman({required this.id, required this.namaMinuman, required this.hargaMinuman, required this.stockMinuman});

  factory ProductMinuman.fromJson(Map<String, dynamic> json){
    return ProductMinuman(
      id: json['id'],
      namaMinuman: json['namaMinuman'],
      hargaMinuman: json['hargaMinuman'],
      stockMinuman: json['stockMinuman'],
    );
  }

  Map<String, dynamic> toJson()=>{
    "namaMinuman" : namaMinuman,
    "hargaMinuman" : hargaMinuman,
    "stockMinuman" : stockMinuman,
  };
}

class Registeration {
  String id;
  String username;
  String password;
  String repassword;

  Registeration({required this.id, required this.username, required this.password, required this.repassword});

  factory Registeration.fromJson(Map<String, dynamic> json){
    return Registeration(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      repassword: json['repassword']
    );
  }

  Map<String, dynamic> toJson()=>{
    "username" : username,
    "password" : password,
    "repasssword" : repassword
  };
}