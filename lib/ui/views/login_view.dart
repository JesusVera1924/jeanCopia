import 'package:pedidos_en_linea/api/solicitud_api.dart';
import 'package:pedidos_en_linea/providers/auth_provider.dart';
import 'package:pedidos_en_linea/providers/login_form_provider.dart';
import 'package:pedidos_en_linea/util/util_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pedidos_en_linea/ui/inputs/custom_inputs.dart';
import 'package:pedidos_en_linea/ui/buttons/custom_outlined_button.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final api = SolicitudApi();

    return ChangeNotifierProvider(
        create: (_) => LoginFormProvider(),
        child: Builder(builder: (context) {
          final loginFormProvider =
              Provider.of<LoginFormProvider>(context, listen: false);

          void sendLogin() async {
            final isValid = loginFormProvider.validateForm();
            if (isValid) {
              final ticket = await api.queryUsers(
                  loginFormProvider.email, loginFormProvider.password, 'P02');
              if (ticket.codEmp.isNotEmpty) {
                authProvider.login(loginFormProvider.email,
                    loginFormProvider.password, ticket);
              } else {
                UtilView.messageDanger('Usuario / Password no válidos');
              }
            }
          }

          return Container(
            margin: EdgeInsets.only(top: 100),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 370),
                child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: loginFormProvider.formKey,
                    child: Column(
                      children: [
                        // Email
                        TextFormField(
                          validator: (value) {
                            if (!EmailValidator.validate(value ?? ''))
                              return 'Email no válido';

                            return null;
                          },
                          onChanged: (value) => loginFormProvider.email = value,
                          style: TextStyle(color: Colors.white),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Ingrese su correo',
                              label: 'Correo',
                              icon: Icons.email_outlined),
                        ),

                        SizedBox(height: 20),

                        // Password
                        TextFormField(
                          onChanged: (value) =>
                              loginFormProvider.password = value,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Ingrese su contraseña';
                            if (value.length < 6)
                              return 'La contraseña debe de ser de 6 caracteres';

                            return null; // Válido
                          },
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: '*********',
                              label: 'Contraseña',
                              icon: Icons.lock_outline_rounded),
                          onEditingComplete: () => sendLogin(),
                        ),

                        SizedBox(height: 20),
                        CustomOutlinedButton(
                          onPressed: () {
                            sendLogin();
                          },
                          text: 'Ingresar',
                        ),
/* 
                        SizedBox(height: 20),
                        LinkText(
                          text: 'Nueva cuenta',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Flurorouter.registerRoute);
                          },
                        ) */
                      ],
                    )),
              ),
            ),
          );
        }));
  }
}
