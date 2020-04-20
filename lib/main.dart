// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:collection';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FriApp',
      home: CenterAppStateless(),
    );
  }
}

class CenterAppStateless extends StatefulWidget{
  @override
  CenterApp createState()=>CenterApp();
}

class CenterApp extends State<CenterAppStateless> {
  String vpisna = "";
  bool should_load = true;
  var url = 'https://urnik.fri.uni-lj.si/timetable/fri-2019_2020-letni-1-9/allocations.json?classroom=148';
  List<DayAllocations> timetable = new List<DayAllocations>();
  HashMap colorPicker = new HashMap<String, Color>();

  BoxDecoration boxGenerator(int index){

    if(index==0)
      return BoxDecoration();
    else if(index==1)
      return BoxDecoration(
        border : Border(right: BorderSide(color: Colors.black,width:1,)),
      );
    else if(index==2)
      return BoxDecoration(
        border : Border(bottom: BorderSide(color: Colors.black,width:1,)),
      );
    else
      return BoxDecoration(
        border: Border(
          left: BorderSide( //                   <--- left side
            color: Colors.grey,
            width: 0.25,
          ),
          right: BorderSide( //                    <--- right side
            color: Colors.grey,
            width: 0.25,
          ),
          top: BorderSide( //                    <--- top side
            color: Colors.grey,
            width: 0.05,
          ),
          bottom: BorderSide( //                    <--- bot side
            color: Colors.grey,
            width: 0.05,
          ),
        ),
      );
  }

  String getText(int index){
    if(index==1)
      return "MON";
    if(index==2)
      return "TUE";
    if(index==3)
      return "WED";
    if(index==4)
      return "THR";
    if(index==5)
      return "FRI";
    return "";
  }

