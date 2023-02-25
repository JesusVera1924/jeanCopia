import 'dart:convert';

import 'package:pedidos_en_linea/api/solicitud_api.dart';
import 'package:pedidos_en_linea/model/app_webc.dart';
import 'package:pedidos_en_linea/model/app_webd.dart';
import 'package:pedidos_en_linea/model/carrito_bd.dart';
import 'package:pedidos_en_linea/model/modelview/carrito_view.dart';
import 'package:pedidos_en_linea/model/usuario.dart';
import 'package:pedidos_en_linea/services/local_storage.dart';
import 'package:pedidos_en_linea/util/util_view.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final textSearch = TextEditingController();
  final api = SolicitudApi();
  /* LISTA DE CONTIENE PRODUCTOS */
  List<CarritoView> listProductos = [];
  List<CarritoBd> carritoProduct = [];
  List<CarritoBd> carritoTemp = [];
  /* VALIDACIONES DE PRESENTACION DE OBJETOS */
  bool isShow = true;

  /* CAJA DE TEXTO */
  var focusColor = Color(0xD9b22222);
  /* VALORES */
  double iva = 0.00;
  double subtotal = 0.00;
  double total = 0.00;
  /* DIALOGO DE VISTA DE PRECIOS */
  double ivaDialog = 0.00;
  double subtotalDialog = 0.00;
  double totalDialog = 0.00;

  /* VALUES A TOMAR DE PRESENTACION */
  double totalU = 0.0;
  double totalP = 0.0;
  int countU = 0;
  int countP = 0;
/* OBTENECION DE ITEMS DEL CARRITO DEL USUARIO LOGEADO */

  var usuario =
      Usuario.fromMap(jsonDecode(LocalStorage.prefs.getString('usuario')!));

  getListItems() async {
    this.listProductos.clear();
    final resp = await api.getCarritoBd(usuario.codEmp, usuario.ctaUsr);
    carritoProduct = resp;
    updateValores();
    notifyListeners();
  }

/* OBTENCION DE ITEMS DEPENDIENDO SI SON NUEVOS O ESTAN EN OFERTA */
  getListNewItem(String value) async {
    this.listProductos.clear();
    final resp = await api.getNewItem(value);
    resp.forEach((element) {
      this.listProductos.add(CarritoView(
          cantidad: TextEditingController(text: "1"),
          estado: "",
          adi: "",
          item: element));
    });
    notifyListeners();
  }

/* OBTENCION DE ITEM EN GENERAL DEPENDIENDO EL FILTRO EN EL COMBO-BOX*/
  Future<bool> searchItems(String tipo) async {
    this.listProductos.clear();
    final resp =
        await api.getAllItems(textSearch.text.toUpperCase().trim(), tipo);
    resp.forEach((element) {
      this.listProductos.add(CarritoView(
          cantidad: TextEditingController(text: "1"),
          estado: "",
          adi: "",
          item: element));
    });
    focusColor = listProductos.isEmpty ? Color(0xD9b22222) : Colors.green;
    notifyListeners();
    return listProductos.isEmpty;
  }

/* AGREGAR EN CARRITO ITEM SELECCIONADO TANTO LOCAL COMO LA BASE DE DATOS*/
  addCart(String id, String estado) async {
    bool opt = false;

    this.carritoProduct.forEach((element) {
      if (element.codPro == id) {
        opt = true;
      }
    });

    if (!opt) {
      final stock = await api.getStock(id);
      final obj =
          this.listProductos.singleWhere((element) => element.item.item == id);

      if (double.parse(obj.cantidad.text) <= double.parse(stock)) {
        final objBd = CarritoBd(
            idc: 0,
            codEmp: usuario.codEmp,
            codUsr: usuario.ctaUsr,
            codPro: obj.item.item,
            nomPro: obj.item.nItem,
            notPro: '',
            canMov: double.parse(obj.cantidad.text),
            pvuMov: obj.item.precio,
            fecMov: DateTime.now().toIso8601String(),
            nexMov: carritoProduct.length,
            fexMov: DateTime.now().toIso8601String(),
            stsMov: estado);

        carritoProduct.add(objBd);
        api.postCart(objBd);
        updateValores();
        notifyListeners();
        UtilView.messageAccess('Item Agregado');
      } else {
        UtilView.messageDanger('SIN STOCK [$stock]');
      }
    } else {
      UtilView.messageDanger('Item repetido');
    }
  }

