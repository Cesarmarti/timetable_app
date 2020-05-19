// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:collection';
import 'dart:math';
import 'package:random_color/random_color.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:html/parser.dart';

void main() => runApp(MyApp());

final storage = new FlutterSecureStorage();


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
  String token = "";
  bool should_load = true;
  bool should_load2 = true;
  var url = 'https://urnik.fri.uni-lj.si/timetable/fri-2019_2020-letni-1-9/allocations.json?student=';
  var baseUrl = "https://ucilnica.fri.uni-lj.si/";
  List<DayAllocations> timetable = new List<DayAllocations>();
  List<Event> events = new List<Event>();
  HashMap colorPicker = new HashMap<String, Color>();
  RandomColor _randomColor = RandomColor();

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

  getTimetable() async {
      var response = await http.get(url+vpisna+"&mode=ext");
      if (response.statusCode == 200) {
        List<DayAllocations> alloc = new List<DayAllocations>();
        var jsonResponse = convert.jsonDecode(response.body);
        var monday = jsonResponse['MON'];
        if(monday!=null){
          DayAllocations al1 = new DayAllocations();
          List<SingleAllocation> lista = new List<SingleAllocation>();
          for(var day in monday){
            var start = day['start'];
            var tag = day['tag'].replaceAll(new RegExp(r"\([0-9]*\)"),"");
            TimeOfDay _startTime = TimeOfDay(hour:int.parse(start.split(":")[0]),minute: int.parse(start.split(":")[1]));
            String teachers = "";
            for(var teacher in day['teachers'])
              teachers+=teacher;
            lista.add(new SingleAllocation(day['name'],tag,day['classroom'],day['durration'],_startTime,day['type'],teachers));

          }
          al1.day="MON";
          al1.allocations = lista;
          alloc.add(al1);
        }
        var tuesday = jsonResponse['TUE'];
        if(tuesday!=null){
          DayAllocations al1 = new DayAllocations();
          List<SingleAllocation> lista = new List<SingleAllocation>();
            for(var day in tuesday){
              var start = day['start'];
              var tag = day['tag'].replaceAll(new RegExp(r"\([0-9]*\)"),"");
              TimeOfDay _startTime = TimeOfDay(hour:int.parse(start.split(":")[0]),minute: int.parse(start.split(":")[1]));
              String teachers = "";
              for(var teacher in day['teachers'])
                teachers+=teacher;
              lista.add(new SingleAllocation(day['name'],tag,day['classroom'],day['durration'],_startTime,day['type'],teachers));

            }
            al1.day="TUE";
            al1.allocations = lista;
            alloc.add(al1);

        }
        var wednesday = jsonResponse['WED'];
        if(wednesday!=null){
          DayAllocations al1 = new DayAllocations();
          List<SingleAllocation> lista = new List<SingleAllocation>();
          for(var day in wednesday){
            var start = day['start'];
            var tag = day['tag'].replaceAll(new RegExp(r"\([0-9]*\)"),"");
            TimeOfDay _startTime = TimeOfDay(hour:int.parse(start.split(":")[0]),minute: int.parse(start.split(":")[1]));
            String teachers = "";
            for(var teacher in day['teachers'])
              teachers+=teacher;
            lista.add(new SingleAllocation(day['name'],tag,day['classroom'],day['durration'],_startTime,day['type'],teachers));

          }
          al1.day="WED";
          al1.allocations = lista;
          alloc.add(al1);
        }
        var thursday = jsonResponse['THU'];
        if(thursday!=null){
          DayAllocations al1 = new DayAllocations();
          List<SingleAllocation> lista = new List<SingleAllocation>();
          for(var day in thursday){
            var start = day['start'];
            var tag = day['tag'].replaceAll(new RegExp(r"\([0-9]*\)"),"");
            TimeOfDay _startTime = TimeOfDay(hour:int.parse(start.split(":")[0]),minute: int.parse(start.split(":")[1]));
            String teachers = "";
            for(var teacher in day['teachers'])
              teachers+=teacher;
            lista.add(new SingleAllocation(day['name'],tag,day['classroom'],day['durration'],_startTime,day['type'],teachers));

          }
          al1.day="THU";
          al1.allocations = lista;
          alloc.add(al1);
        }
        var friday = jsonResponse['FRI'];
        if(friday!=null){
          DayAllocations al1 = new DayAllocations();
          List<SingleAllocation> lista = new List<SingleAllocation>();
          for(var day in friday){
            var start = day['start'];
            var tag = day['tag'].replaceAll(new RegExp(r"\([0-9]*\)"),"");
            TimeOfDay _startTime = TimeOfDay(hour:int.parse(start.split(":")[0]),minute: int.parse(start.split(":")[1]));
            String teachers = "";
            for(var teacher in day['teachers'])
              teachers+=teacher;
            lista.add(new SingleAllocation(day['name'],tag,day['classroom'],day['durration'],_startTime,day['type'],teachers));

          }
          al1.day="FRI";
          al1.allocations = lista;
          alloc.add(al1);
        }
        //iterate over days and create list object

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
        /*DayAllocations al1 = new DayAllocations();
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
        alloc.add(al3);*/
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
        var sname = subject.name.split("_")[0];
        if(colorPicker.containsKey(sname)){
          cellColor = colorPicker[sname];
        }else{
          cellColor = _randomColor.randomColor();
          int c = 0;
          while(colorPicker.containsValue(cellColor)|| c<50){
            cellColor = _randomColor.randomColor();
            c++;
          }
          colorPicker[sname] = cellColor;
        }

        int time_offset;
        int startHour = subject.startTime.hour;
        time_offset = startHour-start;
        int index = day_offset+6*time_offset;
        BoxDecoration box = BoxDecoration(
            color:cellColor.withOpacity(0.50),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
        );
        if(subject.durration==1)
          box = BoxDecoration(
              color:cellColor.withOpacity(0.50),
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
                  color:cellColor.withOpacity(0.50),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  )
              ),
            );
          }else{
            cont = Container(
              alignment: Alignment.center,
              color:cellColor.withOpacity(0.50),
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
      decoration: BoxDecoration(
        border : Border(
            right: BorderSide( //                   <--- left side
              color: Colors.black,
              width: 1,
            ),
            bottom: BorderSide( //                    <--- right side
              color: Colors.black,
              width: 1,
            ),
      ),
    ),
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
    else
      vpisna = "";
    print('read id: $value');
  }

  String getDay(int day){
    switch(day){
      case 1:
        return "ponedeljek";
      case 2:
        return "torek";
      case 3:
        return "sreda";
      case 4:
        return "četrtek";
      case 5:
        return "petek";
      case 6:
        return "sobota";
      case 7:
        return "nedelja";
    }
  }

  final monthNames = ["januar", "februar", "marec", "april", "maj", "junij",
    "julij", "avgust", "september", "oktober", "november", "december"
  ];

  getEventData() async{
    List<Event> locEvents = new List<Event>();
    var danes = new DateTime.now();
    var start = new DateTime.now();
    if(token==null || token == "")
      return;
    for(int i = 0;i<7;i++){
      //print(start);
      String dan = (start.day).toString();
      String mesec = (start.month).toString();
      String leto = (start.year).toString();
      String endpoint = "webservice/rest/server.php?wstoken=$token&wsfunction=core_calendar_get_calendar_day_view&year=$leto&month=$mesec&day=$dan&moodlewsrestformat=json";
      var response = await http.get(baseUrl+endpoint);
      var jsonResponse = convert.jsonDecode(response.body);

      var is_Error=jsonResponse['error'];
      if(is_Error==null || is_Error==""){
        var events = jsonResponse['events'];

        for(var event in events){
          int time = event['timestart'];
          var date = new DateTime.fromMillisecondsSinceEpoch(time * 1000);
          if(date.isBefore(danes))
            continue;
          String timeString;
          if(danes.difference(date).inDays==0) {
            timeString = "Danes"+ ", " + (date.hour).toString() + ":" +
                (date.minute).toString();
          }else{
            timeString = getDay(date.weekday)+", "+(date.day).toString()+"."+monthNames[date.month]+", "+(date.hour).toString() + ":" +
                (date.minute).toString();
          }
          Event dogodek = new Event(event['name'],event['description'],event['eventtype'],date,timeString,event['course']['shortname'],event['course']['fullname']);
          locEvents.add(dogodek);
          //print(dogodek);
        }
      }else{
        print(convert.jsonDecode(response.body));
      }

      start = start.add(new Duration(days: 1));
    }
    events = locEvents;
  }

  getTokenApi(String username,String password) async{

    String endpoint = "login/token.php?username=$username&password=$password&service=moodle_mobile_app";
    //print(endpoint);
    var response = await http.get(baseUrl+endpoint);
    var is_Error=(convert.jsonDecode(response.body))['error'];
    if(is_Error==null || is_Error==""){
      var jsonResponse = convert.jsonDecode(response.body);
      String tok = jsonResponse['token'];
      token = tok;
      await storage.write(key: "token",value: tok);
    }else{
      print(convert.jsonDecode(response.body));
    }

  }

  getToken() async{
    String value = await storage.read(key: "token");
    //if token non existent, login
    final key = 'change';
    final prefs = await SharedPreferences.getInstance();
    bool change = prefs.getBool(key);
    if(value == null){
       String username = await storage.read(key: "username");
       String password = await storage.read(key: "password");
       if(username!=null && password !=null){
         await getTokenApi(username,password);
         prefs.setBool(key,false);
         //print("klic ker bil value nic, bool:"+change.toString());
       }else{
         token = "";
       }
    }else{
      if(change==null || change){
        String username = await storage.read(key: "username");
        String password = await storage.read(key: "password");
        if(username!=null && password !=null){
          await getTokenApi(username,password);
          prefs.setBool(key,false);
          //print("klic ker bil value ni bil nic, bool:"+change.toString());
        }else{
          token = "";
        }
      }else
      token = value;
    }
    //print(value);
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
    getToken().then((result){
      getEventData().then((result){
        setState((){
          should_load2 = false;
        });
      });
    });
  }

  updateUI() async{
    await getVpisna().then((result){
      //tuki pol se enkrat api call nardis, maybe treba dat da se loada
      getTimetable().then((result){
        setState(() {
          should_load=false;
        });
      });
    });
    await getToken().then((result){
      getEventData().then((result){
        setState((){
          should_load2=false;
        });
      });
    });

  }

//-----------------------------------------------
  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final event = events[i];
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
        Card(
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventPage(event: event),
                ),
              ),
            child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //Image.network(doodle.doodle),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(event.stringTime, style: textTheme.caption),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    event.name,
                    style: textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            )
          ),
        ),
        position:
        i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == events.length,
        icon: Icon(Icons.assignment),
        iconBackground: Colors.red[100],
        );
  }


  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: events.length,
      physics: position == TimelinePosition.Left
          ? ClampingScrollPhysics()
          : BouncingScrollPhysics(),
      position: position);


  Widget getTimeline(){
    final PageController pageController =
    PageController(initialPage: 0, keepPage: true);
    int pageIx = 0;
    List<Widget> pages = [
      timelineModel(TimelinePosition.Left),

    ];
    return PageView(
          onPageChanged: (i) => setState(() => pageIx = i),
          controller: pageController,
          children: pages,
        );
  }