  //TODO
  getTimetable() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      //iterate over days and create list object
      List<DayAllocations> alloc = new List<DayAllocations>();
      /*
        * for(day : time)
        *   alloc.add()
        *
        * timetable = alloc;
        * */
      //Pol se bo to uporabljal za zdej hardcodan
      //TimeOfDay _startTime = TimeOfDay(hour:int.parse(s.split(":")[0]),minute: int.parse(s.split(":")[1]));
      //TESTNI PODATKI
      //MON
      DayAllocations al1 = new DayAllocations();
      List<SingleAllocation> lista = new List<SingleAllocation>();
      lista.add(new SingleAllocation("Razvoj intelige","RIS","P20",3,TimeOfDay(hour: 11, minute: 0),"P","Miha medo"));
      lista.add(new SingleAllocation("Razvoj intelige","RIS","P17",2,TimeOfDay(hour: 17, minute: 0),"V","Joze Jenko"));
      lista.add(new SingleAllocation("Prevajalniki","PREV","PR07",3,TimeOfDay(hour: 8, minute: 0),"P","Martin Neki"));
      al1.day="MON";
      al1.allocations = lista;
      alloc.add(al1);
      //TUE
      DayAllocations al2 = new DayAllocations();
      List<SingleAllocation> lista2 = new List<SingleAllocation>();
      lista2.add(new SingleAllocation("Osnove umetne inteligence","OUI","PA",4,TimeOfDay(hour: 7, minute: 0),"P","Polona"));
      lista2.add(new SingleAllocation("Matematika 1","MAT1","P1",3,TimeOfDay(hour: 11, minute: 0),"P","Alenka"));
      al2.day="TUE";
      al2.allocations = lista2;
      alloc.add(al2);
      //WED
      DayAllocations al4 = new DayAllocations();
      List<SingleAllocation> lista4 = new List<SingleAllocation>();
      lista4.add(new SingleAllocation("Fizika","FIZ","PA",3,TimeOfDay(hour: 7, minute: 0),"P","Fizik"));
      lista4.add(new SingleAllocation("Fizika","FIZ","P22",2,TimeOfDay(hour: 11, minute: 0),"V","Alenka"));
      lista4.add(new SingleAllocation("Prevajalniki","PREV","PR19",2,TimeOfDay(hour: 13, minute: 0),"V","Bostjan"));
      al4.day="WED";
      al4.allocations = lista4;
      alloc.add(al4);
      //THU
      DayAllocations al5 = new DayAllocations();
      List<SingleAllocation> lista5 = new List<SingleAllocation>();
      lista5.add(new SingleAllocation("Racunska zahtevnost","RHZP","P22",2,TimeOfDay(hour: 9, minute: 0),"V","Fizik"));
      lista5.add(new SingleAllocation("Tehnologija prog opreme","TPO","P22",2,TimeOfDay(hour: 11, minute: 0),"V","Alenka"));
      al5.day="THU";
      al5.allocations = lista5;
      alloc.add(al5);
      //FRI
      DayAllocations al3 = new DayAllocations();
      List<SingleAllocation> lista3 = new List<SingleAllocation>();
      lista3.add(new SingleAllocation("Racunska zahtevnost","RZHP","P123",3,TimeOfDay(hour: 8, minute: 0),"P","Jure"));
      lista3.add(new SingleAllocation("Zahtevnost in ...","ZZRS","P2",3,TimeOfDay(hour: 11, minute: 0),"P","Alenka"));
      lista3.add(new SingleAllocation("Tehnologija prog opreme","TPO","PR4",2,TimeOfDay(hour: 14, minute: 0),"P","Polona"));
      lista3.add(new SingleAllocation("Osnove umetne inteligence","OUI","PR23",1,TimeOfDay(hour: 17, minute: 0),"V","Jure"));
      al3.day="FRI";
      al3.allocations = lista3;
      alloc.add(al3);
      timetable = alloc;
    }
  }

  void addAllocations(List<Widget>cells){
    for(DayAllocations day in timetable){
      int start = 7;
      int day_offset;
      switch(day.day){
        case "MON":
          day_offset=7;
          break;
        case "TUE":
          day_offset=8;
          break;
        case "WED":
          day_offset=9;
          break;
        case "THU":
          day_offset=10;
          break;
        case "FRI":
          day_offset=11;
          break;
      }
      Random random = new Random();
      for(SingleAllocation subject in day.allocations){
        Color cellColor;
        //get color based on subject name
        if(colorPicker.containsKey(subject.name)){
          cellColor = colorPicker[subject.name];
        }else{
          cellColor = getColor(random);
          int c = 0;
          while(colorPicker.containsValue(cellColor)|| c<50){
            cellColor = getColor(random);
            c++;
          }
          colorPicker[subject.name] = cellColor;
        }

        int time_offset;
        int startHour = subject.startTime.hour;
        time_offset = startHour-start;
        int index = day_offset+6*time_offset;
        BoxDecoration box = BoxDecoration(
          color:cellColor.withOpacity(0.65),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
          ),
        );
        if(subject.durration==1)
          box = BoxDecoration(
              color:cellColor.withOpacity(0.65),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              )
          );
        //header
        Container head = Container(
          alignment: Alignment.center,
          decoration: box,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children:<Widget>[Text(
                subject.tag+" | "+subject.type,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
                Text(
                  subject.classroom,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                )
              ]),
        );

        cells[index] = InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(subject: subject),
            ),
          ),
          child: head,
        );

        //rep
        for(int i = 1;i<subject.durration;i++){
          int index2 = day_offset+6*(time_offset+i);
          Container cont;
          if(i==subject.durration-1){
            cont = Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color:cellColor.withOpacity(0.65),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  )
              ),
            );
          }else{
            cont = Container(
              alignment: Alignment.center,
              color:cellColor.withOpacity(0.65),
            );
          }
          cells[index2] = InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(subject: subject),
              ),
            ),
            child: cont,
          );
        }
      }
    }
  }

  Color getColor(Random random) {
    return Color.fromARGB(255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }


  Widget cellGenerator(int index){
    return Container(
      alignment: Alignment.center,
      decoration: boxGenerator(5),
    );
  }

  void addTimeAndDay(List<Widget>cells){
    //days
    cells[0] = Container(
      alignment: Alignment.center,
      decoration: boxGenerator(0),
    );
    cells[1] = Container(
      alignment: Alignment.center,
      decoration: boxGenerator(2),
      child: Text("MON"),
    );
    cells[2] = Container(
      alignment: Alignment.center,
      decoration: boxGenerator(2),
      child: Text("TUE"),
    );
    cells[3] = Container(
      alignment: Alignment.center,
      decoration: boxGenerator(2),
      child: Text("WED"),
    );
    cells[4] = Container(
      alignment: Alignment.center,
      decoration: boxGenerator(2),
      child: Text("THU"),
    );
    cells[5] = Container(
      alignment: Alignment.center,
      decoration: boxGenerator(2),
      child: Text("FRI"),
    );

    //time
    int start = 7;
    int konc = 8;
    String cas = "";
    for(int i = 1;i<16;i++){
      konc = start+1;
      cas = start.toString()+":00";
      if(start<10)
        cas = "0"+start.toString()+":00";
      cells[i*6]=Container(
        alignment: Alignment.center,
        decoration: boxGenerator(1),
        child: Text(cas),
      );
      start++;
    }

  }

  getVpisna() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'vpisna';
    final value = prefs.getString(key) ?? "";
    if(value!="")
      vpisna = value;
    print('read: $value');
  }


  @override
  void initState(){
    super.initState();
    getVpisna().then((result){
      //klele cekiras ce je vpisna podana in pol klices se getData pol sele setState, ce ni podana kar direkt setState
      if(vpisna!=""){
        getTimetable().then((result){
          setState(() {
            should_load=false;
          });
        });
      }else
        setState((){should_load=false;});
    });
  }

  @override
  Widget build(BuildContext context) {

    //generate initial grid elements
    List<Widget> cells = List.generate(96, (index) {
      return cellGenerator(index);
    });

    //add days and time
    addTimeAndDay(cells);
    //check if vpisna is set
    Widget bod;
    if(vpisna==""){
      bod= Center(child:Text("Please go to settings and set your identification number."));
    }else{
      //go through data and change cells
      addAllocations(cells);

      bod = GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 6,
        // Generate 100 widgets that display their index in the List.
        children: cells,
      );
    }
    if(should_load){
      bod = Center(child:CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text('FRI'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPageStateless()),
              ).then((res)=>getVpisna().then((result){
                //tuki pol se enkrat api call nardis, maybe treba dat da se loada
                getTimetable().then((result){
                  setState(() {
                  });
                });
              }));
            },
          ),
        ],
      ),
      body: bod,
    );
  }

}


