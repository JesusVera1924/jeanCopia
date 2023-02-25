import 'dart:convert';

class AppWebc {
    AppWebc({
        required this.idc,
        required this.codEmp,
        required this.codRef,
        required this.nomRef,
        required this.fecOrd,
        required this.notOrd,
        required this.totOrd,
        required this.tpvOrd,
        required this.ptoOrd,
        required this.usrOrd,
        required this.dacOrd,
        required this.stsOrd,
    });

    int idc;
    String codEmp;
    String codRef;
    String nomRef;
    DateTime fecOrd;
    String notOrd;
    double totOrd;
    String tpvOrd;
    String ptoOrd;
    String usrOrd;
    DateTime dacOrd;
    String stsOrd;

    factory AppWebc.fromJson(String str) => AppWebc.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AppWebc.fromMap(Map<String, dynamic> json) => AppWebc(
        idc: json["idc"],
        codEmp: json["cod_emp"],
        codRef: json["cod_ref"],
        nomRef: json["nom_ref"],
        fecOrd: DateTime.parse(json["fec_ord"]),
        notOrd: json["not_ord"],
        totOrd: json["tot_ord"].toDouble(),
        tpvOrd: json["tpv_ord"],
        ptoOrd: json["pto_ord"],
        usrOrd: json["usr_ord"],
        dacOrd: DateTime.parse(json["dac_ord"]),
        stsOrd: json["sts_ord"],
    );

    Map<String, dynamic> toMap() => {
        "idc": idc,
        "cod_emp": codEmp,
        "cod_ref": codRef,
        "nom_ref": nomRef,
        "fec_ord": "${fecOrd.year.toString().padLeft(4, '0')}-${fecOrd.month.toString().padLeft(2, '0')}-${fecOrd.day.toString().padLeft(2, '0')}",
        "not_ord": notOrd,
        "tot_ord": totOrd,
        "tpv_ord": tpvOrd,
        "pto_ord": ptoOrd,
        "usr_ord": usrOrd,
        "dac_ord": "${dacOrd.year.toString().padLeft(4, '0')}-${dacOrd.month.toString().padLeft(2, '0')}-${dacOrd.day.toString().padLeft(2, '0')}",
        "sts_ord": stsOrd,
    };
}
