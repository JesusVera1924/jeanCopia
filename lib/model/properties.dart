// To parse this JSON data, do
//
//     final Properties = PropertiesFromMap(jsonString);
import 'dart:convert';

class Properties {
  Properties({
    required this.codEmp,
    required this.codPro,
    required this.etiL01,
    required this.etiL02,
    required this.etiL03,
    required this.etiL04,
    required this.etiL05,
    required this.etiL06,
    required this.etiL07,
    required this.etiL08,
    required this.etiL09,
    required this.etiL10,
    required this.stsL99,
  });

  String codEmp;
  String codPro;
  String etiL01;
  String etiL02;
  String etiL03;
  String etiL04;
  String etiL05;
  String etiL06;
  String etiL07;
  String etiL08;
  String etiL09;
  String etiL10;
  String stsL99;

  factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        codEmp: json["cod_emp"],
        codPro: json["cod_pro"],
        etiL01: json["eti_l01"],
        etiL02: json["eti_l02"],
        etiL03: json["eti_l03"],
        etiL04: json["eti_l04"],
        etiL05: json["eti_l05"],
        etiL06: json["eti_l06"],
        etiL07: json["eti_l07"],
        etiL08: json["eti_l08"],
        etiL09: json["eti_l09"],
        etiL10: json["eti_l10"],
        stsL99: json["sts_l99"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_pro": codPro,
        "eti_l01": etiL01,
        "eti_l02": etiL02,
        "eti_l03": etiL03,
        "eti_l04": etiL04,
        "eti_l05": etiL05,
        "eti_l06": etiL06,
        "eti_l07": etiL07,
        "eti_l08": etiL08,
        "eti_l09": etiL09,
        "eti_l10": etiL10,
        "sts_l99": stsL99,
      };
}
