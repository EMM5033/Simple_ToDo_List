import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/DataBase/ToDo.dart';


class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  _MainPageState createState() => _MainPageState();
}

ToDo _database = new ToDo();
List _data=[];
int len = 0;


List<Color> color = [
  Color.fromRGBO(255, 148, 174, 1),
  Color.fromRGBO(231, 62, 105, 1),
  Color.fromRGBO(182, 130, 253, 1),
  Color.fromRGBO(80, 145, 255, 1),
  Color.fromRGBO(46, 197, 255, 1),
  Color.fromRGBO(86, 212, 193, 1),
  Color.fromRGBO(75, 210, 73, 1),
];
Random r = new Random();

Color colorOfTODO(){
  return color[r.nextInt(color.length)];
}




final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

final ColorOfAppBar = Color.fromRGBO(54, 54, 64, 1);

class _MainPageState extends State<MainPage> {
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.1;
    _retrieveData();

    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(backgroundColor: ColorOfAppBar,title: Text("TODO - List",style: TextStyle(color: Colors.white),),),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorOfAppBar,
          child: Icon(Icons.add),
          onPressed: ()=>Navigator.pushNamed(context, "/add"),
        ),
        body: ListView.builder(
          itemCount: _data == null ? 0 : _data.length,
          itemBuilder: (c,i){
            return Dismissible(
              key: Key("ads"),
              onDismissed: (d){
                String s = _data[i]['name'];
                
                setState(() {
                  _database.deleteFromTODO(s);
                });
                            
              },
              child: InkWell(
                onTap: (){
                  return showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext c){
                      return AlertDialog(
                        backgroundColor: color[_data[i]['color']],
                        content: Text("${_data[i]['content']}"),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      );
                    }
                  );
                },
                child: Container(
                  child:  Center(
                    child: Text(_data[i]['name']),
                  ),
                  margin: EdgeInsets.all(5),
                  height: height,
                  decoration: BoxDecoration(
                    color: color[_data[i]['color']],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

@override
void initState() { 
  super.initState();  
  _retrieveData();
}

_retrieveData() async{
  _data = await _database.getAllData(); 
  setState(() {
   _data=_data; 
  });
}



}