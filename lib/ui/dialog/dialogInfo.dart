import 'package:pedidos_en_linea/providers/product_provider.dart';
import 'package:pedidos_en_linea/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future dialogInfo(BuildContext context, String item, String value) async {
  final _controller = TextEditingController(text: value);
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Comentario: ' + item,
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.grey),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 400, minWidth: 150),
                margin: const EdgeInsets.only(top: 15, bottom: 10),
                child: TextFormField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.black),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(200),
                    ],
                    maxLines: 3,
                    decoration: CustomInputs.dialogInputDecoration(
                        hint: 'Información Adicional')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancelar',
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_controller.text.isNotEmpty) {
                        Provider.of<ProductProvider>(context, listen: false)
                            .addInfo(item, _controller.text.toUpperCase());
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Aceptar',
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.green),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
}
