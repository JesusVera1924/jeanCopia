import 'package:pedidos_en_linea/providers/product_provider.dart';
import 'package:pedidos_en_linea/ui/dialog/dialogInfo.dart';
import 'package:pedidos_en_linea/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

Future showDialogViewItems(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        final provider = Provider.of<ProductProvider>(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Carrito de items'.toUpperCase(),
                style: GoogleFonts.roboto(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              /* Row(
                children: [
                  Text(
                    'Carrito de items'.toUpperCase(),
                    style: GoogleFonts.roboto(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Urgente'.toUpperCase(),
                      style: GoogleFonts.roboto(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Pendientes'.toUpperCase(),
                      style: GoogleFonts.roboto(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ), */
              Divider(),
              provider.carritoProduct.length != 0
                  ? Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width * 75 / 100,
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: DataTable(
                              headingRowHeight: 40,
                              dividerThickness: 2,
                              columns: [
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Codigo'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: false),
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Descripcion'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: false),
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Comentario'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: false),
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Precio'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: true),
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Cantidad'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: true),
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Estado'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: false),
                                DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Acciones'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    numeric: false),
                              ],
                              rows: provider.carritoProduct
                                  .map((e) => DataRow(cells: [
                                        DataCell(
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              e.codPro,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 250, minWidth: 100),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Tooltip(
                                                  message: e.nomPro,
                                                  child: Text(
                                                    e.nomPro,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                )),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 250, minWidth: 100),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Tooltip(
                                                  message: e.notPro,
                                                  child: Text(
                                                    e.notPro,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                )),
                                          ),
                                        ),
                                        DataCell(
                                          Align(
                                              alignment: Alignment.center,
                                              child: Text(NumberFormat.currency(
                                                      locale: 'en_US',
                                                      symbol: r'$',
                                                      decimalDigits: 2)
                                                  .format(e.pvuMov))),
                                        ),
                                        DataCell(
                                          Align(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              alignment: Alignment.centerLeft,
                                              width: 70,
                                              child: TextFormField(
                                                initialValue: '${e.canMov}',
                                                style: TextStyle(fontSize: 12),
                                                textAlign: TextAlign.right,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'(^[0-9]*$)')),
                                                  LengthLimitingTextInputFormatter(
                                                      8),
                                                ],
                                                onFieldSubmitted:
                                                    (String value) {
                                                  if (value.isNotEmpty) {
                                                    provider.updateCantidad(
                                                        e,
                                                        double.parse(
                                                            value.isEmpty
                                                                ? "0"
                                                                : value));
                                                  }
                                                },
                                                decoration: CustomInputs
                                                    .dialogInputDecoration(
                                                        hint: ""),
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                e.stsMov,
                                                style: TextStyle(
                                                    color: e.stsMov == 'U'
                                                        ? Colors.red
                                                        : Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        DataCell(
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    if (provider.checkExitencia(
                                                        e.codPro)) {
                                                      dialogInfo(context,
                                                          e.codPro, e.notPro);
                                                    }
                                                  },
                                                  child: Tooltip(
                                                    message: 'Comentario',
                                                    child: Icon(
                                                        Icons.assignment,
                                                        color: Colors.blueGrey),
                                                  )),
                                              InkWell(
                                                  onTap: () =>
                                                      provider.deleteCart(e),
                                                  child: Tooltip(
                                                    message: 'Eliminar',
                                                    child: Icon(Icons.delete,
                                                        color: Colors.red),
                                                  )),
                                              InkWell(
                                                  onTap: () =>
                                                      provider.updateEstado(
                                                          e,
                                                          e.stsMov == "P"
                                                              ? "U"
                                                              : "P"),
                                                  child: Tooltip(
                                                    message: 'Estado',
                                                    child: Icon(
                                                        Icons
                                                            .replay_circle_filled_rounded,
                                                        color: Colors.orange),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ]))
                                  .toList()),
                        ),
                      ),
                    )
                  : Text(
                      'No tiene ningun item agregado al carrito!!',
                      style: GoogleFonts.roboto(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
            ],
          ),
          actions: [
            TextButton(
                child: Text(
                  'Generar Pedido',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (provider.carritoProduct.isNotEmpty) {
                    provider.generarOrder();
                  }
                  Navigator.pop(context);
                }),
            TextButton(
                child: Text(
                  'Salir',
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.of(context).pop()),
          ],
        );
      });
}
