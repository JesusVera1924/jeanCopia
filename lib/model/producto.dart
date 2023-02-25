// To parse this JSON data, do
//
//     final Producto = ProductoFromMap(jsonString);

import 'dart:convert';

class Producto {
    Producto({
        required this.canPro,
        required this.cdgPro,
        required this.codAlt,
        required this.codEmp,
        required this.codPro,
        required this.destaca,
        required this.exiPro,
        required this.facPro,
        required this.fcrPro,
        required this.fdsPro,
        required this.fofPro,
        required this.icePro,
        required this.imgPro,
        required this.ivaPro,
        required this.nmgPro,
        required this.nomNat,
        required this.nomPro,
        required this.pdsPro,
        required this.pofPro,
        required this.pvtPro,
        required this.smsPro,
        required this.stsPro,
        required this.subPro,
        required this.uacPro,
        required this.ucrPro,
    });

    int canPro;
    String cdgPro;
    String codAlt;
    String codEmp;
    String codPro;
    int destaca;
    dynamic exiPro;
    DateTime facPro;
    DateTime fcrPro;
    DateTime fdsPro;
    DateTime fofPro;
    String icePro;
    String imgPro;
    String ivaPro;
    String nmgPro;
    String nomNat;
    String nomPro;
    double pdsPro;
    double pofPro;
    double pvtPro;
    String smsPro;
    String stsPro;
    double subPro;
    String uacPro;
    String ucrPro;

    factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        canPro: json["can_pro"],
        cdgPro: json["cdg_pro"],
        codAlt: json["cod_alt"],
        codEmp: json["cod_emp"],
        codPro: json["cod_pro"],
        destaca: json["destaca"],
        exiPro: json["exi_pro"],
        facPro: DateTime.parse(json["fac_pro"]),
        fcrPro: DateTime.parse(json["fcr_pro"]),
        fdsPro: DateTime.parse(json["fds_pro"]),
        fofPro: DateTime.parse(json["fof_pro"]),
        icePro: json["ice_pro"],
        imgPro: json["img_pro"],
        ivaPro: json["iva_pro"],
        nmgPro: json["nmg_pro"],
        nomNat: json["nom_nat"],
        nomPro: json["nom_pro"],
        pdsPro: json["pds_pro"].toDouble(),
        pofPro: json["pof_pro"].toDouble(),
        pvtPro: json["pvt_pro"].toDouble(),
        smsPro: json["sms_pro"],
        stsPro: json["sts_pro"],
        subPro: json["sub_pro"].toDouble(),
        uacPro: json["uac_pro"],
        ucrPro: json["ucr_pro"],
    );

    Map<String, dynamic> toMap() => {
        "can_pro": canPro,
        "cdg_pro": cdgPro,
        "cod_alt": codAlt,
        "cod_emp": codEmp,
        "cod_pro": codPro,
        "destaca": destaca,
        "exi_pro": exiPro,
        "fac_pro": facPro.toIso8601String(),
        "fcr_pro": fcrPro.toIso8601String(),
        "fds_pro": fdsPro.toIso8601String(),
        "fof_pro": fofPro.toIso8601String(),
        "ice_pro": icePro,
        "img_pro": imgPro,
        "iva_pro": ivaPro,
        "nmg_pro": nmgPro,
        "nom_nat": nomNat,
        "nom_pro": nomPro,
        "pds_pro": pdsPro,
        "pof_pro": pofPro,
        "pvt_pro": pvtPro,
        "sms_pro": smsPro,
        "sts_pro": stsPro,
        "sub_pro": subPro,
        "uac_pro": uacPro,
        "ucr_pro": ucrPro,
    };
}
