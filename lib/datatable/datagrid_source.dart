import 'dart:convert';

import 'package:pedidos_en_linea/api/solicitud_api.dart';
import 'package:pedidos_en_linea/model/modelview/carrito_view.dart';
import 'package:pedidos_en_linea/providers/product_provider.dart';
import 'package:pedidos_en_linea/ui/dialog/dialogInfo.dart';
import 'package:pedidos_en_linea/ui/dialog/dialog_alterno.dart';
import 'package:pedidos_en_linea/ui/dialog/dialog_galeria.dart';
import 'package:pedidos_en_linea/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class JsonDataGridSource extends DataGridSource {
  final List<CarritoView> products;
  final BuildContext context;
  final api = SolicitudApi();
  List<DataGridRow> dataGridRows = [];

  JsonDataGridSource(this.products, this.context) {
    buildDataGridRow();
  }

  void buildDataGridRow() {
    dataGridRows = products.map<DataGridRow>((CarritoView product) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'imagen', value: product.item.imagen),
        DataGridCell<String>(columnName: 'grupo', value: product.item.nGrupo),
        DataGridCell<String>(columnName: 'articulo', value: product.item.item),
        DataGridCell<String>(
            columnName: 'descripcion', value: product.item.nItem),
        DataGridCell<String>(columnName: 'marca', value: product.item.marca),
        DataGridCell<String>(
            columnName: 'precio', value: "${product.item.precio}"),
        DataGridCell<TextEditingController>(
            columnName: 'cantidad', value: product.cantidad),
        DataGridCell<String>(columnName: 'accion', value: product.item.item),
        DataGridCell<String>(columnName: 'obs', value: product.item.inventario),
      ]);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell dataCell) {
      if (dataCell.columnName == 'accion') {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            /*    alignment: Alignment.centerLeft, */
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: () {
                    productProvider.addCart(dataCell.value, "U");
                    /* productProvider.addCartBd(dataCell.value); */
                  },
                  child: Tooltip(
                    message: 'Pedido Urgente',
                    child: Icon(
                      Icons.add_circle_rounded,
                      color: Colors.green,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    productProvider.addCart(dataCell.value, "P");
                    productProvider.updateValores();
                  },
                  child: Tooltip(
                    message: 'Pedido Programable',
                    child: Icon(
                      Icons.more_time_sharp,
                      color: Colors.orange,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (productProvider.checkExitencia(dataCell.value)) {
                      dialogInfo(context, dataCell.value, "");
                    }
                  },
                  child: Tooltip(
                    message: 'Comentario',
                    child: Icon(
                      Icons.assignment,
                      color: productProvider.checkExitencia(dataCell.value)
                          ? Colors.red
                          : Colors.blueGrey,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => dialogAlternos(
                      context, dataCell.value, productProvider.api),
                  child: Tooltip(
                    message: 'Alterno',
                    child: Icon(
                      Icons.queue_rounded,
                      color: Colors.indigoAccent,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => dialogGaleria(
                      context, dataCell.value, productProvider.api),
                  child: Tooltip(
                    message: 'Galeria',
                    child: Icon(
                      Icons.photo_library_outlined,
                      color: Colors.orange,
                    ),
                  ),
                ),
                InkWell(
                  /* onTap: () => dialogDetalle(
                      context, dataCell.value, productProvider.api), */
                  child: Tooltip(
                    message: 'Back Order',
                    child: Icon(
                      Icons.turned_in_not_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ));
      } else if (dataCell.columnName == 'cantidad') {
        return Align(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            alignment: Alignment.centerLeft,
            width: 70,
            child: TextFormField(
              controller: dataCell.value,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.right,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'(^[0-9]*$)')),
                LengthLimitingTextInputFormatter(8),
              ],
              onTap: () {
                dataCell.value.selection = TextSelection(
                    baseOffset: 0, extentOffset: dataCell.value.text.length);
              },
              decoration: CustomInputs.dialogInputDecoration(hint: ""),
            ),
          ),
        );
      } else if (dataCell.columnName == 'precio') {
        return Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              dataCell.value.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ));
      } else if (dataCell.columnName == 'imagen') {
        return Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: dataCell.value.toString() != ""
                ? FutureBuilder<String>(
                    future: api.obtenerRuta(dataCell.value.toString()),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: Image.memory(
                            base64Decode(snapshot.data!),
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                            errorBuilder: (context, obj, _) {
                              return Image.asset(
                                'assets/no-image.jpg',
                                width: 150,
                                height: 150,
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        );
                      } else if (snapshot.hasError) {
                        return Image.asset(
                          'assets/no-image.jpg',
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
                  )
                : Image.asset(
                    'assets/no-image.jpg',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ));
      } else {
        return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              dataCell.value.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(fontSize: 12),
            ));
      }
    }).toList());
  }
}



/* 
  if (dataCell.columnName == 'descripcion') {
        return Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(dataCell.value.toString(), maxLines: 3));
 */