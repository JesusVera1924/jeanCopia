import 'dart:convert';
import 'package:pedidos_en_linea/api/solicitud_api.dart';
import 'package:pedidos_en_linea/model/ruta_img.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future dialogGaleria(
    BuildContext context, String producto, SolicitudApi api) async {
  List<RutaImg> _listRutas = await api.getRutas('01', producto);

  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text('Galeria de Imagenes'),
          content: _listRutas.isNotEmpty
              ? SizedBox(
                  width: 250,
                  height: 250,
                  child: Swiper(
                    itemCount: _listRutas.length,
                    pagination: const SwiperPagination(),
                    control: const SwiperControl(color: Colors.black),
                    itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder<String>(
                        future: api.getBase64(_listRutas[index].imgPro),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 0.5)),
                                height: 200,
                                width: 200,
                                child: Image.memory(
                                  base64Decode(snapshot.data!),
                                  fit: BoxFit.contain,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5));
                          } else if (snapshot.hasError) {
                            return const Text('Error al obtner la imagen');
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      );
                    },
                  ))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sin imagenes',
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                    const Icon(Icons.hide_image_outlined,
                        size: 40, color: Colors.redAccent)
                  ],
                ),
          actions: [
            TextButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.greenAccent;
                  }
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
