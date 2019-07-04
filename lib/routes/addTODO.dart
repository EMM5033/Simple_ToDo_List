import 'package:flutter/material.dart';
import 'mainPage.dart';
import 'package:todo_list/DataBase/ToDo.dart';

List<Color> buttonColor = List.generate(color.length, (int i){
  return Colors.white;
});


bool alreadyChoosed = false;
ToDo _db = new ToDo();
TextEditingController _name = new TextEditingController();
TextEditingController _content = new TextEditingController();
int _choosenColor;

class AddToDo extends StatefulWidget {
  AddToDo({Key key}) : super(key: key);
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(54, 54, 64, 1),
          title: Text("Add TODO"),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios,),onPressed: ()=>Navigator.pop(context),),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      gapPadding: 3.3,
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                  validator: (value){
                    if(value.isEmpty)
                      return "Name Cannot Be Empty";
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _content,
                  decoration: InputDecoration(
                    labelText: "Content",
                    border: OutlineInputBorder(
                      gapPadding: 3.3,
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(10),
                color: Colors.white,
                child: GridView.count(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  children: List.generate(color.length, (int i){
                    
                    return Container(
                      child: IconButton(icon: Icon(Icons.playlist_add_check,color: buttonColor[i],),onPressed: (){
                        setState(() {
                          if(!alreadyChoosed){
                            buttonColor[i] = Colors.black;
                            alreadyChoosed = true;
                            _choosenColor = i;
                          }
                        });
                      },),
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: color[i],
                        borderRadius: BorderRadius.circular(10)
                      ),
                    );
                  }),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(54, 54, 64, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 20),)),
                  ),
                  onTap: (){
                    if(formKey.currentState.validate()){
                      _db.insertTODO(_name.text, _content.text=="" ? " ":_content.text, _choosenColor);
                      alreadyChoosed = false;
                      formKey.currentState.reset();
                      _name.text = "";
                      _content.text = "";
                      buttonColor[_choosenColor] = Colors.white;
                      Navigator.pop(context);
                      final SnackBar snackBar = new SnackBar(
                        content: Text("TODO has been added"),
                        backgroundColor: Color.fromRGBO(54, 54, 64, 1),
                        duration: Duration(seconds: 3),
                      );
                      scaffoldKey.currentState.showSnackBar(snackBar);
                    }
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}