/* BORRAR ITEM DEL CARRITO TANTO LOCAL COMO LA BASE DE DATOS */
  deleteCart(CarritoBd carrito) {
    api.deleteCartItem(carrito.codEmp, carrito.codUsr, carrito.codPro);
    carritoProduct.remove(carrito);
    carritoTemp.remove(carrito);
    updateValores();
    notifyListeners();
  }

/* ACTUALIZAR ITEM DEL CARRITO TANTO LOCAL COMO LA BASE DE DATOS */
  updateValores() {
    total = carritoProduct.fold(
        0.0,
        (prev, value) =>
            prev += value.stsMov == 'U' ? (value.pvuMov * value.canMov) : 0);
    subtotal = carritoProduct.fold(
        0.0,
        (prev, value) => prev +=
            value.stsMov == 'U' ? (value.pvuMov * value.canMov) / 1.12 : 0);

    iva = total - subtotal;
  }

/* ACTUALIZAR VALORES PARA EL DIALOGO de visualizacion de valores*/
  updateValoresDialog(String caso) {
    totalDialog = carritoProduct.fold(
        0.0,
        (prev, value) => value.stsMov == caso
            ? prev += (value.pvuMov * value.canMov)
            : prev += 0);

    subtotalDialog = carritoProduct.fold(
        0.0,
        (prev, value) => value.stsMov == caso
            ? prev += (value.pvuMov * value.canMov) / 1.12
            : prev += 0);

    ivaDialog = totalDialog - subtotalDialog;
    notifyListeners();
  }

/* GENERAR ORDEN DE PEDIDO DE SOLO LOS ITEM DEL CARRITO QUE ESTEN DE MANERA URGENTE */
  generarOrder() {
    List<AppwebD> listDetail = [];
    api.postOrderC(AppWebc(
        idc: 0,
        codEmp: usuario.codEmp,
        codRef: usuario.ctaUsr,
        nomRef: usuario.nomUsr,
        fecOrd: DateTime.now(),
        notOrd: '',
        totOrd: total,
        tpvOrd: 'P',
        ptoOrd: usuario.codEmp,
        usrOrd: usuario.ctaUsr,
        dacOrd: DateTime.now(),
        stsOrd: "P"));

    carritoProduct.forEach((element) {
      if (element.stsMov == "U") {
        listDetail.add(AppwebD(
            idd: 0,
            idc: 0,
            codEmp: usuario.codEmp,
            codRef: usuario.ctaUsr,
            codPro: element.codPro,
            nomPro: element.nomPro,
            notPro: element.notPro,
            canOrd: 0.0,
            pvaOrd: 0.0,
            pvuOrd: 0.0,
            pvtOrd: element.pvuMov,
            codMov: '',
            numMov: '',
            fecMov: DateTime.now(),
            canMov: element.canMov,
            pacMov: 0.0,
            totMov: 0.0,
            stsMov: element.stsMov));
      }
    });
    api.postOrderD(listDetail);
    api.deleteCartClear(usuario.codEmp, usuario.ctaUsr);
    clearUrgente();
    updateValores();
    notifyListeners();
  }

/*  */
  setIsShow(bool value) {
    this.isShow = value;
    notifyListeners();
  }

