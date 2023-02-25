import 'dart:convert';

class AppwebD {
  AppwebD({
    required this.idd,
    required this.idc,
    required this.codEmp,
    required this.codRef,
    required this.codPro,
    required this.nomPro,
    required this.notPro,
    required this.canOrd,
    required this.pvaOrd,
    required this.pvuOrd,
    required this.pvtOrd,
    required this.codMov,
    required this.numMov,
    required this.fecMov,
    required this.canMov,
    required this.pacMov,
    required this.totMov,
    required this.stsMov,
  });

  int idd;
  int idc;
  String codEmp;
  String codRef;
  String codPro;
  String nomPro;
  String notPro;
  double canOrd;
  double pvaOrd;
  double pvuOrd;
  double pvtOrd;
  String codMov;
  String numMov;
  DateTime fecMov;
  double canMov;
  double pacMov;
  double totMov;
  String stsMov;

  factory AppwebD.fromJson(String str) => AppwebD.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppwebD.fromMap(Map<String, dynamic> json) => AppwebD(
        idd: json["idd"],
        idc: json["idc"],
        codEmp: json["cod_emp"],
        codRef: json["cod_ref"],
        codPro: json["cod_pro"],
        nomPro: json["nom_pro"],
        notPro: json["not_pro"],
        canOrd: json["can_ord"].toDouble(),
        pvaOrd: json["pva_ord"].toDouble(),
        pvuOrd: json["pvu_ord"].toDouble(),
        pvtOrd: json["pvt_ord"].toDouble(),
        codMov: json["cod_mov"],
        numMov: json["num_mov"],
        fecMov: DateTime.parse(json["fec_mov"]),
        canMov: json["can_mov"].toDouble(),
        pacMov: json["pac_mov"].toDouble(),
        totMov: json["tot_mov"].toDouble(),
        stsMov: json["sts_mov"],
      );

  Map<String, dynamic> toMap() => {
        "idd": idd,
        "idc": idc,
        "cod_emp": codEmp,
        "cod_ref": codRef,
        "cod_pro": codPro,
        "nom_pro": nomPro,
        "not_pro": notPro,
        "can_ord": canOrd,
        "pva_ord": pvaOrd,
        "pvu_ord": pvuOrd,
        "pvt_ord": pvtOrd,
        "cod_mov": codMov,
        "num_mov": numMov,
        "fec_mov":
            "${fecMov.year.toString().padLeft(4, '0')}-${fecMov.month.toString().padLeft(2, '0')}-${fecMov.day.toString().padLeft(2, '0')}",
        "can_mov": canMov,
        "pac_mov": pacMov,
        "tot_mov": totMov,
        "sts_mov": stsMov,
      };
}
