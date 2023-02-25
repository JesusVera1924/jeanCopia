import 'package:pedidos_en_linea/datatable/datagrid_source.dart';
import 'package:pedidos_en_linea/providers/product_provider.dart';
import 'package:pedidos_en_linea/ui/cards/white_card.dart';
import 'package:pedidos_en_linea/ui/dialog/dialogViewValue.dart';
import 'package:pedidos_en_linea/ui/dialog/dialog_detalle.dart';
import 'package:pedidos_en_linea/ui/dialog/show_dialog_copy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DashboardView extends StatefulWidget {
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final _dataGridController = DataGridController();
  final List<String> listOpt = ["MARCA", "ITEM", "GRUPO", "DESCRIPCION"];
  var f = NumberFormat('###0.00', 'en_US');
  String dropdownValue = "MARCA";
  /* Dimensiones de columnas */
  late double imagenNameColumnWidth;
  late double grupoNameColumnWidth;
  late double articuloNameColumnWidth;
  late double descripcionNameColumnWidth;
  late double marcaNameColumnWidth;
  late double precioNameColumnWidth;
  late double cantidadNameColumnWidth;
  late double accionNameColumnWidth;
  late double obsNameColumnWidth;

  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = <GridColumn>[
      GridColumn(
          columnName: 'imagen',
          width: imagenNameColumnWidth,
          minimumWidth: 15.0,
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Text(
                'Imagen'.toUpperCase(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'grupo',
          width: grupoNameColumnWidth,
          minimumWidth: 15.0,
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Text(
                'GRUPO'.toUpperCase(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'articulo',
          width: articuloNameColumnWidth,
          minimumWidth: 15.0,
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Text(
                'Articulo'.toUpperCase(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'descripcion',
          width: descripcionNameColumnWidth,
          minimumWidth: 15.0,
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                'Descripción'.toUpperCase(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'marca',
          width: marcaNameColumnWidth,
          minimumWidth: 15.0,
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Text(
                'Marca'.toUpperCase(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'precio',
          width: precioNameColumnWidth,
          minimumWidth: 15.0,
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerRight,
              child: Text(
                'Precio'.toUpperCase(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'cantidad',
          width: cantidadNameColumnWidth,
          minimumWidth: 15.0,
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Text(
                'Cantidad'.toUpperCase(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'accion',
          width: accionNameColumnWidth,
          minimumWidth: 15.0,
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Text(
                'Acción'.toUpperCase(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'obs',
          width: obsNameColumnWidth,
          minimumWidth: 15.0,
          label: Container(
              padding: const EdgeInsets.only(left: 14),
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
              ))),
    ];
    return columns;
  }

  @override
  void initState() {
    imagenNameColumnWidth = 150;
    grupoNameColumnWidth = 150;
    articuloNameColumnWidth = 150;
    descripcionNameColumnWidth = 400;
    marcaNameColumnWidth = 170;
    precioNameColumnWidth = 90;
    cantidadNameColumnWidth = 110;
    accionNameColumnWidth = 150;
    obsNameColumnWidth = 50;
    Provider.of<ProductProvider>(context, listen: false).getListItems();
    inciar();
    super.initState();
  }

  void inciar() async {
    var listValue = await Provider.of<ProductProvider>(context, listen: false)
        .getPreference();

    if (listValue.isNotEmpty) {
      imagenNameColumnWidth = listValue[0];
      grupoNameColumnWidth = listValue[1];
      articuloNameColumnWidth = listValue[2];
      descripcionNameColumnWidth = listValue[3];
      marcaNameColumnWidth = listValue[4];
      precioNameColumnWidth = listValue[5];
      cantidadNameColumnWidth = listValue[6];
      accionNameColumnWidth = listValue[7];
      obsNameColumnWidth = listValue[8];
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final size = MediaQuery.of(context).size;
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WhiteCard(
          title: 'Filtros',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: const Text('Filtros: ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Container(
                height: 40,
                constraints: BoxConstraints(maxWidth: 150, minWidth: 100),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all()),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue.toString();
                      });
                    },
                    items: listOpt.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(
                          e,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 35 / 100,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: TextFormField(
                    controller: productProvider.textSearch,
                    style: const TextStyle(color: Colors.black),
                    onEditingComplete: () async {
                      if (productProvider.textSearch.text.isNotEmpty) {
                        buildShowDialog(context);
                        await productProvider
                            .searchItems(dropdownValue.toUpperCase());
                        Navigator.of(context).pop();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Criterio',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.3))),
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: productProvider.focusColor)),
                      suffixIcon: InkWell(
                        onTap: () => productProvider.textSearch.clear(),
                        child: Icon(Icons.delete_forever,
                            size: 18, color: productProvider.focusColor),
                      ),
                    )),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.sell_outlined,
                        color: Colors.white,
                        size: size.width > 815.0 ? 20 : 10,
                      ),
                      onPressed: () async {
                        buildShowDialog(context);
                        await productProvider.getListNewItem("O");
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xD9b22222)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Color(0xD9b22222)),
                          ),
                        ),
                      ),
                      label: Text('Ofertas',
                          style: TextStyle(
                              fontSize: size.width > 815.0 ? 12 : 10)),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.new_releases_outlined,
                        color: Colors.white,
                        size: size.width > 815.0 ? 20 : 10,
                      ),
                      onPressed: () async {
                        buildShowDialog(context);
                        await productProvider.getListNewItem("N");
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xD9b22222)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Color(0xD9b22222)),
                          ),
                        ),
                      ),
                      label: Text('Nuevos',
                          style: TextStyle(
                              fontSize: size.width > 815.0 ? 12 : 10)),
                    ),
                  ],
                ),
              ),
              Spacer(),
              if (size.width > 815.0)
                InkWell(
                    onTap: () => productProvider.savePreference(
                        imagenNameColumnWidth,
                        grupoNameColumnWidth,
                        articuloNameColumnWidth,
                        descripcionNameColumnWidth,
                        marcaNameColumnWidth,
                        precioNameColumnWidth,
                        cantidadNameColumnWidth,
                        accionNameColumnWidth,
                        obsNameColumnWidth),
                    child: Tooltip(
                        message: 'Guardar distancia\nde las columnas',
                        child: Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ))),
              if (size.width > 815.0)
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "No.Items:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            "${productProvider.carritoProduct.length}",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            f.format(productProvider.subtotal),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Iva 12%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            f.format(productProvider.iva),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            f.format(productProvider.total),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: SfDataGridTheme(
            data: SfDataGridThemeData(headerColor: const Color(0xD9b22222)),
            child: SfDataGrid(
              rowHeight: 40,
              headerRowHeight: 40,
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              /*   showCheckboxColumn: true, */
              /*  selectionMode: SelectionMode.multiple, */
              allowColumnsResizing: true,
              isScrollbarAlwaysShown: true,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.row,
              onCellLongPress: (DataGridCellLongPressDetails onPresent) {
                dialogDetalle(
                    context,
                    productProvider
                        .listProductos[onPresent.rowColumnIndex.rowIndex - 1]
                        .item
                        .item,
                    productProvider.api);
              },
              columnResizeMode: ColumnResizeMode.onResize,
              controller: _dataGridController,
              source:
                  JsonDataGridSource(productProvider.listProductos, context),
              onColumnResizeUpdate: (ColumnResizeUpdateDetails args) {
                setState(() {
                  if (args.column.columnName == 'imagen') {
                    imagenNameColumnWidth = args.width;
                  } else if (args.column.columnName == 'grupo') {
                    grupoNameColumnWidth = args.width;
                  } else if (args.column.columnName == 'articulo') {
                    articuloNameColumnWidth = args.width;
                  } else if (args.column.columnName == 'descripcion') {
                    descripcionNameColumnWidth = args.width;
                  } else if (args.column.columnName == 'marca') {
                    marcaNameColumnWidth = args.width;
                  } else if (args.column.columnName == 'precio') {
                    precioNameColumnWidth = args.width;
                  } else if (args.column.columnName == 'cantidad') {
                    cantidadNameColumnWidth = args.width;
                  } else if (args.column.columnName == 'accion') {
                    accionNameColumnWidth = args.width;
                  } else if (args.column.columnName == 'obs') {
                    obsNameColumnWidth = args.width;
                  }
                });
                return true;
              },
              columns: getColumns(),
            ),
          ),
        ),
        SizedBox(
          height: 35,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                child: OutlinedButton.icon(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () => dialogViewValue(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return Color(0xD9b22222);
                    }),
                  ),
                  label: Text(
                    'Ver Total',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                child: OutlinedButton.icon(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return Color(0xD9b22222);
                    }),
                  ),
                  onPressed: () {
                    productProvider.fillVisual();
                    showDialoCopyItems(context);
                  },
                  label: Text(
                    'Ver Pedido',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ))
            ],
          ),
        )
      ],
    ));
  }
}

buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Text(
                "Esperando data..",
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 17),
              )
            ],
          ),
        );
      });
}
