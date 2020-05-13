//import 'dart:ffi';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Transportsales extends StatefulWidget{
  static const id = 'Transportsales';

  @override
  _TransportsalesState createState() => _TransportsalesState();
}

class _TransportsalesState extends State<Transportsales> {
  String barcode = "";
  DateTime pickDate;
  String _mySelection , _mySelectioncustomer,_mySelectionFrom,_mySelectionTo,_bpId;
  final String url ="https://63311c25.ngrok.io/testing/public/api/cashbook";
  final String url2="https://63311c25.ngrok.io/testing/public/api/customer";
  final String url3="https://63311c25.ngrok.io/testing/public/api/point";
  List data = List();
  List data2 = List();
  List data3 = List();
  List<DropdownMenuItem<String>>listDrop =[];
  String selected = null;
  void loadData(){
    listDrop=[];
    listDrop.add(new DropdownMenuItem(child: new Text('Contract'),
      value: 'Contract',
    ));
    listDrop.add(new DropdownMenuItem(child: new Text('On Call'),
      value: 'On Call',
    ));

  }


  Future<String> getSWData() async{
    var res = await http
        .get(Uri.encodeFull(url),headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }
  Future<String> getSWDataCustomer() async{
    var res = await http
        .get(Uri.encodeFull(url2),headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      data2 = resBody;
    });

    print(resBody);

    return "Sucess";
  }
  Future<String> getSWFromTo() async{
    var res = await http
        .get(Uri.encodeFull(url3),headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      data3 = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    getSWData();
    getSWDataCustomer();
    getSWFromTo();
    pickDate = DateTime.now();
  }


  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      body:
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color(0xFF00b2cc),
                  Color(0xFF00e5ff),
                  Color(0xFF6effff)
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text('Transport Sales'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:  FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius:5,
                              )]
                          ),
                        ),
                        //driver
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              icon:  Icon(Icons.assignment_ind,
                                color: Colors.lightBlue,
                              ),
                              hintText: 'Driver',
                            ),
                          ),
                        ),
                        //fleet
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              icon:  Icon(Icons.airport_shuttle,
                                color: Colors.lightBlue,
                              ),
                              hintText: 'Fleet',
                            ),
                          ),
                        ),
                        //shpment
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,

                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]

                          ),

                          child: new Center(
                            child: new DropdownButton(
                                isExpanded: true,
                                value: selected,
                                items: listDrop,
                                hint: Text('Shipment Type') ,
                                onChanged: (value){
                                  selected = value;
                                }
                            ),
                          ),
                        ),
                        //customer
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,

                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]

                          ),

                          child: new Center(
                            child: new DropdownButton(
                              isExpanded: true,
                              items:  data2.map((item){
                                return new DropdownMenuItem(
                                  child: new Text(item['name']),
                                  value: item['c_bpartner_id'].toString(),
                                );
                              }).toList(),
                              hint: Text("Customer"),

                              onChanged:(newVal) {
                                setState(() {
                                  _mySelectioncustomer = newVal;
                                });
                              },
                              value: _mySelectioncustomer,
                            ),
                          ),
                        ),
                        //Typecar
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              icon:  Icon(Icons.directions_car,
                                color: Colors.lightBlue,
                              ),
                              hintText: 'Type Car',
                            ),
                          ),
                        ),
                        //Date
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              icon:  Icon(Icons.date_range,
                                color: Colors.lightBlue,
                              ),
                              hintText: ("ETD : ${pickDate.day}/${pickDate.month}/${pickDate.year}"),
                            ),
                            onTap: _pickDate,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              icon:  Icon(Icons.date_range,
                                color: Colors.lightBlue,
                              ),
                              hintText: ("ETA : ${pickDate.day}/${pickDate.month}/${pickDate.year}"),
                            ),
                            onTap: _pickDate,
                          ),
                        ),
                        //cashbook
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,

                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]

                          ),

                          child: new Center(
                            child: new DropdownButton(
                              isExpanded: true,
                              items:  data.map((item){
                                return new DropdownMenuItem(
                                  child: new Text(item['name']),
                                  value: item['c_cashbook_id'].toString(),
                                );
                              }).toList(),
                              hint: Text("Cashbook"),
                              onChanged:(newVal) {
                                setState(() {
                                  _mySelection = newVal;
                                });
                              },
                              value: _mySelection,
                            ),
                          ),
                        ),
                        //From
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]
                          ),
                          child: new Center(
                            child: new DropdownButton(
                              isExpanded: true,
                              items:  data3.map((item){
                                return new DropdownMenuItem(
                                  child: new Text(item['name']),
                                  value: item['xm_point_id'].toString(),
                                );
                              }).toList(),
                              hint: Text("From"),
                              onChanged:(newVal) {
                                setState(() {
                                  _mySelectionFrom = newVal;
                                });
                              },
                              value: _mySelectionFrom,
                            ),
                          ),
                        ),
                        //To
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]
                          ),
                          child: new Center(
                            child: new DropdownButton(
                              isExpanded: true,
                              items:  data3.map((item){
                                return new DropdownMenuItem(
                                  child: new Text(item['name']),
                                  value: item['xm_point_id'].toString(),
                                );
                              }).toList(),
                              hint: Text("To"),
                              onChanged:(newVal) {
                                setState(() {
                                  _mySelectionTo = newVal;
                                });
                              },
                              value: _mySelectionTo,
                            ),
                          ),
                        ),
                        //amount
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16,bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.lightBlue,
                                    blurRadius: 5

                                )
                              ]
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              icon:  Icon(Icons.attach_money,
                                color: Colors.lightBlue,
                              ),
                              hintText: 'Amount',
                            ),
                          ),
                        ),
                        Container(
                            height: 40,
                            margin: EdgeInsets.only(top: 30, bottom: 100),
                            width: MediaQuery.of(context).size.width/1.2,
                            child:new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new RaisedButton( color: Colors.lightBlueAccent,elevation: 3.0,
                                  child: Text("Execute", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700),
                                  ),
                                  onPressed: (){
                                    print(_mySelectioncustomer,);
                                  },
                                ),
                                new RaisedButton( color: Colors.lightBlueAccent,elevation: 3.0,
                                  child: Text("Save", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700),
                                  ),
                                  onPressed: (){
                                  },
                                ),
                                RaisedButton( color: Colors.lightBlueAccent,elevation: 3.0,
                                  child: Text("Calculate", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700),
                                  ),
                                  onPressed: (){
                                  },
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings_overscan),backgroundColor: Colors.lightBlueAccent ,
        onPressed: scan,
      ),
    );

  }
  _pickDate() async{
    DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year-5),
        lastDate: DateTime(DateTime.now().year+5),
        initialDate: pickDate
    );
    if (date != null)
      setState(() {
        pickDate=date;
      });
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      Navigator.pushNamed(context, Transportsales.id);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
      'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}



