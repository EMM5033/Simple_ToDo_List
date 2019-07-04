import 'package:flutter/material.dart';
import 'package:todo_list/routes/mainPage.dart';
import 'package:todo_list/routes/addTODO.dart';

void main(){
  runApp(
    MaterialApp(
      initialRoute: "/",
      routes:{
        "/":(BuildContext context)=>MainPage(),
        "/add":(BuildContext context)=>AddToDo(),
      }
    ),
  );
}