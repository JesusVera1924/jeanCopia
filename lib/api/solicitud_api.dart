import 'dart:convert';
import 'package:pedidos_en_linea/model/alterno.dart';
import 'package:pedidos_en_linea/model/app_webc.dart';
import 'package:pedidos_en_linea/model/app_webd.dart';
import 'package:pedidos_en_linea/model/carrito_bd.dart';
import 'package:pedidos_en_linea/model/item.dart';
import 'package:pedidos_en_linea/model/properties.dart';
import 'package:pedidos_en_linea/model/ruta_img.dart';
import 'package:pedidos_en_linea/model/usuario.dart';
import 'package:http/http.dart' as http;

class SolicitudApi {
  /* String _urlBase = "www.cojapan.com.ec"; */
  String _urlBase = "localhost:8080";
  Future<Usuario> queryUsers(String code, String pass, String proyecto) async {
    Usuario dato;

    var url = Uri.https(_urlBase, '/contabilidad/loginUser', {
      'empresa': '01',
      'correo': code,
      'pass': pass,
      'proyecto': pass == '211213' ? 'A00' : proyecto
    });

    print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = Usuario.fromJson(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  Future<List<Item>> getAllItems(String value, String tipo) async {
    var url = Uri.https(
        _urlBase, '/contabilidad/getItems', {'value': value, 'tipo': tipo});

    print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToList(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Item>> getNewItem(String value) async {
    var url = Uri.http(_urlBase, '/contabilidad/getNewItem', {'value': value});

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToList(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future postCart(CarritoBd datos) async {
    var url = Uri.https(_urlBase, '/contabilidad/insertAppwebx');

    var data = datos.toJson();
    final resquet = await http.post(url, body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });

    if (resquet.statusCode != 200)
      throw Exception('Error de formulario,: ${resquet.statusCode}');
  }

  Future postOrderC(AppWebc datos) async {
    var url = Uri.https(_urlBase, '/contabilidad/insertAppwebc');

    var data = datos.toJson();
    try {
      final resquet = await http.post(url, body: data, headers: {
        "Content-type": "application/json;charset=UTF-8",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
      });

      if (resquet.statusCode != 200)
        throw Exception('Error de formulario,: ${resquet.statusCode}');
    } catch (e) {
      throw e;
    }
  }

  Future postOrderD(List<AppwebD> datos) async {
    List<Map> bod = [];
    var url = Uri.https(_urlBase, '/contabilidad/insertAppwebd');

    for (var element in datos) {
      bod.add(element.toMap());
    }
    var data = json.encode(bod);

    try {
      final resquet = await http.post(url, body: data, headers: {
        "Content-type": "application/json;charset=UTF-8",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
      });

      if (resquet.statusCode != 200)
        throw Exception('Error de formulario,: ${resquet.statusCode}');
    } catch (e) {
      throw e;
    }
  }

  Future<List<CarritoBd>> getCarritoBd(String value, String tipo) async {
    var url = Uri.https(_urlBase, '/contabilidad/getCarrito',
        {'empresa': value, 'usuario': tipo});
    print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseJsonToListCart(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<String> deleteCartItem(
      String empresa, String usuario, String value) async {
    String dato = "";

    var url = Uri.https(_urlBase, '/contabilidad/deleteItem',
        {'empresa': empresa, 'usuario': usuario, 'item': value});
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  Future<String> deleteCartClear(String empresa, String usuario) async {
    String dato = "";

    var url = Uri.https(_urlBase, '/contabilidad/deleteCarrito',
        {'empresa': empresa, 'usuario': usuario});
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  Future<String> updateItemCant(
      String cantidad, String empresa, String usuario, String item) async {
    String dato = "";

    var url = Uri.https(_urlBase, '/contabilidad/uploadCantidad', {
      'cantidad': cantidad,
      'empresa': empresa,
      'usuario': usuario,
      'item': item
    });

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  Future<String> updateItemSts(
      String estado, String empresa, String usuario, String item) async {
    String dato = "";

    var url = Uri.https(_urlBase, '/contabilidad/uploadSts', {
      'estado': estado,
      'empresa': empresa,
      'usuario': usuario,
      'item': item
    });

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  Future<String> updateItemInfo(
      String inforA, String empresa, String usuario, String item) async {
    String dato = "";

    var url = Uri.https(_urlBase, '/contabilidad/uploadInfo',
        {'info': inforA, 'empresa': empresa, 'usuario': usuario, 'item': item});

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  Future<List<Alterno>> getAlternos(String empresa, String item) async {
    List<Alterno> _list = [];
    var url = Uri.https(_urlBase, '/contabilidad/consultv2alterno',
        {'emp': empresa, 'pro': item});

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _list = parseJsonToListAlterno(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      throw 'Error en obtener los alternos: $e';
    }
    return _list;
  }

  Future<List<RutaImg>> getRutas(String empresa, String producto) async {
    try {
      List<RutaImg> _list = [];
      var url = Uri.https(_urlBase, '/contabilidad/getRouterImg',
          {'emp': empresa, 'pro': producto});

      final response = await http.get(url);

      if (response.statusCode == 200) {
        _list = parseJsonToListImg(response.body);
      }
      return _list;
    } catch (e) {
      throw 'Error al obtener lista de rutas: $e';
    }
  }

  Future<String> getBase64(String ruta) async {
    var url =
        Uri.https(_urlBase, '/contabilidad/getCodificado', {'data': ruta});

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('exception ' + response.statusCode.toString());
      }
    } catch (e) {
      throw 'Error al obtener imagen: $e';
    }
  }

  Future<Properties> getDetail(String producto) async {
    var dato;

    var url = Uri.https(_urlBase, '/contabilidad/getProperty',
        {'empresa': '01', 'proyecto': producto});

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = Properties.fromJson(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  Future<String> getStock(String item) async {
    var url = Uri.https(_urlBase, '/contabilidad/checkStock', {'item': item});

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('exception ' + response.statusCode.toString());
      }
    } catch (e) {
      throw 'Error al obtener stock: $e';
    }
  }

  Future<String> getPreference(String ruta) async {
    var url =
        Uri.https(_urlBase, '/contabilidad/getPreference', {'title': ruta});

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('exception ' + response.statusCode.toString());
      }
    } catch (e) {
      throw 'Error al obtener las prefrencia: $e';
    }
  }

  Future<String> savePreference(String ruta, String contenedor) async {
    var url = Uri.https(_urlBase, '/contabilidad/savePreference',
        {'title': ruta, 'contenedor': contenedor});

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('exception ' + response.statusCode.toString());
      }
    } catch (e) {
      throw 'Error al salvar las prefrencia: $e';
    }
  }

  Future<String> obtenerRuta(String ruta) async {
    var url = Uri.http(_urlBase, '/contabilidad/downloadImage', {'ruta': ruta});

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('exception ' + response.statusCode.toString());
      }
    } catch (e) {
      throw 'Error al obtener imagen: $e';
    }
  }

  List<RutaImg> parseJsonToListImg(String body) {
    var parse = jsonDecode(body);
    return parse.map<RutaImg>((json) => RutaImg.fromMap(json)).toList();
  }

  List<Alterno> parseJsonToListAlterno(String body) {
    var parse = jsonDecode(body);
    return parse.map<Alterno>((json) => Alterno.fromMap(json)).toList();
  }

  List<CarritoBd> parseJsonToListCart(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<CarritoBd>((json) => CarritoBd.fromMap(json)).toList();
  }

  List<Item> parseJsonToList(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Item>((json) => Item.fromMap(json)).toList();
  }
}
