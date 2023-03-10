import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.8, color: Color(0xCC232d37)),
        ),
        color: const Color.fromRGBO(234, 234, 234, 1),
      ),
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05, 0,
          MediaQuery.of(context).size.width * 0.05, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
/*                   InkWell(
                    onTap: () => {},
                    child: const Text('TwT',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                  ),
                  Text(' | ',
                      style: TextStyle(fontSize: 12, color: Color(0xCC232d37))), */
                  InkWell(
                    child: const Text('Inicio',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                  ),
                  Text(' | ',
                      style: TextStyle(fontSize: 12, color: Color(0xCC232d37))),
                  InkWell(
                    child: const Text('Cojapan',
                        style: TextStyle(color: Colors.blue, fontSize: 12)),
                  )
                ],
              ),
              Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text('Copyright © 2021 - 2022',
                      style: TextStyle(
                          color: Color(0xCC232d37),
                          fontSize: 12,
                          letterSpacing: 0.23)))
            ],
          )),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  Icons.exit_to_app_rounded,
                  size: 30,
                  color: Color(0xD9b22222),
                ),
                Text(
                  'Cerrar Sesión',
                  style: GoogleFonts.montserratAlternates(
                      fontSize: 18, color: Color(0xD9b22222)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


/*  InkWell(
            onTap: () => {},
            child: Image.asset('assets/logoSinFondo.png',
                fit: BoxFit.contain, height: 45, width: 120),
          ), */

          /* Text(
              'Cojapan',
              style: GoogleFonts.roboto(fontSize: 22, color: Color(0xD9b22222)),
            ), */