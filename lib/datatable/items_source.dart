import 'package:pedidos_en_linea/model/carrito_bd.dart';
import 'package:pedidos_en_linea/providers/product_provider.dart';
import 'package:pedidos_en_linea/ui/dialog/dialogInfo.dart';
import 'package:pedidos_en_linea/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ItemsDataSource extends DataGridSource {
  final List<CarritoBd> listProducts;
  final BuildContext context;
  List<DataGridRow> dataGridRows = [];
  final ProductProvider productProvider;

  ItemsDataSource(this.listProducts, this.context, this.productProvider) {
    buildDataGridRow();
  }

  void buildDataGridRow() {
    dataGridRows = listProducts.map<DataGridRow>((CarritoBd product) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'codigo', value: product.codPro),
        DataGridCell<String>(columnName: 'descripcion', value: product.nomPro),
        DataGridCell<String>(columnName: 'comentario', value: product.notPro),
        DataGridCell<double>(columnName: 'precio', value: product.pvuMov),
        DataGridCell<double>(columnName: 'cantidad', value: product.canMov),
        DataGridCell<String>(columnName: 'estado', value: product.stsMov),
        DataGridCell<CarritoBd>(columnName: 'acciones', value: product),
      ]);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

/*   @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return rowColumnIndex.columnIndex == 0
        ? Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              summaryValue,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.centerRight,
            child: Text(
              double.parse(summaryValue).toStringAsFixed(2),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          );
  } */

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final editeController =
        TextEditingController(text: '${row.getCells()[4].value}');
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.centerLeft,
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(fontSize: 12),
        ),
      ),
      Container(
        constraints: BoxConstraints(maxWidth: 100, minWidth: 70),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[1].value.toString(),
          child: Text(
            row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
      Container(
        constraints: BoxConstraints(maxWidth: 100, minWidth: 70),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[2].value.toString(),
          child: Text(
            row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          NumberFormat.currency(locale: 'en_US', symbol: r'$', decimalDigits: 2)
              .format(row.getCells()[3].value),
          style: TextStyle(fontSize: 12),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        alignment: Alignment.centerLeft,
        height: 40,
        child: TextFormField(
          controller: editeController,
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.right,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'(^[0-9]*$)')),
            LengthLimitingTextInputFormatter(8),
          ],
          onTap: () {
            editeController.selection = TextSelection(
                baseOffset: 0, extentOffset: editeController.text.length);
          },
          onFieldSubmitted: (String value) {
            if (value.isNotEmpty) {
              productProvider.updateCantidad(row.getCells()[6].value,
                  double.parse(value.isEmpty ? "0" : value));
            }
          },
          decoration: CustomInputs.dialogInputDecoration(hint: ""),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          row.getCells()[5].value.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: row.getCells()[5].value.toString() == 'U'
                ? Colors.red
                : Colors.green,
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: () {
                  if (productProvider.checkExitencia(row.getCells()[0].value)) {
                    dialogInfo(context, row.getCells()[0].value,
                        row.getCells()[2].value.toString());
                  }
                },
                child: Tooltip(
                  message: 'Comentario',
                  child: Icon(Icons.assignment, color: Colors.blueGrey),
                )),
            InkWell(
                onTap: () =>
                    productProvider.deleteCart(row.getCells()[6].value),
                child: Tooltip(
                  message: 'Eliminar',
                  child: Icon(Icons.delete, color: Colors.red),
                )),
            InkWell(
                onTap: () => productProvider.updateEstado(
                    row.getCells()[6].value,
                    row.getCells()[6].value.stsMov == "P" ? "U" : "P"),
                child: Tooltip(
                  message: 'Estado',
                  child: Icon(Icons.replay_circle_filled_rounded,
                      color: Colors.orange),
                )),
          ],
        ),
      ),
    ]);
  }
}
