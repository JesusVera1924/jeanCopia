import 'package:pedidos_en_linea/api/solicitud_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future dialogAlternos(
    BuildContext context, String producto, SolicitudApi api) async {
  final detail = await api.getAlternos('01', producto);
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text(
            'ALTERNOS',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey),
          ),
          content: detail.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final _fieldValue in detail) ...[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Text(
                            _fieldValue.codAlt,
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                      const Divider(thickness: 1)
                    ]
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sin información',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                    ),
                    const Icon(Icons.not_interested_sharp,
                        size: 40, color: Colors.redAccent)
                  ],
                ),
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.check_circle_outline, color: Colors.green),
              label: Text('Aceptar'),
            ),
          ],
        );
      });
}
