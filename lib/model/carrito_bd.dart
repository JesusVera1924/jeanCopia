import 'dart:convert';

class CarritoBd {
  CarritoBd({
    required this.idc,
    required this.codEmp,
    required this.codUsr,
    required this.codPro,
    required this.nomPro,
    required this.notPro,
    required this.canMov,
    required this.pvuMov,
    required this.fecMov,
    required this.nexMov,
    required this.fexMov,
    required this.stsMov,
  });

  int idc;
  String codEmp;
  String codUsr;
  String codPro;
  String nomPro;
  String notPro;
  double canMov;
  double pvuMov;
  String fecMov;
  int nexMov;
  String fexMov;
  String stsMov;

  factory CarritoBd.fromJson(String str) => CarritoBd.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarritoBd.fromMap(Map<String, dynamic> json) => CarritoBd(
        idc: json["idc"],
        codEmp: json["cod_emp"],
        codUsr: json["cod_usr"],
        codPro: json["cod_pro"],
        nomPro: json["nom_pro"],
        notPro: json["not_pro"],
        canMov: json["can_mov"].toDouble(),
        pvuMov: json["pvu_mov"].toDouble(),
        fecMov: json["fec_mov"],
        nexMov: json["nex_mov"],
        fexMov: json["fex_mov"],
        stsMov: json["sts_mov"],
      );

  Map<String, dynamic> toMap() => {
        "idc": idc,
        "cod_emp": codEmp,
        "cod_usr": codUsr,
        "cod_pro": codPro,
        "nom_pro": nomPro,
        "not_pro": notPro,
        "can_mov": canMov,
        "pvu_mov": pvuMov,
        "fec_mov": fecMov,
        "nex_mov": nexMov,
        "fex_mov": fexMov,
        "sts_mov": stsMov,
      };
}