//--------------------------------------------
  @override
  Widget build(BuildContext context) {


    //TAB1
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

      bod = Container(
          key: new PageStorageKey("Urnik"),
          margin: const EdgeInsets.only(right: 5.0),
          decoration: BoxDecoration(
            border : Border(right: BorderSide(color: Colors.black,width:1,)),
          ),
          child:GridView.count(

        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 6,
        // Generate 100 widgets that display their index in the List.
        children: cells,
      ));
    }
    if(should_load){
      bod = Center(child:CircularProgressIndicator());
    }

    //TAB2
    Widget bod2;
    if(token==""){
      bod2=Center(child:Text("Please go to settings and set your email and password."));
    }else{
      bod2= getTimeline();

    }
    if(should_load2){
      bod2 = Center(child:CircularProgressIndicator());
    }


    //main app part
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Settings',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPageStateless()),
                  ).then((res){should_load=true;should_load2=true;updateUI().then((result){
                    //tuki pol se enkrat api call nardis, maybe treba dat da se loada
                    setState(() {});
                  });});
                },
              ),
            ],
            backgroundColor: Colors.red[400],
            title: const Text('FRI'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.event_note)),
                Tab(icon: Icon(Icons.timeline)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              bod,
              bod2,
            ],
          ),
        ),
      ),
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



