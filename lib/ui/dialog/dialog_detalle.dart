import 'package:pedidos_en_linea/api/solicitud_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<bool> dialogDetalle(
    BuildContext context, String producto, SolicitudApi api) async {
  bool op = false;
  final detail = await api.getDetail(producto);
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            'CARACTERISTICAS',
            textAlign: TextAlign.center,
          ),
          content: detail.etiL01 != ""
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    containerView(detail.etiL01),
                    containerView(detail.etiL02),
                    containerView(detail.etiL03),
                    containerView(detail.etiL04),
                    containerView(detail.etiL05),
                    containerView(detail.etiL06),
                    containerView(detail.etiL07),
                    containerView(detail.etiL08),
                    containerView(detail.etiL09),
                    containerView(detail.etiL10),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sin caracteristicas',
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                    const Icon(Icons.not_interested_sharp,
                        size: 40, color: Colors.redAccent)
                  ],
                ),
          actions: [
            /*  TextButton.icon(
              onPressed: () async {
                await dialogGaleria(context, producto, api);
              },
              icon: const Icon(Icons.outbox_rounded, color: Colors.indigo),
              label: Text(
                'Ver Galeria',
                style: CustomLabels.h3.copyWith(color: Colors.indigo),
              ),
            ), */
            TextButton.icon(
              onPressed: () {
                op = true;
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.check_circle_outline, color: Colors.green),
              label: Text(
                'Aceptar',
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.green),
              ),
            ),
          ],
        );
      });
  return op;
}

TextStyle buildBoxStyle() {
  return GoogleFonts.roboto(
      fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey);
}

Widget containerView(String txt) {
  return Container(
    constraints: BoxConstraints(minWidth: 50, maxWidth: 150),
    child: Text(
      '*' + txt,
      style: buildBoxStyle(),
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    ),
  );
}
