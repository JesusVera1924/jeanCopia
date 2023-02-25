import 'package:pedidos_en_linea/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Future dialogViewValue(BuildContext context) async {
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        final provider = Provider.of<ProductProvider>(context);

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ver Pedido'.toUpperCase(),
                style: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () => provider.updateValoresDialog("U"),
                      child: Text(
                        'Urgente',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )),
                  TextButton(
                      onPressed: () => provider.updateValoresDialog("P"),
                      child: Text(
                        'Pendiente',
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      )),
                ],
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text("SubTotal",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(NumberFormat.currency(
                            locale: 'en_US', symbol: r'$', decimalDigits: 2)
                        .format(provider.subtotalDialog))
                  ],
                ),
              ),
              const Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Iva",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(NumberFormat.currency(
                            locale: 'en_US', symbol: r'$', decimalDigits: 2)
                        .format(provider.ivaDialog))
                  ],
                ),
              ),
              const Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text("Total",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(NumberFormat.currency(
                            locale: 'en_US', symbol: r'$', decimalDigits: 2)
                        .format(provider.totalDialog))
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered))
                    return Colors.greenAccent;
                  return Colors.transparent;
                })),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar')),
          ],
        );
      });
}
