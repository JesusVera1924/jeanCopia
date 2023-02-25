import 'package:pedidos_en_linea/providers/auth_provider.dart';
import 'package:pedidos_en_linea/ui/views/dashboard_view.dart';
import 'package:fluro/fluro.dart';

import 'package:pedidos_en_linea/ui/views/login_view.dart';
import 'package:pedidos_en_linea/ui/views/register_view.dart';
import 'package:provider/provider.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return DashboardView();
  });

  static Handler register = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return RegisterView();
    else
      return DashboardView();
  });
}