class EventPage extends StatelessWidget {
  final Event event;


  String parsesString(String htmlString){
    var document = parse(htmlString);
    return parse(document.body.text).documentElement.text;
  }

  // In the constructor, require a Todo.
  EventPage({Key key, @required this.event}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    List<String> labels = <String>["Title","Due date","Description","Type","Course name","Course tag"];
    List<String> entries = <String>[event.name,event.stringTime,parsesString(event.description),event.type,event.courseName,event.courseTag];
    Widget lista = ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          //height: 45,
          color: Colors.red[100],
          child: Row(
            children: <Widget>[
              Expanded(flex:2,child: Padding(padding:EdgeInsets.all(8.0),child:Text(labels[index],style: TextStyle(fontWeight: FontWeight.bold),))),
              Expanded(flex:1,child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
              Expanded(flex:7,child: Text(entries[index],style: TextStyle(fontWeight: FontWeight.bold),),),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text(event.courseTag),
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
  final myemail = TextEditingController();
  final mypass = TextEditingController();
  String _text = "";

  setVpisna(String vp) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'vpisna';
    final value = vp;
    prefs.setString(key, value);
    print('saved $value');
  }

  saveUserData(String email,String pass) async{
    String value = await storage.read(key: "username");
    final prefs = await SharedPreferences.getInstance();
    if(value!=email){
      await storage.write(key: "username", value: email);
      await storage.write(key: "password", value: pass);
      final key = 'change';
      prefs.setBool(key, true);
    }else{
      final key = 'change';
      prefs.setBool(key, false);
    }
  }

  clearData() async{
    await storage.deleteAll();
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myemail.dispose();
    mypass.dispose();
    super.dispose();
  }

  showAlert(BuildContext context,String header,String desc) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert;

      alert = AlertDialog(
        title: Text(header),
        content: Text(desc),
        actions: [
          okButton,
        ],
      );
    // set up the AlertDialog

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  /*
  * TextField(
          keyboardType: TextInputType.number,
          controller: myController,
        ),
  * */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(flex: 4,child: Padding(padding:EdgeInsets.all(8.0),child:Text("Identification number",style: TextStyle(fontWeight: FontWeight.bold),))),
                Expanded(flex: 1,child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                Expanded(flex: 5,child: Container(
                  decoration: BoxDecoration(
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
                    ),

                  child:TextField(
                  keyboardType: TextInputType.number,
                  controller: myController,
                ),),)
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(flex: 4,child: Padding(padding:EdgeInsets.all(8.0),child:Text("Email",style: TextStyle(fontWeight: FontWeight.bold),))),
                Expanded(flex: 1,child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                Expanded(flex: 5,child: Container(
                  decoration: BoxDecoration(
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
                  ),

                  child:TextField(
                    controller: myemail,
                  ),),)
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(flex: 4,child: Padding(padding:EdgeInsets.all(8.0),child:Text("Password",style: TextStyle(fontWeight: FontWeight.bold),))),
                Expanded(flex: 1,child: Text(":",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                Expanded(flex: 5,child: Container(
                  decoration: BoxDecoration(
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
                  ),

                  child:TextField(
                    obscureText: true,
                    controller: mypass,
                  ),),)
              ],
            ),
          ),
          FlatButton(
            color: Colors.grey[200],
            onPressed: () {
              clearData().then((result){
                showAlert(context, "Data cleared", "Your data has been cleared.");
              });
            },
            child: Text(
              "Clear saved data",
            ),
          )
        ])
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          //print(myController.text);
          String vp_text = myController.text;
          String email_text = myemail.text;
          String pass_text = mypass.text;
          if(vp_text!=""||email_text!=""||pass_text!=""){
            if((email_text!=""&&pass_text=="")||(email_text==""&&pass_text!="")){
              showAlert(context, "Error","Please enter email and password together.");
            }else if(email_text!=""&&pass_text!=""){
              saveUserData(email_text,pass_text).then((res){
                if(vp_text!=""){
                  setVpisna(vp_text).then((result){
                    showAlert(context,"Saved","Your data has been saved.");
                  });
                }else{
                  showAlert(context,"Saved","Your user data has been saved.");
                }
              });
            }else if(vp_text!=""&&email_text==""||pass_text==""){
              setVpisna(vp_text).then((result){
                showAlert(context,"Saved","Your identification number has been saved has been saved.");
              });
            }
          }

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

class Event{
  String name;
  String description;
  String type;
  DateTime time;
  String stringTime;
  String courseTag;
  String courseName;
  @override

  Event(String name,String description,String type,DateTime time,String stringTime,String courseTag,String courseName){
    this.name=name;
    this.description=description;
    this.type = type;
    this.time = time;
    this.stringTime = stringTime;
    this.courseTag = courseTag;
    this.courseName = courseName;
  }

  String toString(){
    return "$name,desc,$stringTime,$courseName,$courseTag";
  }
}