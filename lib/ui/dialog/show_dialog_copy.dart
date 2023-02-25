import 'package:pedidos_en_linea/datatable/items_source.dart';
import 'package:pedidos_en_linea/providers/product_provider.dart';
import 'package:pedidos_en_linea/util/util_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

Future showDialoCopyItems(BuildContext context) async {
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
              Row(
                mainAxisAlignment: provider.carritoTemp.isNotEmpty
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  if (provider.carritoTemp.isNotEmpty)
                    Text(
                      'Carrito de items'.toUpperCase(),
                      style: GoogleFonts.roboto(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  if (provider.carritoTemp.isNotEmpty) Spacer(),
                  ElevatedButton(
                    onPressed: () => provider.fillVisual(),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                    child: Text('      Todo      '.toUpperCase(),
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  ElevatedButton(
                    onPressed: () => provider.fillStatus("U"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    child: Text('    Urgente   '.toUpperCase(),
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  ElevatedButton(
                    onPressed: () => provider.fillStatus("P"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    child: Text('Programado'.toUpperCase(),
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Divider(),
              provider.carritoTemp.isNotEmpty
                  ? Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width * 80 / 100,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: SfDataGridTheme(
                        data: SfDataGridThemeData(
                            headerColor: const Color(0xff3a5662)),
                        child: SfDataGrid(
                          columnWidthMode: ColumnWidthMode.fill,
                          navigationMode: GridNavigationMode.cell,
                          gridLinesVisibility: GridLinesVisibility.both,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                          headerRowHeight: 35,
                          isScrollbarAlwaysShown: true,
                          source: ItemsDataSource(
                              provider.carritoTemp,
                              context,
                              Provider.of<ProductProvider>(context,
                                  listen: false)),
                          columns: [
                            GridColumn(
                              columnWidthMode: ColumnWidthMode.fitByColumnName,
                              columnName: 'codigo',
                              label: boxContainer('Codigo'),
                            ),
                            GridColumn(
                                columnName: 'descripcion',
                                /* columnWidthMode: ColumnWidthMode.none,
                                width: MediaQuery.of(context).size.width *
                                    20 /
                                    100, */
                                label: boxContainer('Descripcion')),
                            GridColumn(
                                columnName: 'comentario',
                                /*  columnWidthMode: ColumnWidthMode.none,
                                width: MediaQuery.of(context).size.width *
                                    24 /
                                    100, */
                                label: boxContainer('Comentario')),
                            GridColumn(
                                columnWidthMode:
                                    ColumnWidthMode.fitByColumnName,
                                columnName: 'precio',
                                label: boxContainer('Precio')),
                            GridColumn(
                                columnWidthMode:
                                    ColumnWidthMode.fitByColumnName,
                                columnName: 'cantidad',
                                label: boxContainer('Cantidad')),
                            GridColumn(
                                columnWidthMode:
                                    ColumnWidthMode.fitByColumnName,
                                columnName: 'estado',
                                label: boxContainer('Estado')),
                            GridColumn(
                                columnWidthMode:
                                    ColumnWidthMode.fitByColumnName,
                                columnName: 'acciones',
                                label: boxContainer('Acciones')),
                          ],
                        ),
                      ),
                    )
                  : Text(
                      'No tiene ningun item agregado!!',
                      style: GoogleFonts.roboto(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
              Row(
                children: [
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Programados - Items: ${provider.countP} - Total: ${provider.totalP.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Urgentes         - Items: ${provider.countU} - Total: ${provider.totalU.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  TextButton.icon(
                      icon: Icon(
                        Icons.assignment_turned_in,
                        color: Colors.green,
                      ),
                      label: Text(
                        'Generar Pedido',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        if (provider.carritoProduct.isNotEmpty) {
                          provider.generarOrder();
                          UtilView.messageAccess('Pedido Generado');
                        }
                        Navigator.pop(context);
                      }),
                  TextButton.icon(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                      label: Text(
                        'Salir',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => Navigator.of(context).pop()),
                ],
              ),
            ],
          ),
        );
      });
}

Widget boxContainer(String txt) {
  return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        txt,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ));
}