class DetailsPage extends StatelessWidget {
  final SingleAllocation subject;

  // In the constructor, require a Todo.
  DetailsPage({Key key, @required this.subject}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int start = subject.startTime.hour;
    String startS = start.toString()+":00";
    if(start<10)
      startS = "0"+startS;
    int end = start+subject.durration;
    String endS = end.toString()+":00";
    if(end<10)
      endS = "0"+endS;
    List<String> labels = <String>["Title","Tag","Classroom","Duration","Start time","End time","Type","Teachers"];
    List<String> entries = <String>[subject.name,subject.tag,subject.classroom,subject.durration.toString()+"h",startS,endS,subject.type,subject.teachers];
    Widget lista = ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 45,
          color: Colors.red[200],
          child: Row(
            children: <Widget>[
              Expanded(child: Padding(padding:EdgeInsets.all(8.0),child:Text(labels[index],style: TextStyle(fontWeight: FontWeight.bold),))),
              Expanded(child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
              Expanded(child: Text(entries[index],style: TextStyle(fontWeight: FontWeight.bold),),),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text(subject.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: lista,
      ),
    );
  }
}

class SettingsPageStateless extends StatefulWidget{
  @override
  SettingsPage createState()=>SettingsPage();
}



class SettingsPage extends State<SettingsPageStateless> {
  final myController = TextEditingController();
  String _text = "";

  setVpisna(String vp) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'vpisna';
    final value = vp;
    prefs.setString(key, value);
    print('saved $value');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  showAlert(BuildContext context,bool saved) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert;
    if(saved){
      alert = AlertDialog(
        title: Text("Saved"),
        content: Text("Your identification number has been saved."),
        actions: [
          okButton,
        ],
      );
    }else{
      alert = AlertDialog(
        title: Text("Error"),
        content: Text("Your entered identification number is invalid. Please enter a valid one."),
        actions: [
          okButton,
        ],
      );
    }
    // set up the AlertDialog

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          keyboardType: TextInputType.number,
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          //print(myController.text);
          if(myController.text=="")
            showAlert(context, false);
          else
            setVpisna(myController.text).then((result){
              showAlert(context,true);
            });
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.save),
      ),
    );
  }

}

class SingleAllocation{
  String name;
  String tag;
  String classroom;
  int durration;
  TimeOfDay startTime;
  String type;
  //to je probs array, mal pozabu
  String teachers;
  SingleAllocation(String name,String tag,String classroom,int durration,TimeOfDay startTime,String type,String teachers){
    this.name = name;
    this.tag = tag;
    this.classroom = classroom;
    this.durration = durration;
    this.startTime = startTime;
    this.type = type;
    this.teachers = teachers;
  }
  @override
  String toString(){
    return "$name,$tag,$classroom,$durration,$startTime,$type,$teachers";
  }
}

class DayAllocations{
  String day;
  List<SingleAllocation> allocations;
  @override
  String toString(){
    return "$day: $allocations";
  }
}
