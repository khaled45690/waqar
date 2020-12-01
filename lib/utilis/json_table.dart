library json_table;
import 'dart:convert';

import 'package:waqarapp/constants/customcolors.dart';
import 'package:waqarapp/model/TableResponse.dart';
import 'package:waqarapp/resources/fonts.dart';
import 'package:flutter/material.dart';
import 'package:json_utilities/json_utilities.dart';

import 'json_table_column.dart';



typedef TableHeaderBuilder = Widget Function(String header);
typedef TableCellBuilder = Widget Function(dynamic value);

class JsonTable extends StatefulWidget {
  final List dataList;
  final TableHeaderBuilder tableHeaderBuilder;
  final TableCellBuilder tableCellBuilder;
  final List<JsonTableColumn> columns;
  final bool showColumnToggle;

  JsonTable(
    this.dataList, {
    Key key,
    this.tableHeaderBuilder,
    this.tableCellBuilder,
    this.columns,
    this.showColumnToggle = false,
  }) : super(key: key);

  @override
  _JsonTableState createState() => _JsonTableState();
}

class _JsonTableState extends State<JsonTable> {
  Set<String> headerList = new Set();
  Set<String> filterHeaderList = new Set();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    assert(widget.dataList != null && widget.dataList.isNotEmpty);
    setHeaderList();
  }

  @override
  void didUpdateWidget(JsonTable oldWidget) {
    if (oldWidget.dataList != widget.dataList) init();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (widget.showColumnToggle)
              Container(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  runSpacing: -12,
                  direction: Axis.horizontal,
                  children: <Widget>[
                    if (widget.columns == null)
                      for (String header in headerList)
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Checkbox(
                                  value: this.filterHeaderList.contains(header),
                                  onChanged: null,
                                ),
                                Text(header),
                                SizedBox(
                                  width: 4.0,
                                ),
                              ],
                            ),
                            onTap: () {
                              print('object');
                              setState(() {
                                if (this.filterHeaderList.contains(header))
                                  this.filterHeaderList.remove(header);
                                else
                                  this.filterHeaderList.add(header);
                              });
                            },
                          ),
                        ),
                  ],
                ),
              ),
            if (widget.columns != null)
              Row(
                children: widget.columns
                    .map(
                      (item) => TableColumn(
                        item.label,
                        widget.dataList,
                        widget.tableHeaderBuilder,
                        widget.tableCellBuilder,
                        item,
                      ),
                    )
                    .toList(),
              )
            else
              Row(
                children: headerList
                    .where((header) => filterHeaderList.contains(header))
                    .map(
                      (header) => TableColumn(
                        header,
                        widget.dataList,
                        widget.tableHeaderBuilder,
                        widget.tableCellBuilder,
                        null,
                      ),
                    )
                    .toList(),
              )
          ],
        ),
      ),
    );
  }

  Set<String> extractColumnHeaders() {
    var headers = Set<String>();
    widget.dataList.forEach((map) {
      (map as Map).keys.forEach((key) {
        headers.add(key);
      });
    });
    return headers;
  }

  void setHeaderList() {
    var headerList = extractColumnHeaders();
    assert(headerList != null);
    this.headerList = headerList;
    this.filterHeaderList.addAll(headerList);
  }
}

class TableColumn extends StatelessWidget {
  final String header;
  final List dataList;
  final TableHeaderBuilder tableHeaderBuilder;
  final TableCellBuilder tableCellBuilder;
  final JsonTableColumn column;
  final jsonUtils = JSONUtils();
 TableResponse tableJsonResponse;
 var jsontableDecode;
  TableColumn(
    this.header,
    this.dataList,
    this.tableHeaderBuilder,
    this.tableCellBuilder,
    this.column,
  );
String typeId;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          tableHeaderBuilder != null
              ? tableHeaderBuilder(header)
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.3),
                    color: desgin_button4_start,
                  ),
                  child: Text(
                    header,
                    textAlign: TextAlign.center,
                    style: AqarFont.getLightFont_Textheadertablet(),
                  ),
                ),
          Container(
            child: Column(
              children: dataList
                  .map((rowMap) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          tableCellBuilder != null
                              ? tableCellBuilder(
                                  getFormattedValue(
                                    jsonUtils.get(
                                      rowMap,
                                      column?.field ?? header,
                                      column?.defaultValue ?? '',
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 2.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey.withOpacity(0.5),

                                  )),
                                  child: InkWell(
                                    child: Text(
                                    getFormattedValue(
                                      jsonUtils.get(
                                        rowMap,
                                        column?.field ?? header,
                                        column?.defaultValue ?? '',
                                      ),
                                        ),
                                        textAlign: TextAlign.center,
                                        style:AqarFont.getLighttable(),

                                      ),
                                    onTap: () {//Osama
                                    print(rowMap);
                                    //  jsontableDecode = json.decode(rowMap);
                                      //print(jsontableDecode);
                                      tableJsonResponse=TableResponse.fromJson(rowMap);
                                      print(tableJsonResponse.number);
                                    },
                                  ),
                                  
                                  
                                
                                ),
                        ],
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  String getFormattedValue(dynamic value) {
    if (value == null) return column?.defaultValue ?? '';

  //  tableJsonResponse=TableResponse.fromJson(value);
   // print(tableJsonResponse.number);
   // typeId = tableJsonResponse.number;
   // print(typeId);
    if (column?.valueBuilder != null) {
      return column.valueBuilder(value);
    }
    return value.toString();
  }
}
