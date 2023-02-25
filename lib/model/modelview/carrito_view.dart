import 'package:pedidos_en_linea/model/item.dart';
import 'package:flutter/cupertino.dart';

class CarritoView {
  CarritoView({
    required this.cantidad,
    required this.estado,
    required this.adi,
    required this.item,
  });

  TextEditingController cantidad;
  String estado;
  String adi;
  Item item;
}