/* ACTUALIZAR CANTIDAD DEL ITEM SELECCIONADO TANTO LOCAL COMO EN LA BASE DE DATOS */
  updateCantidad(CarritoBd obj, double cantidad) async {
    final stock = await api.getStock(obj.codPro);

    if (cantidad <= double.parse(stock)) {
      carritoProduct.forEach((element) {
        if (element.codPro == obj.codPro) {
          element.canMov = cantidad;
        }
      });

      api.updateItemCant(
          '$cantidad', usuario.codEmp, usuario.ctaUsr, obj.codPro);
      updateValores();
      valueDialog();
      notifyListeners();
    } else {
      UtilView.messageDanger('SIN STOCK [$stock]');
    }
  }

/* ACTUALIZAR COMENTARIO DEL ITEM SELECCIONADO TANTO LOCAL COMO EN LA BASE DE DATOS */
  addInfo(String item, String value) {
    carritoProduct.forEach((element) {
      if (element.codPro == item) {
        element.notPro = value;
      }
    });
    api.updateItemInfo(value, usuario.codEmp, usuario.ctaUsr, item);
    notifyListeners();
  }

/* BORRA FILL LOS ELEMENTOS D ELA LISTA QUE ESTEN DE MANERA PENDIENTE */
  clearUrgente() {
    this.carritoProduct =
        this.carritoProduct.where((element) => element.stsMov != "P").toList();
  }

/* ACTUALIZAR ESTADO DEL ITEM SELECCIONADO TANTO LOCAL COMO EN LA BASE DE DATOS  */
  updateEstado(CarritoBd obj, String value) {
    carritoProduct.forEach((element) {
      if (element.codPro == obj.codPro) {
        element.stsMov = value;
      }
    });
    api.updateItemSts(value, usuario.codEmp, usuario.ctaUsr, obj.codPro);
    updateValores();
    notifyListeners();
  }

/* VERIFICAR LAS EXISTENCIAS DEL PRODUCTO  */
  bool checkExitencia(String id) {
    bool opt = false;

    this.carritoProduct.forEach((element) {
      if (element.codPro == id) {
        opt = true;
      }
    });

    return opt;
  }

/* Obtener dicstancias de cada una de las columnas de las tabla de producto */
  Future<List<double>> getPreference() async {
    List<double> opt = [];
    var resp = await api.getPreference('${usuario.ctaUsr}.txt');
    if (resp != "") {
      opt = [
        double.parse(resp.split('-')[0]),
        double.parse(resp.split('-')[1]),
        double.parse(resp.split('-')[2]),
        double.parse(resp.split('-')[3]),
        double.parse(resp.split('-')[4]),
        double.parse(resp.split('-')[5]),
        double.parse(resp.split('-')[6]),
        double.parse(resp.split('-')[7]),
      ];
    }
    return opt;
  }

/* Guardar distancia de items */
  void savePreference(double op0, double op1, double op2, double op3,
      double op4, double op5, double op6, double op7, double op8) async {
    String opt = "$op1-$op2-$op3-$op4-$op5-$op6-$op7-$op8";
    var resp = await api.savePreference(usuario.ctaUsr, opt);
    if (resp == "1") {
      UtilView.messageAccess('Preferencia de columna almacena');
    }
  }

/* Vizualizar el items de filtrado */
  void fillVisual() {
    carritoTemp = carritoProduct;
    valueDialog();
    notifyListeners();
  }

/* actualizar estatus en las listas filtradas */
  void fillStatus(String value) {
    fillVisual();
    carritoTemp =
        carritoTemp.where((element) => element.stsMov == value).toList();
    notifyListeners();
  }

/* Cambiar value del dialog por el estado dle item */
  void valueDialog() {
    totalU = carritoProduct.fold(
        0.0,
        (prev, value) =>
            prev += value.stsMov == 'U' ? (value.pvuMov * value.canMov) : 0);
    totalP = carritoProduct.fold(
        0.0,
        (prev, value) =>
            prev += value.stsMov == 'P' ? (value.pvuMov * value.canMov) : 0);

    countP = carritoProduct
        .where((element) => element.stsMov == "P")
        .toList()
        .length;
    countU = carritoProduct
        .where((element) => element.stsMov == "U")
        .toList()
        .length;
  }
}
