import 'package:pedidos_en_linea/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: builBoxDecoration(),
      height: size.width > 610 ? 60 : 90,
      child: size.width > 610 ? deskView(context) : phoneView(context),
    );
  }

  //BoxDecoration builBoxDecoration() => BoxDecoration(color: Color(0xff3a5662));
  BoxDecoration builBoxDecoration() => BoxDecoration(color: Color(0xD9b22222));
}

Widget deskView(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        child: Image(
          image: AssetImage('assets/logoSinFondo.png'),
          width: 150,
        ),
      ),
      Container(
        padding: EdgeInsets.all(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                //'DISTRIMIA S.A',
                'Comercial Japonesa Automotriz Cía. Ltda.',
                style: GoogleFonts.montserratAlternates(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              'Pedidos en linea',
              style: GoogleFonts.montserratAlternates(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      Spacer(),
      TextButton.icon(
        icon: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        label: Text(
          'Cerrar Session',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () =>
            Provider.of<AuthProvider>(context, listen: false).logout(),
      ),
    ],
  );
}

Widget phoneView(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        child: Image(
          image: AssetImage('assets/logoSinFondo.png'),
          width: 150,
        ),
      ),
      Container(
        padding: EdgeInsets.all(0.8),
        child: Column(
          crossAxisAlignment: size.width > 610
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                'Pedidos en linea',
                style: GoogleFonts.montserratAlternates(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              'Comercial Japonesa Automotriz Cía. Ltda.',
              style: GoogleFonts.montserratAlternates(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            TextButton.icon(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: Text(
                'Cerrar Session',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () =>
                  Provider.of<AuthProvider>(context, listen: false).logout(),
            ),
          ],
        ),
      ),
      /*  Spacer(), */
    ],
  );
}
