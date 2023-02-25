// To parse this JSON data, do
//
//     final rutaImg = rutaImgFromMap(jsonString);

import 'dart:convert';

class RutaImg {
  RutaImg({
    required this.codEmp,
    required this.codPro,
    required this.galeria,
    required this.imgPro,
    required this.monitor,
  });

  String codEmp;
  String codPro;
  int galeria;
  String imgPro;
  int monitor;

  factory RutaImg.fromJson(String str) => RutaImg.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RutaImg.fromMap(Map<String, dynamic> json) => RutaImg(
        codEmp: json["cod_emp"],
        codPro: json["cod_pro"],
        galeria: json["galeria"],
        imgPro: json["img_pro"],
        monitor: json["monitor"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_pro": codPro,
        "galeria": galeria,
        "img_pro": imgPro,
        "monitor": monitor,
      };
}
