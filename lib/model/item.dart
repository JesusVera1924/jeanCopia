import 'dart:convert';

class Item {
  Item({
    required this.grupo,
    required this.imagen,
    required this.inventario,
    required this.inventarioU,
    required this.item,
    required this.listado,
    required this.marca,
    required this.marcado,
    required this.nGrupo,
    required this.nItem,
    required this.nuevo,
    required this.precio,
    required this.vehiculo,
  });

  String grupo;
  String imagen;
  String inventario;
  String inventarioU;
  String item;
  String listado;
  String marca;
  String marcado;
  String nGrupo;
  String nItem;
  String nuevo;
  double precio;
  String vehiculo;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        grupo: json["grupo"],
        imagen: json["imagen"],
        inventario: json["inventario"],
        inventarioU: json["inventario_u"],
        item: json["item"],
        listado: json["listado"],
        marca: json["marca"],
        marcado: json["marcado"],
        nGrupo: json["n_grupo"],
        nItem: json["n_item"],
        nuevo: json["nuevo"],
        precio: json["precio"].toDouble(),
        vehiculo: json["vehiculo"],
      );

  Map<String, dynamic> toMap() => {
        "grupo": grupo,
        "imagen": imagen,
        "inventario": inventario,
        "inventario_u": inventarioU,
        "item": item,
        "listado": listado,
        "marca": marca,
        "marcado": marcado,
        "n_grupo": nGrupo,
        "n_item": nItem,
        "nuevo": nuevo,
        "precio": precio,
        "vehiculo": vehiculo,
      };
}
