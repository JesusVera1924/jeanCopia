import 'dart:convert';

import 'package:pedidos_en_linea/model/usuario.dart';
import 'package:pedidos_en_linea/router/router.dart';
import 'package:pedidos_en_linea/services/local_storage.dart';
import 'package:pedidos_en_linea/services/navigation_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? cliente;

  AuthProvider() {
    this.isAuthenticated();
  }

  login(String email, String password, Usuario usuario) async {
    this._token = usuario.ctaUsr;
    this.cliente = usuario;
    LocalStorage.prefs.setString('token', this._token!);
    LocalStorage.prefs.setString('usuario', json.encode(usuario.toMap()));

    authStatus = AuthStatus.authenticated;
    notifyListeners();

    NavigationService.replaceTo(Flurorouter.dashboardRoute);
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    final user = LocalStorage.prefs.getString('usuario');

    if (user == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    cliente = Usuario.fromMap(jsonDecode(user));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }

  logout() {
    LocalStorage.prefs.remove('token');
    LocalStorage.prefs.remove('usuario');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
